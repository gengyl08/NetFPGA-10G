/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfb738814 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "Function arbitrary_write ended without a return statement";
static const char *ng1 = "Function conv_natural ended without a return statement";
extern char *STD_STANDARD;
static const char *ng3 = "/home/mgrinda/netfpga_10g_dev_WORKING_BOOT/projects/configuration_test/CPLD/FlashControllerTB/FlashEmulator.vhd";



unsigned char work_a_1404578958_3212880686_sub_1666149772_3057020925(char *t1, unsigned char t2)
{
    char t4[8];
    unsigned char t0;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    unsigned char t8;
    unsigned char t9;
    unsigned char t10;
    unsigned char t11;
    unsigned char t12;
    unsigned char t13;
    unsigned char t14;
    unsigned char t15;
    unsigned char t16;
    unsigned char t17;
    unsigned char t18;
    unsigned char t19;
    unsigned char t20;
    unsigned char t21;
    unsigned char t22;
    unsigned char t23;
    unsigned char t24;
    unsigned char t25;
    unsigned char t26;
    unsigned char t27;
    unsigned char t28;
    unsigned char t29;
    unsigned char t30;
    unsigned char t31;
    unsigned char t32;
    unsigned char t33;
    unsigned char t34;
    unsigned char t35;
    unsigned char t36;
    unsigned char t37;
    unsigned char t38;
    unsigned char t39;
    unsigned char t40;
    unsigned char t41;
    unsigned char t42;
    unsigned char t43;
    unsigned char t44;
    unsigned char t45;
    unsigned char t46;

LAB0:    t5 = (t4 + 4U);
    *((unsigned char *)t5) = t2;
    t26 = (t2 == (unsigned char)0);
    if (t26 == 1)
        goto LAB62;

LAB63:    t27 = (t2 == (unsigned char)1);
    t25 = t27;

LAB64:    if (t25 == 1)
        goto LAB59;

LAB60:    t28 = (t2 == (unsigned char)2);
    t24 = t28;

LAB61:    if (t24 == 1)
        goto LAB56;

LAB57:    t29 = (t2 == (unsigned char)3);
    t23 = t29;

LAB58:    if (t23 == 1)
        goto LAB53;

LAB54:    t30 = (t2 == (unsigned char)0);
    t22 = t30;

LAB55:    if (t22 == 1)
        goto LAB50;

LAB51:    t31 = (t2 == (unsigned char)5);
    t21 = t31;

LAB52:    if (t21 == 1)
        goto LAB47;

LAB48:    t32 = (t2 == (unsigned char)6);
    t20 = t32;

LAB49:    if (t20 == 1)
        goto LAB44;

LAB45:    t33 = (t2 == (unsigned char)7);
    t19 = t33;

LAB46:    if (t19 == 1)
        goto LAB41;

LAB42:    t34 = (t2 == (unsigned char)8);
    t18 = t34;

LAB43:    if (t18 == 1)
        goto LAB38;

LAB39:    t35 = (t2 == (unsigned char)9);
    t17 = t35;

LAB40:    if (t17 == 1)
        goto LAB35;

LAB36:    t36 = (t2 == (unsigned char)10);
    t16 = t36;

LAB37:    if (t16 == 1)
        goto LAB32;

LAB33:    t37 = (t2 == (unsigned char)11);
    t15 = t37;

LAB34:    if (t15 == 1)
        goto LAB29;

LAB30:    t38 = (t2 == (unsigned char)12);
    t14 = t38;

LAB31:    if (t14 == 1)
        goto LAB26;

LAB27:    t39 = (t2 == (unsigned char)13);
    t13 = t39;

LAB28:    if (t13 == 1)
        goto LAB23;

LAB24:    t40 = (t2 == (unsigned char)14);
    t12 = t40;

LAB25:    if (t12 == 1)
        goto LAB20;

LAB21:    t41 = (t2 == (unsigned char)15);
    t11 = t41;

LAB22:    if (t11 == 1)
        goto LAB17;

LAB18:    t42 = (t2 == (unsigned char)16);
    t10 = t42;

LAB19:    if (t10 == 1)
        goto LAB14;

LAB15:    t43 = (t2 == (unsigned char)17);
    t9 = t43;

LAB16:    if (t9 == 1)
        goto LAB11;

LAB12:    t44 = (t2 == (unsigned char)18);
    t8 = t44;

LAB13:    if (t8 == 1)
        goto LAB8;

LAB9:    t45 = (t2 == (unsigned char)19);
    t7 = t45;

LAB10:    if (t7 == 1)
        goto LAB5;

LAB6:    t46 = (t2 == (unsigned char)20);
    t6 = t46;

LAB7:    if (t6 != 0)
        goto LAB2;

LAB4:    t0 = (unsigned char)0;

LAB1:    return t0;
LAB2:    t0 = (unsigned char)1;
    goto LAB1;

LAB3:    xsi_error(ng0);
    t0 = 0;
    goto LAB1;

LAB5:    t6 = (unsigned char)1;
    goto LAB7;

LAB8:    t7 = (unsigned char)1;
    goto LAB10;

LAB11:    t8 = (unsigned char)1;
    goto LAB13;

LAB14:    t9 = (unsigned char)1;
    goto LAB16;

LAB17:    t10 = (unsigned char)1;
    goto LAB19;

LAB20:    t11 = (unsigned char)1;
    goto LAB22;

LAB23:    t12 = (unsigned char)1;
    goto LAB25;

LAB26:    t13 = (unsigned char)1;
    goto LAB28;

LAB29:    t14 = (unsigned char)1;
    goto LAB31;

LAB32:    t15 = (unsigned char)1;
    goto LAB34;

LAB35:    t16 = (unsigned char)1;
    goto LAB37;

LAB38:    t17 = (unsigned char)1;
    goto LAB40;

LAB41:    t18 = (unsigned char)1;
    goto LAB43;

LAB44:    t19 = (unsigned char)1;
    goto LAB46;

LAB47:    t20 = (unsigned char)1;
    goto LAB49;

LAB50:    t21 = (unsigned char)1;
    goto LAB52;

LAB53:    t22 = (unsigned char)1;
    goto LAB55;

LAB56:    t23 = (unsigned char)1;
    goto LAB58;

LAB59:    t24 = (unsigned char)1;
    goto LAB61;

LAB62:    t25 = (unsigned char)1;
    goto LAB64;

LAB65:    goto LAB3;

LAB66:    goto LAB3;

}

