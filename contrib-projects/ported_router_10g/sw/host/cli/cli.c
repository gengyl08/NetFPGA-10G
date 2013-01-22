/* ****************************************************************************
 * $Id: cli.c 5456 2013-01-21 11:50:55Z g9coving, Gianni Antichi $
 *
 * Module: cli.c
 * Description: Manage the NetFPGA router's ARP and IP tables.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>

#include <net/if.h>

#include <time.h>
#include <inttypes.h>

#include <netlink/netlink.h>
#include "defines.h"

static unsigned MAC_HI_REGS[] = {
  ROUTER_OP_LUT_MAC_0_HI_REG,
  ROUTER_OP_LUT_MAC_1_HI_REG,
  ROUTER_OP_LUT_MAC_2_HI_REG,
  ROUTER_OP_LUT_MAC_3_HI_REG
};

static unsigned MAC_LO_REGS[] = {
  ROUTER_OP_LUT_MAC_0_LO_REG,
  ROUTER_OP_LUT_MAC_1_LO_REG,
  ROUTER_OP_LUT_MAC_2_LO_REG,
  ROUTER_OP_LUT_MAC_3_LO_REG
};

/* Function declarations */
void prompt (void);
void help (void);
int  parse (char *);
void board (void);
void setip (void);
void setarp (void);
void setmac (void);
void listip (void);
void listarp (void);
void listmac (void);
void loadip (void);
void loadarp (void);
void loadmac (void);
void clearip (void);
void cleararp (void);
void showq(void);
uint8_t *parseip(char *str);
uint8_t * parsemac(char *str);

int main(int argc, char *argv[])
{
 
  prompt();

  return 0;
}


void prompt(void) {
  while (1) {
    printf("> ");
    char c[10], d[10], e[10], f[10];
    scanf("%s", c);
    int res = parse(c);
    switch (res) {
    case 0:
      listip();
      break;
    case 1:
      listarp();
      break;
    case 2:
      setip();
      break;
    case 3:
      setarp();
      break;
    case 4:
      loadip();
      break;
    case 5:
      loadarp();
      break;
    case 6:
      clearip();
      break;
    case 7:
      cleararp();
      break;
    case 12:
      listmac();
      break;
    case 13:
      setmac();
      break;
    case 14:
      loadmac();
      break;
    case 8:
      help();
      break;
    case 9:
      return;
    default:
      printf("Unknown command, type 'help' for list of commands\n");
    }
  }
}

void help(void) {
  printf("Commands:\n");
  printf("  listip        - Lists entries in IP routing table\n");
  printf("  listarp       - Lists entries in the ARP table\n");
  printf("  listmac       - Lists the MAC addresses of the router ports\n");
  printf("  setip         - Set an entry in the IP routing table\n");
  printf("  setarp        - Set an entry in the ARP table\n");
  printf("  setmac        - Set the MAC address of a router port\n");
  printf("  loadip        - Load IP routing table entries from a file\n");
  printf("  loadarp       - Load ARP table entries from a file\n");
  printf("  loadmac       - Load MAC addresses of router ports from a file\n");
  printf("  clearip       - Clear an IP routing table entry\n");
  printf("  cleararp      - Clear an ARP table entry\n");
  printf("  help          - Displays this list\n");
  printf("  quit          - Exit this program\n");
}


void addmac(int port, uint8_t *mac) {
  // adjust port 1-4 to be an array index 0-3
  int err;
  port--;

  err=nf10_reg_wr(MAC_HI_REGS[port], mac[0] << 8 | mac[1]);
  if(err) printf("0x%08x: ERROR: %s\n", MAC_HI_REGS[port], nl_geterror(err));
  err=nf10_reg_wr(MAC_LO_REGS[port], mac[2] << 24 | mac[3] << 16 | mac[4] << 8 | mac[5]);
  if(err) printf("0x%08x: ERROR: %s\n", MAC_LO_REGS[port], nl_geterror(err));
}

