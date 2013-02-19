//-----------------------------------------------------------------------------
// File:   nf10_mon.hh
// Date:   Sun Apr 29 19:36:57 PDT 2007
// Author: Martin Casado
//
// Description:
//
// Monitor NetFPGA 10 board, update timers and syncronize routing and arp
// table.
//
//-----------------------------------------------------------------------------

#ifndef NF10_MON_HH__
#define NF10_MON_HH__

#include "rtable.hh"
#include "iflist.hh"
#include "arptable.hh"

#include <map>

extern "C"
{
#include "reg_defines.h"
#include "common/nf10util.h"
}


namespace rk
{

static const char NF_DEV_PREFIX[]  = "nf";
static const char NF_DEFAULT_DEV[] = "nf10";

class nf10_mon
{
  public:

    static const unsigned int FIXME_RT_MAX         = 32;
    static const unsigned int FIXME_ARP_MAX        = 32;
    static const unsigned int FIXME_DST_FILTER_MAX = 32;

	protected:
		// base NF2 interface name
		char interface[32];

    int nf;

    std::map<std::string,int> devtoport;
    std::map<int,std::string> porttodev;

		// SW copies of hardware routing and forwarding table
		rtable   rt;
		arptable at;

    // SW copy of interfacelist ... we're only interested
    // in keeping track of nf interfaces
    iflist   ifl;


    // Utility
    void update_interface_table(const iflist&);
    void update_routing_table  (const rtable&);
    void update_arp_table      (const arptable&);
    void nf_set_mac(const uint8_t* addr, int index);

    void clear_dst_filter_rtable();
    void clear_hw_rtable();
    void clear_hw_arptable();

    void sync_routing_table();

	public:

		nf10_mon(); //char* interface);

    // --
    // Events
    // --
		void rtable_update   (const rtable& rt);
		void arptable_update (const arptable& at);
		void interface_update(const iflist& at);

};


} // -- namespace rk

#endif  // -- NF10_MON_HH__