int work_a_1404578958_3212880686_sub_922252053_3057020925(char *t1, unsigned char t2)
{
    char t4[8];
    int t0;
    char *t5;
    unsigned char t6;

LAB0:    t5 = (t4 + 4U);
    *((unsigned char *)t5) = t2;
    t6 = (t2 == (unsigned char)2);
    if (t6 != 0)
        goto LAB2;

LAB4:    t0 = 1;

LAB1:    return t0;
LAB2:    t0 = 0;
    goto LAB1;

LAB3:    xsi_error(ng1);
    t0 = 0;
    goto LAB1;

LAB5:    goto LAB3;

LAB6:    goto LAB3;

}

unsigned char work_a_1404578958_3212880686_sub_2084651222_3057020925(char *t1, char *t2, char *t3)
{
    char t4[72];
    char t5[24];
    char t6[16];
    char t11[16];
    char t16[8];
    unsigned char t0;
    char *t7;
    char *t8;
    int t9;
    unsigned int t10;
    char *t12;
    int t13;
    char *t14;
    char *t15;
    char *t17;
    char *t18;
    char *t19;
    unsigned char t20;
    char *t21;
    char *t22;
    unsigned char t23;
    char *t24;
    char *t25;
    int t26;
    char *t27;
    int t28;
    int t29;
    unsigned int t30;
    unsigned int t31;
    char *t32;
    unsigned char t33;
    int t34;
    int t35;
    char *t36;
    int t37;
    char *t38;
    int t39;
    int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    char *t44;
    unsigned char t45;
    int t46;
    int t47;
    int t48;
    char *t49;
    int t50;
    char *t51;
    int t52;
    int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    char *t57;
    unsigned char t58;
    int t59;
    int t60;
    int t61;
    char *t62;
    int t63;
    char *t64;
    int t65;
    int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    char *t70;
    unsigned char t71;
    int t72;
    int t73;
    int t74;
    char *t75;
    int t76;
    char *t77;
    int t78;
    int t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    char *t83;
    unsigned char t84;
    int t85;
    int t86;
    int t87;
    char *t88;
    int t89;
    char *t90;
    int t91;
    int t92;
    unsigned int t93;
    unsigned int t94;
    unsigned int t95;
    char *t96;
    unsigned char t97;
    int t98;
    int t99;
    int t100;
    char *t101;
    int t102;
    char *t103;
    int t104;
    int t105;
    unsigned int t106;
    unsigned int t107;
    unsigned int t108;
    char *t109;
    unsigned char t110;
    int t111;
    int t112;
    int t113;
    char *t114;
    int t115;
    char *t116;
    int t117;
    int t118;
    unsigned int t119;
    unsigned int t120;
    unsigned int t121;
    char *t122;
    unsigned char t123;
    int t124;
    int t125;
    int t126;
    char *t127;
    int t128;
    char *t129;
    int t130;
    int t131;
    unsigned int t132;
    unsigned int t133;
    unsigned int t134;
    char *t135;
    unsigned char t136;
    int t137;
    int t138;
    int t139;
    char *t140;
    char *t141;

LAB0:    t7 = (t6 + 0U);
    t8 = (t7 + 0U);
    *((int *)t8) = 23;
    t8 = (t7 + 4U);
    *((int *)t8) = 0;
    t8 = (t7 + 8U);
    *((int *)t8) = -1;
    t9 = (0 - 23);
    t10 = (t9 * -1);
    t10 = (t10 + 1);
    t8 = (t7 + 12U);
    *((unsigned int *)t8) = t10;
    t8 = (t11 + 0U);
    t12 = (t8 + 0U);
    *((int *)t12) = 130;
    t12 = (t8 + 4U);
    *((int *)t12) = 0;
    t12 = (t8 + 8U);
    *((int *)t12) = -1;
    t13 = (0 - 130);
    t10 = (t13 * -1);
    t10 = (t10 + 1);
    t12 = (t8 + 12U);
    *((unsigned int *)t12) = t10;
    t12 = (t4 + 4U);
    t14 = ((STD_STANDARD) + 544);
    t15 = (t12 + 52U);
    *((char **)t15) = t14;
    t17 = (t12 + 36U);
    *((char **)t17) = t16;
    xsi_type_set_default_value(t14, t16, 0);
    t18 = (t12 + 48U);
    *((unsigned int *)t18) = 4U;
    t19 = (t5 + 4U);
    t20 = (t2 != 0);
    if (t20 == 1)
        goto LAB3;

LAB2:    t21 = (t5 + 8U);
    *((char **)t21) = t6;
    t22 = (t5 + 12U);
    t23 = (t3 != 0);
    if (t23 == 1)
        goto LAB5;

LAB4:    t24 = (t5 + 16U);
    *((char **)t24) = t11;
    t25 = (t6 + 0U);
    t26 = *((int *)t25);
    t27 = (t6 + 8U);
    t28 = *((int *)t27);
    t29 = (22 - t26);
    t10 = (t29 * t28);
    t30 = (1U * t10);
    t31 = (0 + t30);
    t32 = (t2 + t31);
    t33 = *((unsigned char *)t32);
    t34 = work_a_1404578958_3212880686_sub_922252053_3057020925(t1, t33);
    t35 = (256 * t34);
    t36 = (t6 + 0U);
    t37 = *((int *)t36);
    t38 = (t6 + 8U);
    t39 = *((int *)t38);
    t40 = (21 - t37);
    t41 = (t40 * t39);
    t42 = (1U * t41);
    t43 = (0 + t42);
    t44 = (t2 + t43);
    t45 = *((unsigned char *)t44);
    t46 = work_a_1404578958_3212880686_sub_922252053_3057020925(t1, t45);
    t47 = (128 * t46);
    t48 = (t35 + t47);
    t49 = (t6 + 0U);
    t50 = *((int *)t49);
    t51 = (t6 + 8U);
    t52 = *((int *)t51);
    t53 = (20 - t50);
    t54 = (t53 * t52);
    t55 = (1U * t54);
    t56 = (0 + t55);
    t57 = (t2 + t56);
    t58 = *((unsigned char *)t57);
    t59 = work_a_1404578958_3212880686_sub_922252053_3057020925(t1, t58);
    t60 = (64 * t59);
    t61 = (t48 + t60);
    t62 = (t6 + 0U);
    t63 = *((int *)t62);
    t64 = (t6 + 8U);
    t65 = *((int *)t64);
    t66 = (19 - t63);
    t67 = (t66 * t65);
    t68 = (1U * t67);
    t69 = (0 + t68);
    t70 = (t2 + t69);
    t71 = *((unsigned char *)t70);
    t72 = work_a_1404578958_3212880686_sub_922252053_3057020925(t1, t71);
    t73 = (32 * t72);
    t74 = (t61 + t73);
    t75 = (t6 + 0U);
    t76 = *((int *)t75);
    t77 = (t6 + 8U);
    t78 = *((int *)t77);
    t79 = (18 - t76);
    t80 = (t79 * t78);
    t81 = (1U * t80);
    t82 = (0 + t81);
    t83 = (t2 + t82);
    t84 = *((unsigned char *)t83);
    t85 = work_a_1404578958_3212880686_sub_922252053_3057020925(t1, t84);
    t86 = (16 * t85);
    t87 = (t74 + t86);
    t88 = (t6 + 0U);
    t89 = *((int *)t88);
    t90 = (t6 + 8U);
    t91 = *((int *)t90);
    t92 = (17 - t89);
    t93 = (t92 * t91);
    t94 = (1U * t93);
    t95 = (0 + t94);
    t96 = (t2 + t95);
    t97 = *((unsigned char *)t96);
    t98 = work_a_1404578958_3212880686_sub_922252053_3057020925(t1, t97);
    t99 = (8 * t98);
    t100 = (t87 + t99);
    t101 = (t6 + 0U);
    t102 = *((int *)t101);
    t103 = (t6 + 8U);
    t104 = *((int *)t103);
    t105 = (16 - t102);
    t106 = (t105 * t104);
    t107 = (1U * t106);
    t108 = (0 + t107);
    t109 = (t2 + t108);
    t110 = *((unsigned char *)t109);
    t111 = work_a_1404578958_3212880686_sub_922252053_3057020925(t1, t110);
    t112 = (4 * t111);
    t113 = (t100 + t112);
    t114 = (t6 + 0U);
    t115 = *((int *)t114);
    t116 = (t6 + 8U);
    t117 = *((int *)t116);
    t118 = (15 - t115);
    t119 = (t118 * t117);
    t120 = (1U * t119);
    t121 = (0 + t120);
    t122 = (t2 + t121);
    t123 = *((unsigned char *)t122);
    t124 = work_a_1404578958_3212880686_sub_922252053_3057020925(t1, t123);
    t125 = (2 * t124);
    t126 = (t113 + t125);
    t127 = (t6 + 0U);
    t128 = *((int *)t127);
    t129 = (t6 + 8U);
    t130 = *((int *)t129);
    t131 = (14 - t128);
    t132 = (t131 * t130);
    t133 = (1U * t132);
    t134 = (0 + t133);
    t135 = (t2 + t134);
    t136 = *((unsigned char *)t135);
    t137 = work_a_1404578958_3212880686_sub_922252053_3057020925(t1, t136);
    t138 = (1 * t137);
    t139 = (t126 + t138);
    t140 = (t12 + 36U);
    t141 = *((char **)t140);
    t140 = (t141 + 0);
    *((int *)t140) = t139;
    t7 = (t12 + 36U);
    t8 = *((char **)t7);
    t9 = *((int *)t8);
    t20 = (t9 >= 4);
    if (t20 != 0)
        goto LAB6;

LAB8:
LAB7:    t7 = (t12 + 36U);
    t8 = *((char **)t7);
    t9 = *((int *)t8);
    t7 = (t11 + 0U);
    t13 = *((int *)t7);
    t14 = (t11 + 8U);
    t26 = *((int *)t14);
    t28 = (t9 - t13);
    t10 = (t28 * t26);
    t15 = (t11 + 4U);
    t29 = *((int *)t15);
    xsi_vhdl_check_range_of_index(t13, t29, t26, t9);
    t30 = (1U * t10);
    t31 = (0 + t30);
    t17 = (t3 + t31);
    t20 = *((unsigned char *)t17);
    t23 = (t20 == (unsigned char)3);
    t0 = t23;

LAB1:    return t0;
LAB3:    *((char **)t19) = t2;
    goto LAB2;

LAB5:    *((char **)t22) = t3;
    goto LAB4;

LAB6:    t7 = (t12 + 36U);
    t14 = *((char **)t7);
    t13 = *((int *)t14);
    t26 = (t13 / 4);
    t28 = (3 + t26);
    t7 = (t12 + 36U);
    t15 = *((char **)t7);
    t7 = (t15 + 0);
    *((int *)t7) = t28;
    goto LAB7;

LAB9:;
}