void addarp(int entry, uint8_t *ip, uint8_t *mac) {
  int err;

  err=nf10_reg_wr(ROUTER_OP_LUT_ARP_TABLE_ENTRY_NEXT_HOP_IP_REG, ip[0] << 24 | ip[1] << 16 | ip[2] << 8 | ip[3]);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_TABLE_ENTRY_NEXT_HOP_IP_REG, nl_geterror(err));
  err=nf10_reg_wr(ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_HI_REG,  mac[0] << 8 | mac[1]);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_HI_REG, nl_geterror(err));
  err=nf10_reg_wr(ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_LO_REG, mac[2] << 24 | mac[3] << 16 | mac[4] << 8 | mac[5]);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_LO_REG, nl_geterror(err));
  err=nf10_reg_wr(ROUTER_OP_LUT_ARP_TABLE_WR_ADDR_REG, entry);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_TABLE_WR_ADDR_REG, nl_geterror(err));
}

void addip(int entry, uint8_t *subnet, uint8_t *mask, uint8_t *nexthop, int port) {
  int err;

  err=nf10_reg_wr(ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_IP_REG, subnet[0] << 24 | subnet[1] << 16 | subnet[2] << 8 | subnet[3]);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_IP_REG, nl_geterror(err));
  err=nf10_reg_wr(ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_MASK_REG, mask[0] << 24 | mask[1] << 16 | mask[2] << 8 | mask[3]);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_MASK_REG, nl_geterror(err));
  err=nf10_reg_wr(ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_NEXT_HOP_IP_REG, nexthop[0] << 24 | nexthop[1] << 16 | nexthop[2] << 8 | nexthop[3]);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_NEXT_HOP_IP_REG, nl_geterror(err));
  err=nf10_reg_wr(ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_OUTPUT_PORT_REG, port);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_OUTPUT_PORT_REG, nl_geterror(err));
  err=nf10_reg_wr(ROUTER_OP_LUT_ROUTE_TABLE_WR_ADDR_REG, entry);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_WR_ADDR_REG, nl_geterror(err));
}

void setip(void) {
  printf("Enter [entry] [subnet]      [mask]       [nexthop] [port]:\n");
  printf("e.g.     0   192.168.1.0  255.255.255.0  15.1.3.1     4:\n");
  printf(">> ");

  char subnet[15], mask[15], nexthop[15];
  int port, entry;
  scanf("%i %s %s %s %x", &entry, subnet, mask, nexthop, &port);

  if ((entry < 0) || (entry > (ROUTER_OP_LUT_ROUTE_TABLE_DEPTH-1))) {
    printf("Entry must be between 0 and 31. Aborting\n");
    return;
  }

  if ((port < 1) || (port > 255)) {
    printf("Port must be between 1 and ff.  Aborting\n");
    return;
  }

  uint8_t *sn = parseip(subnet);
  uint8_t *m = parseip(mask);
  uint8_t *nh = parseip(nexthop);

  addip(entry, sn, m, nh, port);
}

void setarp(void) {
  printf("Enter [entry] [ip] [mac]:\n");
  printf(">> ");

  char nexthop[15], mac[30];
  int entry;
  scanf("%i %s %s", &entry, nexthop, mac);

  if ((entry < 0) || (entry > (ROUTER_OP_LUT_ARP_TABLE_DEPTH-1))) {
    printf("Entry must be between 0 and 31. Aborting\n");
    return;
  }

  uint8_t *nh = parseip(nexthop);
  uint8_t *m = parsemac(mac);

  addarp(entry, nh, m);
}

void setmac(void) {
  printf("Enter [port] [mac]:\n");
  printf(">> ");

  char mac[30];
  int port;
  scanf("%i %s", &port, mac);

  if ((port < 1) || (port > 4)) {
    printf("Port must be between 1 and 4. Aborting\n");
    return;
  }

  uint8_t *m = parsemac(mac);

  addmac(port, m);
}

