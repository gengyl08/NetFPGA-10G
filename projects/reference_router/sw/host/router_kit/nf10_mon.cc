//-----------------------------------------------------------------------------
// File: nf10_mon.cc
// Date:
//
// Description:
//
//-----------------------------------------------------------------------------

#include "nf10_mon.hh"

#include <stdio.h>
#include <fcntl.h>

using namespace rk;
using namespace std;

//-----------------------------------------------------------------------------
nf10_mon::nf10_mon()
{
	nf = open("/dev/nf10", O_RDWR);

	if (nf < 0) {
		perror("ERROR opening device /dev/nf10\n");
		return;
	}

  clear_hw_rtable();
  clear_hw_arptable();
  clear_dst_filter_rtable();

	// Assumption here that interface name will always be nfX
	int base = atoi(&(this->interface[4]));
	char iface_name[32] = "nf";
	sprintf(&(iface_name[2]), "%i", base);
    devtoport[iface_name] = 1;
	sprintf(&(iface_name[2]), "%i", base+1);
    devtoport[iface_name] = 4;
	sprintf(&(iface_name[2]), "%i", base+2);
    devtoport[iface_name] = 16;
	sprintf(&(iface_name[2]), "%i", base+3);
    devtoport[iface_name] = 64;

}
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
void
nf10_mon::rtable_update(const rtable& rt_)
{
    rtable local;
    for(size_t i = 0; i < rt_.size(); ++i){
        if (devtoport.find(rt_[i].dev) != devtoport.end()){
            local.add(rt_[i]);
        }
    }

    if(rt != local){
        // update routing table
        update_routing_table(local);
    }

    rt = local;
}
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
void
nf10_mon::arptable_update(const arptable& at_)
{
    arptable local;
    for(size_t i = 0; i < at_.size(); ++i){
        if (devtoport.find(at_[i].dev) != devtoport.end()){
            local.add(at_[i]);
        }
    }

    if(at != local){
        // update arpcache
        update_arp_table(local);
    }

    at = local;
}
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
void
nf10_mon::interface_update(const iflist& ifl_)
{
    iflist local;
    for(size_t i = 0; i < ifl_.size(); ++i){
        if (devtoport.find(ifl_[i].name) != devtoport.end()){
            local.add_entry(ifl_[i]);
        }
    }

    if(!(ifl == local)){
        // update interface routing table
        update_interface_table(local);
    }

    ifl = local;
}
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
void
nf10_mon::clear_dst_filter_rtable()
{
    for(size_t i = 0; i < FIXME_DST_FILTER_MAX; ++i){
        writeReg(nf, ROUTER_OP_LUT_DST_IP_FILTER_TABLE_ENTRY_IP_REG, 0);
        writeReg(nf, ROUTER_OP_LUT_DST_IP_FILTER_TABLE_WR_ADDR_REG, i);
    }
}
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
void
nf10_mon::clear_hw_rtable()
{
    for(size_t i = 0; i < FIXME_RT_MAX; ++i){
        writeReg(nf, ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_IP_REG,          0);
        writeReg(nf, ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_MASK_REG,        0xffffffff);
        writeReg(nf, ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_NEXT_HOP_IP_REG, 0);
        writeReg(nf, ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_OUTPUT_PORT_REG, 0);
        writeReg(nf, ROUTER_OP_LUT_ROUTE_TABLE_WR_ADDR_REG, i);
    }
}
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
void
nf10_mon::clear_hw_arptable()
{
    for(size_t i = 0; i < FIXME_ARP_MAX; ++i){
        writeReg(nf, ROUTER_OP_LUT_ARP_TABLE_ENTRY_NEXT_HOP_IP_REG,0);
        writeReg(nf, ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_HI_REG,0);
        writeReg(nf, ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_LO_REG,0);
        writeReg(nf, ROUTER_OP_LUT_ARP_TABLE_WR_ADDR_REG, 1);
    }
}
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
void
nf10_mon::nf_set_mac(const uint8_t* addr, int index)
{
    uint32_t mac_hi = 0;
    uint32_t mac_lo = 0;

    mac_hi |= ((unsigned int)addr[0]) << 8;
    mac_hi |= ((unsigned int)addr[1]);

    mac_lo |= ((unsigned int)addr[2]) << 24;
    mac_lo |= ((unsigned int)addr[3]) << 16;
    mac_lo |= ((unsigned int)addr[4]) << 8;
    mac_lo |= ((unsigned int)addr[5]);

    switch(index)
    {
        case 0:
            writeReg(nf, ROUTER_OP_LUT_MAC_0_HI_REG, mac_hi);
            writeReg(nf, ROUTER_OP_LUT_MAC_0_LO_REG, mac_lo);
            break;

        case 1:
            writeReg(nf, ROUTER_OP_LUT_MAC_1_HI_REG, mac_hi);
            writeReg(nf, ROUTER_OP_LUT_MAC_1_LO_REG, mac_lo);
            break;

        case 2:
            writeReg(nf, ROUTER_OP_LUT_MAC_2_HI_REG, mac_hi);
            writeReg(nf, ROUTER_OP_LUT_MAC_2_LO_REG, mac_lo);
            break;
        case 3:
            writeReg(nf, ROUTER_OP_LUT_MAC_3_HI_REG, mac_hi);
            writeReg(nf, ROUTER_OP_LUT_MAC_3_LO_REG, mac_lo);
            break;
        default:
            printf("Unknown port, Failed to write hardware registers\n");
            break;
    }
}
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
void
nf10_mon::update_interface_table(const iflist& newlist)
{

    // Delete old entries ....
    for(size_t i = 0; i < ifl.size(); ++i){
        writeReg(nf, ROUTER_OP_LUT_DST_IP_FILTER_TABLE_ENTRY_IP_REG, 0);
        writeReg(nf, ROUTER_OP_LUT_DST_IP_FILTER_TABLE_WR_ADDR_REG, i);
    }

    // Create new entries ....
    size_t i = 0;
    for(; i < newlist.size(); ++i){
        // set IP address in hardware
        writeReg(nf, ROUTER_OP_LUT_DST_IP_FILTER_TABLE_ENTRY_IP_REG, htonl(newlist[i].ip.addr));
        writeReg(nf, ROUTER_OP_LUT_DST_IP_FILTER_TABLE_WR_ADDR_REG, i);

        // set MAC address in hardware
        nf_set_mac(&(newlist[i].etha.octet[0]), i);
    }

    // Also add the OSPF ip
    ipaddr ospf("224.0.0.5");
    writeReg(nf, ROUTER_OP_LUT_DST_IP_FILTER_TABLE_ENTRY_IP_REG, htonl(ospf.addr));
    writeReg(nf, ROUTER_OP_LUT_DST_IP_FILTER_TABLE_WR_ADDR_REG, i);
}
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
void
nf10_mon::update_routing_table(const rtable& newrt)
{
    // Delete old entries ....
    for(size_t i = 0; i < rt.size(); ++i){
        writeReg(nf, ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_IP_REG,          0);
        writeReg(nf, ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_MASK_REG,        0xffffffff);
        writeReg(nf, ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_NEXT_HOP_IP_REG, 0);
        writeReg(nf, ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_OUTPUT_PORT_REG, 0);
        writeReg(nf, ROUTER_OP_LUT_ROUTE_TABLE_WR_ADDR_REG, i);
    }

    // Create new entries ....
    size_t i = 0;
    for(; i < newrt.size(); ++i){

        writeReg(nf, ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_IP_REG,          htonl(newrt[i].dest.addr));
        writeReg(nf, ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_MASK_REG,        htonl(newrt[i].mask.addr));
        writeReg(nf, ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_NEXT_HOP_IP_REG, htonl(newrt[i].gw.addr));

        writeReg(nf, ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_OUTPUT_PORT_REG, devtoport[newrt[i].dev]);
        writeReg(nf, ROUTER_OP_LUT_ROUTE_TABLE_WR_ADDR_REG, i);
    }

}
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
void
nf10_mon::update_arp_table(const arptable& newat)
{
    for(size_t i = 0; i < at.size(); ++i){
        writeReg(nf, ROUTER_OP_LUT_ARP_TABLE_ENTRY_NEXT_HOP_IP_REG, 0);
        writeReg(nf, ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_HI_REG, 0);
        writeReg(nf, ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_LO_REG, 0);
        writeReg(nf, ROUTER_OP_LUT_ARP_TABLE_WR_ADDR_REG, i);
    }

    // Create new entries ....
    size_t i = 0;
    for(; i < newat.size(); ++i){
        writeReg(nf, ROUTER_OP_LUT_ARP_TABLE_ENTRY_NEXT_HOP_IP_REG, ntohl(newat[i].ip.addr));
        writeReg(nf, ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_HI_REG, newat[i].etha.octet[0] << 8 | newat[i].etha.octet[1]);
        writeReg(nf, ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_LO_REG, newat[i].etha.octet[2] << 24 |
                                                     newat[i].etha.octet[3] << 16 |
                                                     newat[i].etha.octet[4] << 8  |
                                                     newat[i].etha.octet[5]);
        writeReg(nf, ROUTER_OP_LUT_ARP_TABLE_WR_ADDR_REG, i);
    }

}
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
void
nf10_mon::sync_routing_table()
{
}
//-----------------------------------------------------------------------------