static void work_a_1404578958_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    unsigned char t7;
    int t8;
    int t9;
    char *t10;
    char *t11;
    int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned char t16;
    int t17;
    int t18;
    int t19;
    char *t20;
    char *t21;
    int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned char t26;
    int t27;
    int t28;
    int t29;
    char *t30;
    char *t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned char t36;
    int t37;
    int t38;
    int t39;
    char *t40;
    char *t41;
    int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned char t46;
    int t47;
    int t48;
    int t49;
    char *t50;
    char *t51;
    int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned char t56;
    int t57;
    int t58;
    int t59;
    char *t60;
    char *t61;
    int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned char t66;
    int t67;
    int t68;
    int t69;
    char *t70;
    char *t71;
    int t72;
    unsigned int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned char t76;
    int t77;
    int t78;
    int t79;
    char *t80;
    char *t81;
    int t82;
    unsigned int t83;
    unsigned int t84;
    unsigned int t85;
    unsigned char t86;
    int t87;
    int t88;
    int t89;
    char *t90;
    char *t91;
    int t92;
    unsigned int t93;
    unsigned int t94;
    unsigned int t95;
    unsigned char t96;
    int t97;
    int t98;
    int t99;
    char *t100;
    char *t101;
    int t102;
    unsigned int t103;
    unsigned int t104;
    unsigned int t105;
    unsigned char t106;
    int t107;
    int t108;
    int t109;
    char *t110;
    char *t111;
    int t112;
    unsigned int t113;
    unsigned int t114;
    unsigned int t115;
    unsigned char t116;
    int t117;
    int t118;
    int t119;
    char *t120;
    char *t121;
    char *t122;
    char *t123;
    char *t124;
    unsigned char t125;
    char *t126;
    char *t127;