void listip(void) {
  int i;
  int err;
  for (i = 0; i < ROUTER_OP_LUT_ROUTE_TABLE_DEPTH; i++) {
    unsigned subnet, mask, nh, valport;

    err=nf10_reg_wr(ROUTER_OP_LUT_ROUTE_TABLE_RD_ADDR_REG, i);
    if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_RD_ADDR_REG, nl_geterror(err));
    err=nf10_reg_rd(ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_IP_REG, &subnet);
    if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_IP_REG, nl_geterror(err));
    err=nf10_reg_rd(ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_MASK_REG, &mask);
    if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_MASK_REG, nl_geterror(err));
    err=nf10_reg_rd(ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_NEXT_HOP_IP_REG, &nh);
    if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_NEXT_HOP_IP_REG, nl_geterror(err));
    err=nf10_reg_rd(ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_OUTPUT_PORT_REG, &valport);
    if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_OUTPUT_PORT_REG, nl_geterror(err));

    printf("Entry #%i:   ", i);
    int port = valport & 0xff;
    if (subnet!=0 || mask!=0xffffffff || port!=0) {
      printf("Subnet: %i.%i.%i.%i, ", subnet >> 24, (subnet >> 16) & 0xff, (subnet >> 8) & 0xff, subnet & 0xff);
      printf("Mask: 0x%x, ", mask);
      printf("Next Hop: %i.%i.%i.%i, ", nh >> 24, (nh >> 16) & 0xff, (nh >> 8) & 0xff, nh & 0xff);
      printf("Port: 0x%02x\n", port);
    }
    else {
      printf("--Invalid--\n");
    }
  }
}

void listarp(void) {
  int i = 0;
  int err;
  for (i = 0; i < ROUTER_OP_LUT_ARP_TABLE_DEPTH; i++) {
    unsigned ip, machi, maclo;

    err=nf10_reg_wr(ROUTER_OP_LUT_ARP_TABLE_RD_ADDR_REG, i);
    if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_TABLE_RD_ADDR_REG, nl_geterror(err));
    err=nf10_reg_rd(ROUTER_OP_LUT_ARP_TABLE_ENTRY_NEXT_HOP_IP_REG, &ip);
    if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_TABLE_ENTRY_NEXT_HOP_IP_REG, nl_geterror(err));
    err=nf10_reg_rd(ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_HI_REG, &machi);
    if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_HI_REG, nl_geterror(err));
    err=nf10_reg_rd(ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_LO_REG, &maclo);
    if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_LO_REG, nl_geterror(err));

    printf("Entry #%i:   ", i+1);
    if (ip!=0) {
      printf("IP: %i.%i.%i.%i, ", ip >> 24, (ip >> 16) & 0xff, (ip >> 8) & 0xff, ip & 0xff);
      printf("MAC: %x:%x:%x:%x:%x:%x\n", (machi >> 8) & 0xff, machi & 0xff,
              (maclo >> 24) & 0xff, (maclo >> 16) & 0xff,
              (maclo >> 8) & 0xff, (maclo) & 0xff);
    }
    else {
      printf("--Invalid--\n");
    }
  }
}

void listmac(void) {
  int i = 0;
  int err;
  for (i = 0; i < 4; i++) {
    unsigned ip, machi, maclo;

    err=nf10_reg_rd(MAC_HI_REGS[i], &machi);
    if(err) printf("0x%08x: ERROR: %s\n", MAC_HI_REGS[i], nl_geterror(err));
    err=nf10_reg_rd(MAC_LO_REGS[i], &maclo);
    if(err) printf("0x%08x: ERROR: %s\n", MAC_LO_REGS[i], nl_geterror(err));

    printf("Port #%i:   ", i+1);
    if (ip!=0) {
      printf("MAC: %x:%x:%x:%x:%x:%x\n", (machi >> 8) & 0xff, machi & 0xff,
              (maclo >> 24) & 0xff, (maclo >> 16) & 0xff,
              (maclo >> 8) & 0xff, (maclo) & 0xff);
    }
    else {
      printf("--Invalid--\n");
    }
  }
}

void loadip(void) {
  char fn[30];
  printf("Enter filename:\n");
  printf(">> ");
  scanf("%s", fn);

  FILE *fp;
  char subnet[20], mask[20], nexthop[20];
  int entry, port;
  if((fp = fopen(fn, "r")) ==NULL) {
    printf("Error: cannot open file %s.\n", fn);
    return;
  }
  while (fscanf(fp, "%i %s %s %s %x", &entry, subnet, mask, nexthop, &port) != EOF) {
    uint8_t *sn = parseip(subnet);
    uint8_t *m = parseip(mask);
    uint8_t *nh = parseip(nexthop);

    addip(entry, sn, m, nh, port);
  }
}

