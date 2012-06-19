#!/usr/bin/env python26

""" Values for Match Fields"""
dl_vlantag = "FFFF"
nw_tos = "00"
src_port = "00"
dl_src = "F00DF00DF00D"
dl_dst = "BABEBABEBABE"
dl_ethtype = "0800"
nw_src = "CCCCCCCC"
nw_dst = "DDDDDDDD"
nw_proto = "06"
tp_src = "CB1C"
tp_dst = "CB1C"

""" Values for Mask Fields """
mask_dl_vlantag = "0000"
mask_nw_tos = "00"
mask_src_port = "00"
mask_dl_src = "000000000000"
mask_dl_dst = "000000000000"
mask_dl_ethtype = "0000"
mask_nw_src = "00000000"
mask_nw_dst = "00000000"
mask_nw_proto = "00"
mask_tp_src = "0000"
mask_tp_dst = "0000"

""" Values for Action Fields """
forward_bitmask = "005d"
nf2_action_flag = "0101"
set_vlan_vid = "2345"
set_vlan_pcp = "01"
set_dl_src = "789abcdef012"
set_dl_dst = "bcdef0123456"
set_nw_src = "3456789a"
set_nw_dst = "bcdef012"
set_nw_tos = "9a"
set_tp_src = "5678"
set_tp_dst = "1234"

""" Values for Stats Fields """
stats_word0 = "01234567"
stats_word1 = "89abcdef"

""" Entry Address """
entry_addr = "00000355"

""" Write Order Address """
wr_order_addr = "7a01001f"

""" No need to touch below """

""" nf2_action_flag
#define NF2_OFPAT_OUTPUT                          0x0001
#define NF2_OFPAT_SET_VLAN_VID                    0x0002
#define NF2_OFPAT_SET_VLAN_PCP                    0x0004
#define NF2_OFPAT_STRIP_VLAN                      0x0008
#define NF2_OFPAT_SET_DL_SRC                      0x0010
#define NF2_OFPAT_SET_DL_DST                      0x0020
#define NF2_OFPAT_SET_NW_SRC                      0x0040
#define NF2_OFPAT_SET_NW_DST                      0x0080
#define NF2_OFPAT_SET_NW_TOS                      0x0100
#define NF2_OFPAT_SET_TP_SRC                      0x0200
#define NF2_OFPAT_SET_TP_DST                      0x0400
"""

def entry_write(match, mask, action, stats, f):
    base_addr  = 0x7a010022
    entry_word = []
    match_word = []
    mask_word = []
    action_word = []
    stats_word = []
    for i in range(0, len(match)/8):
        match_word.append(match[(len(match)-(i+1)*8) : (len(match)-i*8)])
    for i in range(0, len(mask)/8):
        mask_word.append(mask[(len(mask)-(i+1)*8) : (len(mask)-i*8)])
    for i in range(0, len(action)/8):
        action_word.append(action[(len(action)-(i+1)*8) : (len(action)-i*8)])
    for i in range(0, len(stats)/8):
        stats_word.append(stats[i*8 : (i+1)*8])
    entry_word = match_word + mask_word + action_word + stats_word
    terminal = "."
    for i in range(len(entry_word)):
        f.write( '%s, %s, %s, %s%s\n' % (
                str(hex(base_addr + i))[2:],
                entry_word[i],
                "f",
                "-",
                terminal) )

def entry_read(f):
    base_addr = 0x7a010022
    len = 8 + 8 + 10 + 2
    for i in range(len):
        terminal = "."
        f.write( '%s, %s, %s, %s%s\n' % (
                "-",
                "-",
                "-",
                str(hex(base_addr + i))[2:],
                terminal) )

def reg_write(addr, val, f):
    terminal = "."
    f.write( '%s, %s, %s, %s%s\n' % (
            addr,
            val,
            "f",
            "-",
            terminal) )

def reg_read(addr, f):
    terminal = "."
    f.write( '%s, %s, %s, %s%s\n' % (
            "-",
            "-",
            "-",
            addr,
            terminal) )


padding = "00"
match = (padding + dl_vlantag + nw_tos + src_port +
         dl_src + dl_dst + dl_ethtype +
         nw_src + nw_dst + nw_proto + tp_src + tp_dst)

mask = (padding + mask_dl_vlantag + mask_nw_tos + mask_src_port +
        mask_dl_src + mask_dl_dst + mask_dl_ethtype +
        mask_nw_src + mask_nw_dst + mask_nw_proto +
        mask_tp_src + mask_tp_dst)

action_pre = (padding*8 + set_tp_dst + set_tp_src + set_nw_tos +
              set_nw_dst + set_nw_src + set_dl_dst + set_dl_src +
              set_vlan_pcp + set_vlan_vid + nf2_action_flag +
              forward_bitmask)
for i in range(len(action_pre)/8):
    if (i == 0):
       action = action_pre[i*8 : (i+1)*8]
    else:
       action = action + action_pre[i*8 : (i+1)*8] 

stats = stats_word0 + stats_word1

f = open("reg_stim.axi", "w")

""" Set Entry Table Address """
reg_write("7a01001e", entry_addr, f)

""" Write Entry to buffer """
entry_write(match, mask, action, stats, f)

""" Set Write order """
reg_write(wr_order_addr, "00000001", f)

""" Check Ready Register """ 
reg_read("7a01001d", f)
reg_read("7a01001d", f)
reg_read("7a01001d", f)
reg_read("7a01001d", f)
reg_read("7a01001d", f)

""" Read the stats from the same location """
reg_write("7a01001e", entry_addr, f)
reg_write("7a010021", "00000001", f)

""" Check Ready Register """ 
reg_read("7a01001d", f)
reg_read("7a01001d", f)
reg_read("7a01001d", f)
reg_read("7a01001d", f)
reg_read("7a01001d", f)

""" Read Entry (Only Stats are valid) """
entry_read(f)