LAB0:    xsi_set_current_line(183, ng3);
    t1 = (t0 + 592U);
    t2 = *((char **)t1);
    t3 = (0 - 23);
    t4 = (t3 * -1);
    t5 = (1U * t4);
    t6 = (0 + t5);
    t1 = (t2 + t6);
    t7 = *((unsigned char *)t1);
    t8 = work_a_1404578958_3212880686_sub_922252053_3057020925(t0, t7);
    t9 = (1 * t8);
    t10 = (t0 + 592U);
    t11 = *((char **)t10);
    t12 = (1 - 23);
    t13 = (t12 * -1);
    t14 = (1U * t13);
    t15 = (0 + t14);
    t10 = (t11 + t15);
    t16 = *((unsigned char *)t10);
    t17 = work_a_1404578958_3212880686_sub_922252053_3057020925(t0, t16);
    t18 = (2 * t17);
    t19 = (t9 + t18);
    t20 = (t0 + 592U);
    t21 = *((char **)t20);
    t22 = (2 - 23);
    t23 = (t22 * -1);
    t24 = (1U * t23);
    t25 = (0 + t24);
    t20 = (t21 + t25);
    t26 = *((unsigned char *)t20);
    t27 = work_a_1404578958_3212880686_sub_922252053_3057020925(t0, t26);
    t28 = (4 * t27);
    t29 = (t19 + t28);
    t30 = (t0 + 592U);
    t31 = *((char **)t30);
    t32 = (3 - 23);
    t33 = (t32 * -1);
    t34 = (1U * t33);
    t35 = (0 + t34);
    t30 = (t31 + t35);
    t36 = *((unsigned char *)t30);
    t37 = work_a_1404578958_3212880686_sub_922252053_3057020925(t0, t36);
    t38 = (8 * t37);
    t39 = (t29 + t38);
    t40 = (t0 + 592U);
    t41 = *((char **)t40);
    t42 = (15 - 23);
    t43 = (t42 * -1);
    t44 = (1U * t43);
    t45 = (0 + t44);
    t40 = (t41 + t45);
    t46 = *((unsigned char *)t40);
    t47 = work_a_1404578958_3212880686_sub_922252053_3057020925(t0, t46);
    t48 = (16 * t47);
    t49 = (t39 + t48);
    t50 = (t0 + 592U);
    t51 = *((char **)t50);
    t52 = (16 - 23);
    t53 = (t52 * -1);
    t54 = (1U * t53);
    t55 = (0 + t54);
    t50 = (t51 + t55);
    t56 = *((unsigned char *)t50);
    t57 = work_a_1404578958_3212880686_sub_922252053_3057020925(t0, t56);
    t58 = (32 * t57);
    t59 = (t49 + t58);
    t60 = (t0 + 592U);
    t61 = *((char **)t60);
    t62 = (17 - 23);
    t63 = (t62 * -1);
    t64 = (1U * t63);
    t65 = (0 + t64);
    t60 = (t61 + t65);
    t66 = *((unsigned char *)t60);
    t67 = work_a_1404578958_3212880686_sub_922252053_3057020925(t0, t66);
    t68 = (64 * t67);
    t69 = (t59 + t68);
    t70 = (t0 + 592U);
    t71 = *((char **)t70);
    t72 = (18 - 23);
    t73 = (t72 * -1);
    t74 = (1U * t73);
    t75 = (0 + t74);
    t70 = (t71 + t75);
    t76 = *((unsigned char *)t70);
    t77 = work_a_1404578958_3212880686_sub_922252053_3057020925(t0, t76);
    t78 = (128 * t77);
    t79 = (t69 + t78);
    t80 = (t0 + 592U);
    t81 = *((char **)t80);
    t82 = (19 - 23);
    t83 = (t82 * -1);
    t84 = (1U * t83);
    t85 = (0 + t84);
    t80 = (t81 + t85);
    t86 = *((unsigned char *)t80);
    t87 = work_a_1404578958_3212880686_sub_922252053_3057020925(t0, t86);
    t88 = (256 * t87);
    t89 = (t79 + t88);
    t90 = (t0 + 592U);
    t91 = *((char **)t90);
    t92 = (20 - 23);
    t93 = (t92 * -1);
    t94 = (1U * t93);
    t95 = (0 + t94);
    t90 = (t91 + t95);
    t96 = *((unsigned char *)t90);
    t97 = work_a_1404578958_3212880686_sub_922252053_3057020925(t0, t96);
    t98 = (512 * t97);
    t99 = (t89 + t98);
    t100 = (t0 + 592U);
    t101 = *((char **)t100);
    t102 = (21 - 23);
    t103 = (t102 * -1);
    t104 = (1U * t103);
    t105 = (0 + t104);
    t100 = (t101 + t105);
    t106 = *((unsigned char *)t100);
    t107 = work_a_1404578958_3212880686_sub_922252053_3057020925(t0, t106);
    t108 = (1024 * t107);
    t109 = (t99 + t108);
    t110 = (t0 + 592U);
    t111 = *((char **)t110);
    t112 = (22 - 23);
    t113 = (t112 * -1);
    t114 = (1U * t113);
    t115 = (0 + t114);
    t110 = (t111 + t115);
    t116 = *((unsigned char *)t110);
    t117 = work_a_1404578958_3212880686_sub_922252053_3057020925(t0, t116);
    t118 = (2048 * t117);
    t119 = (t109 + t118);
    t120 = (t0 + 4876);
    t121 = (t120 + 32U);
    t122 = *((char **)t121);
    t123 = (t122 + 32U);
    t124 = *((char **)t123);
    *((int *)t124) = t119;
    xsi_driver_first_trans_fast(t120);
    xsi_set_current_line(196, ng3);
    t1 = (t0 + 1236U);
    t2 = *((char **)t1);
    t16 = *((unsigned char *)t2);
    t26 = (t16 == (unsigned char)2);
    if (t26 == 1)
        goto LAB5;