void loadarp(void) {
  char fn[30];
  printf("Enter filename:\n");
  printf(">> ");
  scanf("%s", fn);

  FILE *fp = fopen(fn, "r");
  char ip[20], mac[20];
  int entry;
  while (fscanf(fp, "%i %s %s", &entry, ip, mac) != EOF) {
    uint8_t *i = parseip(ip);
    uint8_t *m = parsemac(mac);

    addarp(entry, i, m);
  }
}

void loadmac(void) {
  char fn[30];
  printf("Enter filename:\n");
  printf(">> ");
  scanf("%s", fn);

  FILE *fp = fopen(fn, "r");
  char mac[20];
  int port;
  while (fscanf(fp, "%i %s", &port, mac) != EOF) {
    uint8_t *m = parsemac(mac);

    addmac(port, m);
  }
}

void clearip(void) {
  int entry;
  int err;
  printf("Specify entry:\n");
  printf(">> ");
  scanf("%i", &entry);

  err=nf10_reg_wr(ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_IP_REG, 0);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_IP_REG, nl_geterror(err));
  err=nf10_reg_wr(ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_MASK_REG, 0xffffffff);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_MASK_REG, nl_geterror(err));
  err=nf10_reg_wr(ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_NEXT_HOP_IP_REG, 0);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_NEXT_HOP_IP_REG, nl_geterror(err));
  err=nf10_reg_wr(ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_OUTPUT_PORT_REG, 0);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_ENTRY_OUTPUT_PORT_REG, nl_geterror(err));
  err=nf10_reg_wr(ROUTER_OP_LUT_ROUTE_TABLE_WR_ADDR_REG, entry);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ROUTE_TABLE_WR_ADDR_REG, nl_geterror(err));
 
}

void cleararp(void) {
  int entry;
  int err;
  printf("Specify entry:\n");
  printf(">> ");
  scanf("%i", &entry);

  err=nf10_reg_wr(ROUTER_OP_LUT_ARP_TABLE_ENTRY_NEXT_HOP_IP_REG, 0);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_TABLE_ENTRY_NEXT_HOP_IP_REG, nl_geterror(err));
  err=nf10_reg_wr(ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_HI_REG, 0);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_HI_REG, nl_geterror(err));
  err=nf10_reg_wr(ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_LO_REG, 0);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_TABLE_ENTRY_MAC_LO_REG, nl_geterror(err));
  err=nf10_reg_wr(ROUTER_OP_LUT_ARP_TABLE_WR_ADDR_REG, entry);
  if(err) printf("0x%08x: ERROR: %s\n", ROUTER_OP_LUT_ARP_TABLE_WR_ADDR_REG, nl_geterror(err));

}


int parse(char *word) {
  if (!strcmp(word, "listip"))
    return 0;
  if (!strcmp(word, "listarp"))
    return 1;
  if (!strcmp(word, "setip"))
    return 2;
  if (!strcmp(word, "setarp"))
    return 3;
  if (!strcmp(word, "loadip"))
    return 4;
  if (!strcmp(word, "loadarp"))
    return 5;
  if (!strcmp(word, "clearip"))
    return 6;
  if (!strcmp(word, "cleararp"))
    return 7;
  if (!strcmp(word, "listmac"))
    return 12;
  if (!strcmp(word, "setmac"))
    return 13;
  if (!strcmp(word, "loadmac"))
    return 14;
  if (!strcmp(word, "help"))
    return 8;
  if (!strcmp(word, "quit"))
    return 9;
  return -1;
}

uint8_t * parseip(char *str) {
  uint8_t *ret = (uint8_t *)malloc(4 * sizeof(uint8_t));
  char *num = (char *)strtok(str, ".");
  int index = 0;
  while (num != NULL) {
    ret[index++] = atoi(num);
    num = (char *)strtok(NULL, ".");
  }
  return ret;
}


uint8_t * parsemac(char *str) {
        uint8_t *ret = (uint8_t *)malloc(6 * sizeof(char));
        char *num = (char *)strtok(str, ":");
        int index = 0;
        while (num != NULL) {
                int i;
                sscanf(num, "%x", &i);
                ret[index++] = i;
                num = (char *)strtok(NULL, ":");
        }
        return ret;
}