LAB6:    t7 = (unsigned char)0;

LAB7:    if (t7 != 0)
        goto LAB2;

LAB4:
LAB3:    xsi_set_current_line(202, ng3);
    t1 = (t0 + 1120U);
    t16 = xsi_signal_has_event(t1);
    if (t16 == 1)
        goto LAB11;

LAB12:    t7 = (unsigned char)0;

LAB13:    if (t7 != 0)
        goto LAB8;

LAB10:
LAB9:    t1 = (t0 + 4824);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(198, ng3);
    t1 = (t0 + 592U);
    t11 = *((char **)t1);
    t1 = (t0 + 4912);
    t20 = (t1 + 32U);
    t21 = *((char **)t20);
    t30 = (t21 + 32U);
    t31 = *((char **)t30);
    memcpy(t31, t11, 24U);
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(199, ng3);
    t1 = (t0 + 4948);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

LAB5:    t1 = (t0 + 776U);
    t10 = *((char **)t1);
    t36 = *((unsigned char *)t10);
    t46 = (t36 == (unsigned char)2);
    t7 = t46;
    goto LAB7;

LAB8:    xsi_set_current_line(204, ng3);
    t2 = (t0 + 868U);
    t11 = *((char **)t2);
    t56 = *((unsigned char *)t11);
    t66 = (t56 == (unsigned char)2);
    if (t66 == 1)
        goto LAB17;

LAB18:    t46 = (unsigned char)0;

LAB19:    if (t46 != 0)
        goto LAB14;

LAB16:    xsi_set_current_line(220, ng3);
    t1 = xsi_get_transient_memory(16U);
    memset(t1, 0, 16U);
    t2 = t1;
    memset(t2, (unsigned char)4, 16U);
    t10 = (t0 + 4984);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    t21 = (t20 + 32U);
    t30 = *((char **)t21);
    memcpy(t30, t1, 16U);
    xsi_driver_first_trans_fast_port(t10);

LAB15:    xsi_set_current_line(223, ng3);
    t1 = (t0 + 868U);
    t2 = *((char **)t1);
    t26 = *((unsigned char *)t2);
    t36 = (t26 == (unsigned char)3);
    if (t36 == 1)
        goto LAB32;

LAB33:    t16 = (unsigned char)0;

LAB34:    if (t16 == 1)
        goto LAB29;

LAB30:    t7 = (unsigned char)0;

LAB31:    if (t7 != 0)
        goto LAB26;

LAB28:
LAB27:    goto LAB9;

LAB11:    t2 = (t0 + 1144U);
    t10 = *((char **)t2);
    t26 = *((unsigned char *)t10);
    t36 = (t26 == (unsigned char)3);
    t7 = t36;
    goto LAB13;

LAB14:    xsi_set_current_line(206, ng3);
    t2 = (t0 + 2064U);
    t21 = *((char **)t2);
    t96 = *((unsigned char *)t21);
    t106 = (t96 == (unsigned char)0);
    if (t106 != 0)
        goto LAB20;

LAB22:    xsi_set_current_line(215, ng3);
    t1 = xsi_get_transient_memory(8U);
    memset(t1, 0, 8U);
    t2 = t1;
    memset(t2, (unsigned char)2, 8U);
    t10 = (t0 + 4984);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    t21 = (t20 + 32U);
    t30 = *((char **)t21);
    memcpy(t30, t1, 8U);
    xsi_driver_first_trans_delta(t10, 0U, 8U, 0LL);
    xsi_set_current_line(216, ng3);
    t1 = (t0 + 1972U);
    t2 = *((char **)t1);
    t1 = (t0 + 4984);
    t10 = (t1 + 32U);
    t11 = *((char **)t10);
    t20 = (t11 + 32U);
    t21 = *((char **)t20);
    memcpy(t21, t2, 8U);
    xsi_driver_first_trans_delta(t1, 8U, 8U, 0LL);

LAB21:    xsi_set_current_line(218, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)21;
    xsi_driver_first_trans_fast(t1);
    goto LAB15;

LAB17:    t2 = (t0 + 776U);
    t20 = *((char **)t2);
    t76 = *((unsigned char *)t20);
    t86 = (t76 == (unsigned char)2);
    t46 = t86;
    goto LAB19;

LAB20:    xsi_set_current_line(208, ng3);
    t2 = (t0 + 1788U);
    t30 = *((char **)t2);
    t116 = *((unsigned char *)t30);
    t125 = (t116 == (unsigned char)3);
    if (t125 != 0)
        goto LAB23;

LAB25:    xsi_set_current_line(212, ng3);
    t1 = xsi_get_transient_memory(16U);
    memset(t1, 0, 16U);
    t2 = t1;
    memset(t2, (unsigned char)1, 16U);
    t10 = (t0 + 4984);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    t21 = (t20 + 32U);
    t30 = *((char **)t21);
    memcpy(t30, t1, 16U);
    xsi_driver_first_trans_fast_port(t10);

LAB24:    goto LAB21;

LAB23:    xsi_set_current_line(210, ng3);
    t2 = (t0 + 2432U);
    t31 = *((char **)t2);
    t2 = (t0 + 4984);
    t40 = (t2 + 32U);
    t41 = *((char **)t40);
    t50 = (t41 + 32U);
    t51 = *((char **)t50);
    memcpy(t51, t31, 16U);
    xsi_driver_first_trans_fast_port(t2);
    goto LAB24;

LAB26:    xsi_set_current_line(225, ng3);
    t1 = (t0 + 1788U);
    t20 = *((char **)t1);
    t96 = *((unsigned char *)t20);
    t106 = (t96 == (unsigned char)3);
    if (t106 == 1)
        goto LAB38;

LAB39:    t1 = (t0 + 1236U);
    t21 = *((char **)t1);
    t116 = *((unsigned char *)t21);
    t125 = (t116 == (unsigned char)2);
    t86 = t125;

LAB40:    if (t86 != 0)
        goto LAB35;

LAB37:
LAB36:    goto LAB27;

LAB29:    t1 = (t0 + 960U);
    t11 = *((char **)t1);
    t66 = *((unsigned char *)t11);
    t76 = (t66 == (unsigned char)2);
    t7 = t76;
    goto LAB31;

LAB32:    t1 = (t0 + 776U);
    t10 = *((char **)t1);
    t46 = *((unsigned char *)t10);
    t56 = (t46 == (unsigned char)2);
    t16 = t56;
    goto LAB34;

LAB35:    xsi_set_current_line(227, ng3);
    t1 = (t0 + 684U);
    t30 = *((char **)t1);
    t4 = (15 - 7);
    t5 = (t4 * 1U);
    t6 = (0 + t5);
    t1 = (t30 + t6);
    t31 = (t0 + 2740U);
    t40 = *((char **)t31);
    t3 = xsi_mem_cmp(t40, t1, 8U);
    if (t3 == 1)
        goto LAB42;

LAB62:    t31 = (t0 + 2808U);
    t41 = *((char **)t31);
    t8 = xsi_mem_cmp(t41, t1, 8U);
    if (t8 == 1)
        goto LAB43;

LAB63:    t31 = (t0 + 2876U);
    t50 = *((char **)t31);
    t9 = xsi_mem_cmp(t50, t1, 8U);
    if (t9 == 1)
        goto LAB44;

LAB64:    t31 = (t0 + 2944U);
    t51 = *((char **)t31);
    t12 = xsi_mem_cmp(t51, t1, 8U);
    if (t12 == 1)
        goto LAB45;

LAB65:    t31 = (t0 + 3012U);
    t60 = *((char **)t31);
    t17 = xsi_mem_cmp(t60, t1, 8U);
    if (t17 == 1)
        goto LAB46;

LAB66:    t31 = (t0 + 3080U);
    t61 = *((char **)t31);
    t18 = xsi_mem_cmp(t61, t1, 8U);
    if (t18 == 1)
        goto LAB47;

LAB67:    t31 = (t0 + 3148U);
    t70 = *((char **)t31);
    t19 = xsi_mem_cmp(t70, t1, 8U);
    if (t19 == 1)
        goto LAB48;

LAB68:    t31 = (t0 + 3216U);
    t71 = *((char **)t31);
    t22 = xsi_mem_cmp(t71, t1, 8U);
    if (t22 == 1)
        goto LAB49;

LAB69:    t31 = (t0 + 3284U);
    t80 = *((char **)t31);
    t27 = xsi_mem_cmp(t80, t1, 8U);
    if (t27 == 1)
        goto LAB50;

LAB70:    t31 = (t0 + 3352U);
    t81 = *((char **)t31);
    t28 = xsi_mem_cmp(t81, t1, 8U);
    if (t28 == 1)
        goto LAB51;

LAB71:    t31 = (t0 + 3420U);
    t90 = *((char **)t31);
    t29 = xsi_mem_cmp(t90, t1, 8U);
    if (t29 == 1)
        goto LAB52;

LAB72:    t31 = (t0 + 3488U);
    t91 = *((char **)t31);
    t32 = xsi_mem_cmp(t91, t1, 8U);
    if (t32 == 1)
        goto LAB53;

LAB73:    t31 = (t0 + 3556U);
    t100 = *((char **)t31);
    t37 = xsi_mem_cmp(t100, t1, 8U);
    if (t37 == 1)
        goto LAB54;

LAB74:    t31 = (t0 + 3624U);
    t101 = *((char **)t31);
    t38 = xsi_mem_cmp(t101, t1, 8U);
    if (t38 == 1)
        goto LAB55;

LAB75:    t31 = (t0 + 3692U);
    t110 = *((char **)t31);
    t39 = xsi_mem_cmp(t110, t1, 8U);
    if (t39 == 1)
        goto LAB56;

LAB76:    t31 = (t0 + 3760U);
    t111 = *((char **)t31);
    t42 = xsi_mem_cmp(t111, t1, 8U);
    if (t42 == 1)
        goto LAB57;

LAB77:    t31 = (t0 + 3828U);
    t120 = *((char **)t31);
    t47 = xsi_mem_cmp(t120, t1, 8U);
    if (t47 == 1)
        goto LAB58;

LAB78:    t31 = (t0 + 3896U);
    t121 = *((char **)t31);
    t48 = xsi_mem_cmp(t121, t1, 8U);
    if (t48 == 1)
        goto LAB59;

LAB79:    t31 = (t0 + 3964U);
    t122 = *((char **)t31);
    t49 = xsi_mem_cmp(t122, t1, 8U);
    if (t49 == 1)
        goto LAB60;

LAB80:
LAB61:    xsi_set_current_line(247, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)20;
    xsi_driver_first_trans_fast(t1);

LAB41:    goto LAB36;

LAB38:    t86 = (unsigned char)1;
    goto LAB40;

LAB42:    xsi_set_current_line(228, ng3);
    t31 = (t0 + 5020);
    t123 = (t31 + 32U);
    t124 = *((char **)t123);
    t126 = (t124 + 32U);
    t127 = *((char **)t126);
    *((unsigned char *)t127) = (unsigned char)0;
    xsi_driver_first_trans_fast(t31);
    goto LAB41;

LAB43:    xsi_set_current_line(229, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB44:    xsi_set_current_line(230, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB45:    xsi_set_current_line(231, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB46:    xsi_set_current_line(232, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB47:    xsi_set_current_line(233, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)5;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB48:    xsi_set_current_line(234, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)6;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB49:    xsi_set_current_line(235, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)7;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB50:    xsi_set_current_line(236, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)8;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB51:    xsi_set_current_line(237, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)9;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB52:    xsi_set_current_line(238, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)10;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB53:    xsi_set_current_line(239, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)11;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB54:    xsi_set_current_line(240, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)12;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB55:    xsi_set_current_line(241, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)13;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB56:    xsi_set_current_line(242, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)14;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB57:    xsi_set_current_line(243, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)15;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB58:    xsi_set_current_line(244, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)16;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB59:    xsi_set_current_line(245, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)18;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB60:    xsi_set_current_line(246, ng3);
    t1 = (t0 + 5020);
    t2 = (t1 + 32U);
    t10 = *((char **)t2);
    t11 = (t10 + 32U);
    t20 = *((char **)t11);
    *((unsigned char *)t20) = (unsigned char)19;
    xsi_driver_first_trans_fast(t1);
    goto LAB41;

LAB81:;
}

static void work_a_1404578958_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    int t12;
    int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned char t17;
    unsigned char t18;
    unsigned char t19;
    static char *nl0[] = {&&LAB3, &&LAB7, &&LAB4, &&LAB9, &&LAB6, &&LAB8, &&LAB5, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9, &&LAB9};
    static char *nl1[] = {&&LAB14, &&LAB14, &&LAB14, &&LAB14, &&LAB14, &&LAB11, &&LAB14, &&LAB14, &&LAB14, &&LAB14, &&LAB12, &&LAB14, &&LAB14, &&LAB14, &&LAB14, &&LAB14, &&LAB14, &&LAB14, &&LAB14, &&LAB13, &&LAB14, &&LAB14, &&LAB14, &&LAB14};

LAB0:    xsi_set_current_line(256, ng3);
    t1 = (t0 + 2156U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (char *)((nl0) + t3);
    goto **((char **)t1);

LAB2:    xsi_set_current_line(301, ng3);
    t1 = (t0 + 1120U);
    t6 = xsi_signal_has_event(t1);
    if (t6 == 1)
        goto LAB24;

LAB25:    t3 = (unsigned char)0;

LAB26:    if (t3 != 0)
        goto LAB21;

LAB23:
LAB22:    t1 = (t0 + 4832);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(258, ng3);
    t4 = (t0 + 2340U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t4 = (char *)((nl1) + t6);
    goto **((char **)t4);

LAB4:    xsi_set_current_line(270, ng3);
    t1 = (t0 + 2340U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t6 = work_a_1404578958_3212880686_sub_1666149772_3057020925(t0, t3);
    if (t6 != 0)
        goto LAB15;

LAB17:
LAB16:    goto LAB2;

LAB5:    xsi_set_current_line(285, ng3);
    t1 = (t0 + 79762);
    xsi_report(t1, 27U, (unsigned char)0);
    xsi_set_current_line(287, ng3);
    t1 = (t0 + 1420U);
    t2 = *((char **)t1);
    t1 = (t0 + 1696U);
    t4 = *((char **)t1);
    t12 = *((int *)t4);
    t13 = (t12 - 4095);
    t14 = (t13 * -1);
    xsi_vhdl_check_range_of_index(4095, 0, -1, t12);
    t15 = (16U * t14);
    t16 = (0 + t15);
    t1 = (t2 + t16);
    t5 = (t0 + 5128);
    t7 = (t5 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 32U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 16U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(288, ng3);
    t1 = (t0 + 5092);
    t2 = (t1 + 32U);
    t4 = *((char **)t2);
    t5 = (t4 + 32U);
    t7 = *((char **)t5);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(289, ng3);
    t1 = (t0 + 5056);
    t2 = (t1 + 32U);
    t4 = *((char **)t2);
    t5 = (t4 + 32U);
    t7 = *((char **)t5);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB6:    goto LAB2;

LAB7:    xsi_set_current_line(294, ng3);
    t1 = (t0 + 5056);
    t2 = (t1 + 32U);
    t4 = *((char **)t2);
    t5 = (t4 + 32U);
    t7 = *((char **)t5);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB8:    goto LAB2;

LAB9:    goto LAB2;

LAB10:    goto LAB2;

LAB11:    xsi_set_current_line(260, ng3);
    t7 = (t0 + 5056);
    t8 = (t7 + 32U);
    t9 = *((char **)t8);
    t10 = (t9 + 32U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t7);
    xsi_set_current_line(261, ng3);
    t1 = (t0 + 5092);
    t2 = (t1 + 32U);
    t4 = *((char **)t2);
    t5 = (t4 + 32U);
    t7 = *((char **)t5);
    *((unsigned char *)t7) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    goto LAB10;

LAB12:    xsi_set_current_line(263, ng3);
    t1 = (t0 + 5056);
    t2 = (t1 + 32U);
    t4 = *((char **)t2);
    t5 = (t4 + 32U);
    t7 = *((char **)t5);
    *((unsigned char *)t7) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(264, ng3);
    t1 = (t0 + 2604U);
    t2 = *((char **)t1);
    t1 = (t0 + 5128);
    t4 = (t1 + 32U);
    t5 = *((char **)t4);
    t7 = (t5 + 32U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 16U);
    xsi_driver_first_trans_fast(t1);
    goto LAB10;

LAB13:    xsi_set_current_line(266, ng3);
    t1 = (t0 + 5056);
    t2 = (t1 + 32U);
    t4 = *((char **)t2);
    t5 = (t4 + 32U);
    t7 = *((char **)t5);
    *((unsigned char *)t7) = (unsigned char)6;
    xsi_driver_first_trans_fast(t1);
    goto LAB10;

LAB14:    goto LAB10;

LAB15:    xsi_set_current_line(272, ng3);
    t1 = (t0 + 5056);
    t4 = (t1 + 32U);
    t5 = *((char **)t4);
    t7 = (t5 + 32U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(274, ng3);
    t1 = (t0 + 79740);
    xsi_report(t1, 22U, (unsigned char)0);
    xsi_set_current_line(276, ng3);
    t1 = (t0 + 592U);
    t2 = *((char **)t1);
    t1 = (t0 + 1880U);
    t4 = *((char **)t1);
    t3 = work_a_1404578958_3212880686_sub_2084651222_3057020925(t0, t2, t4);
    if (t3 != 0)
        goto LAB18;

LAB20:    xsi_set_current_line(280, ng3);
    t1 = (t0 + 5164);
    t2 = (t1 + 32U);
    t4 = *((char **)t2);
    t5 = (t4 + 32U);
    t7 = *((char **)t5);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_delta(t1, 6U, 1, 0LL);
    xsi_set_current_line(281, ng3);
    t1 = (t0 + 684U);
    t2 = *((char **)t1);
    t1 = (t0 + 1696U);
    t4 = *((char **)t1);
    t12 = *((int *)t4);
    t13 = (t12 - 4095);
    t14 = (t13 * -1);
    t15 = (16U * t14);
    t16 = (0U + t15);
    t1 = (t0 + 5200);
    t5 = (t1 + 32U);
    t7 = *((char **)t5);
    t8 = (t7 + 32U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 16U);
    xsi_driver_first_trans_delta(t1, t16, 16U, 0LL);

LAB19:    goto LAB16;

LAB18:    xsi_set_current_line(278, ng3);
    t1 = (t0 + 5164);
    t5 = (t1 + 32U);
    t7 = *((char **)t5);
    t8 = (t7 + 32U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)3;
    xsi_driver_first_trans_delta(t1, 6U, 1, 0LL);
    goto LAB19;

LAB21:    xsi_set_current_line(304, ng3);
    t2 = (t0 + 2248U);
    t5 = *((char **)t2);
    t19 = *((unsigned char *)t5);
    t2 = (t0 + 5236);
    t7 = (t2 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 32U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t19;
    xsi_driver_first_trans_fast(t2);
    goto LAB22;

LAB24:    t2 = (t0 + 1144U);
    t4 = *((char **)t2);
    t17 = *((unsigned char *)t4);
    t18 = (t17 == (unsigned char)3);
    t3 = t18;
    goto LAB26;

}


void ieee_p_2592010699_sub_3130575329_503743352();

void ieee_p_2592010699_sub_3130575329_503743352();

extern void work_a_1404578958_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1404578958_3212880686_p_0,(void *)work_a_1404578958_3212880686_p_1};
	static char *se[] = {(void *)work_a_1404578958_3212880686_sub_1666149772_3057020925,(void *)work_a_1404578958_3212880686_sub_922252053_3057020925,(void *)work_a_1404578958_3212880686_sub_2084651222_3057020925};
	xsi_register_didat("work_a_1404578958_3212880686", "isim/FlashTest_isim_beh.exe.sim/work/a_1404578958_3212880686.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
	xsi_register_resolution_function(1, 2, (void *)ieee_p_2592010699_sub_3130575329_503743352, 4);
	xsi_register_resolution_function(2, 2, (void *)ieee_p_2592010699_sub_3130575329_503743352, 4);
}
