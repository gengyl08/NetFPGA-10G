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
extern char *IEEE_P_3499444699;
static const char *ng1 = "Function charactervalue ended without a return statement";
static const char *ng2 = "Function hexcharacter ended without a return statement";
extern char *STD_STANDARD;
static const char *ng4 = "/home/mgrinda/netfpga_10g_dev_WORKING_BOOT/projects/configuration_test/CPLD/FlashControllerTB/FlashTest.vhd";

char *ieee_p_3499444699_sub_2213602152_3536714472(char *, char *, int , int );


char *work_a_4103101987_2372691052_sub_892846079_4163069965(char *t1, unsigned char t2)
{
    char t4[8];
    char t7[16];
    char *t0;
    char *t5;
    char *t6;
    char *t8;
    char *t9;
    unsigned int t10;
    char *t11;
    int t12;
    char *t13;
    int t14;
    char *t15;
    int t16;
    static char *nl0[] = {&&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB3, &&LAB4, &&LAB5, &&LAB6, &&LAB7, &&LAB8, &&LAB9, &&LAB10, &&LAB11, &&LAB12, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB13, &&LAB14, &&LAB15, &&LAB16, &&LAB17, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18, &&LAB18};

LAB0:    t5 = (t4 + 4U);
    *((unsigned char *)t5) = t2;
    t6 = (char *)((nl0) + t2);
    goto **((char **)t6);

LAB2:    xsi_error(ng1);
    t0 = 0;

LAB1:    return t0;
LAB3:    t8 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t7, 0, 4);
    t9 = (t7 + 12U);
    t10 = *((unsigned int *)t9);
    t10 = (t10 * 1U);
    t11 = (t7 + 0U);
    t12 = *((int *)t11);
    t13 = (t7 + 4U);
    t14 = *((int *)t13);
    t15 = (t7 + 8U);
    t16 = *((int *)t15);
    xsi_vhdl_check_range_of_slice(3, 0, -1, t12, t14, t16);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t8, t10);
    goto LAB1;

LAB4:    t6 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t7, 1, 4);
    t8 = (t7 + 12U);
    t10 = *((unsigned int *)t8);
    t10 = (t10 * 1U);
    t9 = (t7 + 0U);
    t12 = *((int *)t9);
    t11 = (t7 + 4U);
    t14 = *((int *)t11);
    t13 = (t7 + 8U);
    t16 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(3, 0, -1, t12, t14, t16);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t6, t10);
    goto LAB1;

LAB5:    t6 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t7, 2, 4);
    t8 = (t7 + 12U);
    t10 = *((unsigned int *)t8);
    t10 = (t10 * 1U);
    t9 = (t7 + 0U);
    t12 = *((int *)t9);
    t11 = (t7 + 4U);
    t14 = *((int *)t11);
    t13 = (t7 + 8U);
    t16 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(3, 0, -1, t12, t14, t16);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t6, t10);
    goto LAB1;

LAB6:    t6 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t7, 3, 4);
    t8 = (t7 + 12U);
    t10 = *((unsigned int *)t8);
    t10 = (t10 * 1U);
    t9 = (t7 + 0U);
    t12 = *((int *)t9);
    t11 = (t7 + 4U);
    t14 = *((int *)t11);
    t13 = (t7 + 8U);
    t16 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(3, 0, -1, t12, t14, t16);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t6, t10);
    goto LAB1;

LAB7:    t6 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t7, 4, 4);
    t8 = (t7 + 12U);
    t10 = *((unsigned int *)t8);
    t10 = (t10 * 1U);
    t9 = (t7 + 0U);
    t12 = *((int *)t9);
    t11 = (t7 + 4U);
    t14 = *((int *)t11);
    t13 = (t7 + 8U);
    t16 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(3, 0, -1, t12, t14, t16);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t6, t10);
    goto LAB1;

LAB8:    t6 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t7, 5, 4);
    t8 = (t7 + 12U);
    t10 = *((unsigned int *)t8);
    t10 = (t10 * 1U);
    t9 = (t7 + 0U);
    t12 = *((int *)t9);
    t11 = (t7 + 4U);
    t14 = *((int *)t11);
    t13 = (t7 + 8U);
    t16 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(3, 0, -1, t12, t14, t16);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t6, t10);
    goto LAB1;

LAB9:    t6 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t7, 6, 4);
    t8 = (t7 + 12U);
    t10 = *((unsigned int *)t8);
    t10 = (t10 * 1U);
    t9 = (t7 + 0U);
    t12 = *((int *)t9);
    t11 = (t7 + 4U);
    t14 = *((int *)t11);
    t13 = (t7 + 8U);
    t16 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(3, 0, -1, t12, t14, t16);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t6, t10);
    goto LAB1;

LAB10:    t6 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t7, 7, 4);
    t8 = (t7 + 12U);
    t10 = *((unsigned int *)t8);
    t10 = (t10 * 1U);
    t9 = (t7 + 0U);
    t12 = *((int *)t9);
    t11 = (t7 + 4U);
    t14 = *((int *)t11);
    t13 = (t7 + 8U);
    t16 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(3, 0, -1, t12, t14, t16);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t6, t10);
    goto LAB1;

LAB11:    t6 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t7, 8, 4);
    t8 = (t7 + 12U);
    t10 = *((unsigned int *)t8);
    t10 = (t10 * 1U);
    t9 = (t7 + 0U);
    t12 = *((int *)t9);
    t11 = (t7 + 4U);
    t14 = *((int *)t11);
    t13 = (t7 + 8U);
    t16 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(3, 0, -1, t12, t14, t16);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t6, t10);
    goto LAB1;

LAB12:    t6 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t7, 9, 4);
    t8 = (t7 + 12U);
    t10 = *((unsigned int *)t8);
    t10 = (t10 * 1U);
    t9 = (t7 + 0U);
    t12 = *((int *)t9);
    t11 = (t7 + 4U);
    t14 = *((int *)t11);
    t13 = (t7 + 8U);
    t16 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(3, 0, -1, t12, t14, t16);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t6, t10);
    goto LAB1;

LAB13:    t6 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t7, 10, 4);
    t8 = (t7 + 12U);
    t10 = *((unsigned int *)t8);
    t10 = (t10 * 1U);
    t9 = (t7 + 0U);
    t12 = *((int *)t9);
    t11 = (t7 + 4U);
    t14 = *((int *)t11);
    t13 = (t7 + 8U);
    t16 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(3, 0, -1, t12, t14, t16);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t6, t10);
    goto LAB1;

LAB14:    t6 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t7, 11, 4);
    t8 = (t7 + 12U);
    t10 = *((unsigned int *)t8);
    t10 = (t10 * 1U);
    t9 = (t7 + 0U);
    t12 = *((int *)t9);
    t11 = (t7 + 4U);
    t14 = *((int *)t11);
    t13 = (t7 + 8U);
    t16 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(3, 0, -1, t12, t14, t16);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t6, t10);
    goto LAB1;

LAB15:    t6 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t7, 12, 4);
    t8 = (t7 + 12U);
    t10 = *((unsigned int *)t8);
    t10 = (t10 * 1U);
    t9 = (t7 + 0U);
    t12 = *((int *)t9);
    t11 = (t7 + 4U);
    t14 = *((int *)t11);
    t13 = (t7 + 8U);
    t16 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(3, 0, -1, t12, t14, t16);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t6, t10);
    goto LAB1;

LAB16:    t6 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t7, 13, 4);
    t8 = (t7 + 12U);
    t10 = *((unsigned int *)t8);
    t10 = (t10 * 1U);
    t9 = (t7 + 0U);
    t12 = *((int *)t9);
    t11 = (t7 + 4U);
    t14 = *((int *)t11);
    t13 = (t7 + 8U);
    t16 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(3, 0, -1, t12, t14, t16);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t6, t10);
    goto LAB1;

LAB17:    t6 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t7, 14, 4);
    t8 = (t7 + 12U);
    t10 = *((unsigned int *)t8);
    t10 = (t10 * 1U);
    t9 = (t7 + 0U);
    t12 = *((int *)t9);
    t11 = (t7 + 4U);
    t14 = *((int *)t11);
    t13 = (t7 + 8U);
    t16 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(3, 0, -1, t12, t14, t16);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t6, t10);
    goto LAB1;

LAB18:    t6 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t7, 15, 4);
    t8 = (t7 + 12U);
    t10 = *((unsigned int *)t8);
    t10 = (t10 * 1U);
    t9 = (t7 + 0U);
    t12 = *((int *)t9);
    t11 = (t7 + 4U);
    t14 = *((int *)t11);
    t13 = (t7 + 8U);
    t16 = *((int *)t13);
    xsi_vhdl_check_range_of_slice(3, 0, -1, t12, t14, t16);
    t0 = xsi_get_transient_memory(t10);
    memcpy(t0, t6, t10);
    goto LAB1;

LAB19:    goto LAB2;

LAB20:    goto LAB2;

LAB21:    goto LAB2;

LAB22:    goto LAB2;

LAB23:    goto LAB2;

LAB24:    goto LAB2;

LAB25:    goto LAB2;

LAB26:    goto LAB2;

LAB27:    goto LAB2;

LAB28:    goto LAB2;

LAB29:    goto LAB2;

LAB30:    goto LAB2;

LAB31:    goto LAB2;

LAB32:    goto LAB2;

LAB33:    goto LAB2;

LAB34:    goto LAB2;

}

unsigned char work_a_4103101987_2372691052_sub_3895013716_4163069965(char *t1, char *t2)
{
    char t4[16];
    char t5[16];
    unsigned char t0;
    char *t6;
    char *t7;
    int t8;
    unsigned int t9;
    unsigned char t10;
    char *t11;
    char *t12;
    int t14;
    char *t15;
    int t17;
    char *t18;
    int t20;
    char *t21;
    int t23;
    char *t24;
    int t26;
    char *t27;
    int t29;
    char *t30;
    int t32;
    char *t33;
    int t35;
    char *t36;
    int t38;
    char *t39;
    int t41;
    char *t42;
    int t44;
    char *t45;
    int t47;
    char *t48;
    int t50;
    char *t51;
    int t53;
    char *t54;
    int t56;

LAB0:    t6 = (t5 + 0U);
    t7 = (t6 + 0U);
    *((int *)t7) = 3;
    t7 = (t6 + 4U);
    *((int *)t7) = 0;
    t7 = (t6 + 8U);
    *((int *)t7) = -1;
    t8 = (0 - 3);
    t9 = (t8 * -1);
    t9 = (t9 + 1);
    t7 = (t6 + 12U);
    *((unsigned int *)t7) = t9;
    t7 = (t4 + 4U);
    t10 = (t2 != 0);
    if (t10 == 1)
        goto LAB3;

LAB2:    t11 = (t4 + 8U);
    *((char **)t11) = t5;
    t12 = (t1 + 13549);
    t14 = xsi_mem_cmp(t12, t2, 4U);
    if (t14 == 1)
        goto LAB5;

LAB21:    t15 = (t1 + 13553);
    t17 = xsi_mem_cmp(t15, t2, 4U);
    if (t17 == 1)
        goto LAB6;

LAB22:    t18 = (t1 + 13557);
    t20 = xsi_mem_cmp(t18, t2, 4U);
    if (t20 == 1)
        goto LAB7;

LAB23:    t21 = (t1 + 13561);
    t23 = xsi_mem_cmp(t21, t2, 4U);
    if (t23 == 1)
        goto LAB8;

LAB24:    t24 = (t1 + 13565);
    t26 = xsi_mem_cmp(t24, t2, 4U);
    if (t26 == 1)
        goto LAB9;

LAB25:    t27 = (t1 + 13569);
    t29 = xsi_mem_cmp(t27, t2, 4U);
    if (t29 == 1)
        goto LAB10;

LAB26:    t30 = (t1 + 13573);
    t32 = xsi_mem_cmp(t30, t2, 4U);
    if (t32 == 1)
        goto LAB11;

LAB27:    t33 = (t1 + 13577);
    t35 = xsi_mem_cmp(t33, t2, 4U);
    if (t35 == 1)
        goto LAB12;

LAB28:    t36 = (t1 + 13581);
    t38 = xsi_mem_cmp(t36, t2, 4U);
    if (t38 == 1)
        goto LAB13;

LAB29:    t39 = (t1 + 13585);
    t41 = xsi_mem_cmp(t39, t2, 4U);
    if (t41 == 1)
        goto LAB14;

LAB30:    t42 = (t1 + 13589);
    t44 = xsi_mem_cmp(t42, t2, 4U);
    if (t44 == 1)
        goto LAB15;

LAB31:    t45 = (t1 + 13593);
    t47 = xsi_mem_cmp(t45, t2, 4U);
    if (t47 == 1)
        goto LAB16;

LAB32:    t48 = (t1 + 13597);
    t50 = xsi_mem_cmp(t48, t2, 4U);
    if (t50 == 1)
        goto LAB17;

LAB33:    t51 = (t1 + 13601);
    t53 = xsi_mem_cmp(t51, t2, 4U);
    if (t53 == 1)
        goto LAB18;

LAB34:    t54 = (t1 + 13605);
    t56 = xsi_mem_cmp(t54, t2, 4U);
    if (t56 == 1)
        goto LAB19;

LAB35:
LAB20:    t0 = (unsigned char)102;

LAB1:    return t0;
LAB3:    *((char **)t7) = t2;
    goto LAB2;

LAB4:    xsi_error(ng2);
    t0 = 0;
    goto LAB1;

LAB5:    t0 = (unsigned char)48;
    goto LAB1;

LAB6:    t0 = (unsigned char)49;
    goto LAB1;

LAB7:    t0 = (unsigned char)50;
    goto LAB1;

LAB8:    t0 = (unsigned char)51;
    goto LAB1;

LAB9:    t0 = (unsigned char)52;
    goto LAB1;

LAB10:    t0 = (unsigned char)53;
    goto LAB1;

LAB11:    t0 = (unsigned char)54;
    goto LAB1;

LAB12:    t0 = (unsigned char)55;
    goto LAB1;

LAB13:    t0 = (unsigned char)56;
    goto LAB1;

LAB14:    t0 = (unsigned char)57;
    goto LAB1;

LAB15:    t0 = (unsigned char)97;
    goto LAB1;

LAB16:    t0 = (unsigned char)98;
    goto LAB1;

LAB17:    t0 = (unsigned char)99;
    goto LAB1;

LAB18:    t0 = (unsigned char)100;
    goto LAB1;

LAB19:    t0 = (unsigned char)101;
    goto LAB1;

LAB36:;
LAB37:    goto LAB4;

LAB38:    goto LAB4;

LAB39:    goto LAB4;

LAB40:    goto LAB4;

LAB41:    goto LAB4;

LAB42:    goto LAB4;

LAB43:    goto LAB4;

LAB44:    goto LAB4;

LAB45:    goto LAB4;

LAB46:    goto LAB4;

LAB47:    goto LAB4;

LAB48:    goto LAB4;

LAB49:    goto LAB4;

LAB50:    goto LAB4;

LAB51:    goto LAB4;

LAB52:    goto LAB4;

}

char *work_a_4103101987_2372691052_sub_339391397_4163069965(char *t1, char *t2, char *t3)
{
    char t5[16];
    char t6[16];
    char t35[16];
    char *t0;
    char *t7;
    char *t8;
    int t9;
    unsigned int t10;
    unsigned char t11;
    char *t12;
    char *t13;
    int t14;
    char *t15;
    int t16;
    char *t17;
    int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    unsigned char t22;
    char *t23;
    int t24;
    unsigned int t25;
    char *t26;
    int t27;
    char *t28;
    int t29;
    unsigned int t30;
    unsigned int t31;
    char *t32;
    unsigned char t33;
    char *t34;
    char *t36;
    unsigned int t37;
    char *t38;
    int t39;
    char *t40;
    int t41;
    char *t42;
    int t43;
    char *t44;
    char *t45;
    int t46;
    unsigned int t47;

LAB0:    t7 = (t6 + 0U);
    t8 = (t7 + 0U);
    *((int *)t8) = 7;
    t8 = (t7 + 4U);
    *((int *)t8) = 0;
    t8 = (t7 + 8U);
    *((int *)t8) = -1;
    t9 = (0 - 7);
    t10 = (t9 * -1);
    t10 = (t10 + 1);
    t8 = (t7 + 12U);
    *((unsigned int *)t8) = t10;
    t8 = (t5 + 4U);
    t11 = (t3 != 0);
    if (t11 == 1)
        goto LAB3;

LAB2:    t12 = (t5 + 8U);
    *((char **)t12) = t6;
    t13 = (t6 + 0U);
    t14 = *((int *)t13);
    t10 = (t14 - 7);
    t15 = (t6 + 4U);
    t16 = *((int *)t15);
    t17 = (t6 + 8U);
    t18 = *((int *)t17);
    xsi_vhdl_check_range_of_slice(t14, t16, t18, 7, 4, -1);
    t19 = (t10 * 1U);
    t20 = (0 + t19);
    t21 = (t3 + t20);
    t22 = work_a_4103101987_2372691052_sub_3895013716_4163069965(t1, t21);
    t23 = (t6 + 0U);
    t24 = *((int *)t23);
    t25 = (t24 - 3);
    t26 = (t6 + 4U);
    t27 = *((int *)t26);
    t28 = (t6 + 8U);
    t29 = *((int *)t28);
    xsi_vhdl_check_range_of_slice(t24, t27, t29, 3, 0, -1);
    t30 = (t25 * 1U);
    t31 = (0 + t30);
    t32 = (t3 + t31);
    t33 = work_a_4103101987_2372691052_sub_3895013716_4163069965(t1, t32);
    t36 = ((STD_STANDARD) + 656);
    t34 = xsi_base_array_concat(t34, t35, t36, (char)99, t22, (char)99, t33, (char)101);
    t37 = (1U + 1U);
    t0 = xsi_get_transient_memory(t37);
    memcpy(t0, t34, t37);
    t38 = (t35 + 0U);
    t39 = *((int *)t38);
    t40 = (t35 + 4U);
    t41 = *((int *)t40);
    t42 = (t35 + 8U);
    t43 = *((int *)t42);
    t44 = (t2 + 0U);
    t45 = (t44 + 0U);
    *((int *)t45) = t39;
    t45 = (t44 + 4U);
    *((int *)t45) = t41;
    t45 = (t44 + 8U);
    *((int *)t45) = t43;
    t46 = (t41 - t39);
    t47 = (t46 * t43);
    t47 = (t47 + 1);
    t45 = (t44 + 12U);
    *((unsigned int *)t45) = t47;

LAB1:    return t0;
LAB3:    *((char **)t8) = t3;
    goto LAB2;

LAB4:;
}

static void work_a_4103101987_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    int64 t8;

LAB0:    t1 = (t0 + 4576U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(221, ng4);
    t2 = (t0 + 5200);
    t3 = (t2 + 32U);
    t4 = *((char **)t3);
    t5 = (t4 + 32U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(222, ng4);
    t2 = (t0 + 3064U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 4476);
    xsi_process_wait(t2, t8);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(223, ng4);
    t2 = (t0 + 5200);
    t3 = (t2 + 32U);
    t4 = *((char **)t3);
    t5 = (t4 + 32U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(224, ng4);
    t2 = (t0 + 3064U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 4476);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_4103101987_2372691052_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    int64 t7;
    int64 t8;

LAB0:    t1 = (t0 + 4712U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(229, ng4);
    t2 = (t0 + 5236);
    t3 = (t2 + 32U);
    t4 = *((char **)t3);
    t5 = (t4 + 32U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(230, ng4);
    t2 = (t0 + 3132U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 4612);
    xsi_process_wait(t2, t8);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(231, ng4);
    t2 = (t0 + 5236);
    t3 = (t2 + 32U);
    t4 = *((char **)t3);
    t5 = (t4 + 32U);
    t6 = *((char **)t5);
    *((unsigned char *)t6) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(232, ng4);
    t2 = (t0 + 3132U);
    t3 = *((char **)t2);
    t7 = *((int64 *)t3);
    t8 = (t7 / 2);
    t2 = (t0 + 4612);
    xsi_process_wait(t2, t8);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    goto LAB2;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

}

static void work_a_4103101987_2372691052_p_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    int64 t11;
    int64 t12;

LAB0:    t1 = (t0 + 4848U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(237, ng4);
    t2 = (t0 + 1788U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 != 0)
        goto LAB4;

LAB6:    xsi_set_current_line(241, ng4);
    t2 = xsi_get_transient_memory(16U);
    memset(t2, 0, 16U);
    t3 = t2;
    memset(t3, (unsigned char)4, 16U);
    t6 = (t0 + 5272);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 32U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 16U);
    xsi_driver_first_trans_fast(t6);

LAB5:    xsi_set_current_line(244, ng4);
    t2 = (t0 + 1788U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)2);
    if (t5 != 0)
        goto LAB7;

LAB9:
LAB8:    xsi_set_current_line(248, ng4);
    t2 = (t0 + 3132U);
    t3 = *((char **)t2);
    t11 = *((int64 *)t3);
    t12 = (t11 / 2);
    t2 = (t0 + 4748);
    xsi_process_wait(t2, t12);

LAB12:    *((char **)t1) = &&LAB13;

LAB1:    return;
LAB4:    xsi_set_current_line(239, ng4);
    t2 = (t0 + 1512U);
    t6 = *((char **)t2);
    t2 = (t0 + 5272);
    t7 = (t2 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 32U);
    t10 = *((char **)t9);
    memcpy(t10, t6, 16U);
    xsi_driver_first_trans_fast(t2);
    goto LAB5;

LAB7:    xsi_set_current_line(246, ng4);
    t2 = (t0 + 1604U);
    t6 = *((char **)t2);
    t2 = (t0 + 5308);
    t7 = (t2 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 32U);
    t10 = *((char **)t9);
    memcpy(t10, t6, 16U);
    xsi_driver_first_trans_fast(t2);
    goto LAB8;

LAB10:    goto LAB2;

LAB11:    goto LAB10;

LAB13:    goto LAB11;

}

static void work_a_4103101987_2372691052_p_3(char *t0)
{
    char t12[16];
    char t16[16];
    char t18[16];
    char t23[16];
    char t29[16];
    char t40[16];
    char t41[16];
    char t46[16];
    char t48[16];
    char t55[16];
    char t57[16];
    char t65[16];
    char t84[16];
    char t85[16];
    char *t1;
    char *t2;
    int64 t3;
    char *t4;
    int64 t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned char t10;
    unsigned char t11;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    char *t17;
    char *t19;
    char *t20;
    int t21;
    unsigned int t22;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;
    char *t28;
    char *t30;
    char *t31;
    char *t32;
    char *t33;
    char *t34;
    unsigned int t35;
    unsigned int t36;
    char *t37;
    unsigned int t38;
    unsigned int t39;
    char *t42;
    int t43;
    char *t44;
    char *t45;
    char *t47;
    char *t49;
    char *t50;
    unsigned int t51;
    unsigned int t52;
    char *t53;
    char *t54;
    char *t56;
    char *t58;
    char *t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    char *t63;
    char *t64;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    char *t70;
    unsigned int t71;
    unsigned int t72;
    char *t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    char *t78;
    unsigned int t79;
    unsigned int t80;
    char *t81;
    unsigned int t82;
    unsigned int t83;
    int t86;
    char *t87;
    char *t88;
    char *t89;
    char *t90;
    char *t91;
    unsigned int t92;

LAB0:    t1 = (t0 + 4984U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(257, ng4);
    t3 = (100 * 1000LL);
    t2 = (t0 + 4884);
    xsi_process_wait(t2, t3);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(259, ng4);
    t2 = (t0 + 3064U);
    t4 = *((char **)t2);
    t3 = *((int64 *)t4);
    t5 = (t3 * 10);
    t2 = (t0 + 4884);
    xsi_process_wait(t2, t5);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    xsi_set_current_line(262, ng4);
    t2 = (t0 + 3200U);
    t4 = *((char **)t2);
    t2 = (t0 + 5344);
    t6 = (t2 + 32U);
    t7 = *((char **)t6);
    t8 = (t7 + 32U);
    t9 = *((char **)t8);
    memcpy(t9, t4, 4U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(263, ng4);
    t2 = (t0 + 5380);
    t4 = (t2 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(264, ng4);
    t3 = (10 * 1000LL);
    t2 = (t0 + 4884);
    xsi_process_wait(t2, t3);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

LAB12:    xsi_set_current_line(265, ng4);
    t2 = (t0 + 5380);
    t4 = (t2 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(266, ng4);

LAB16:    t2 = (t0 + 1236U);
    t4 = *((char **)t2);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 != 0)
        goto LAB17;

LAB19:    xsi_set_current_line(270, ng4);
    t2 = (t0 + 13609);
    t6 = (t0 + 2708U);
    t7 = *((char **)t6);
    t13 = (15 - 15);
    t14 = (t13 * 1U);
    t15 = (0 + t14);
    t6 = (t7 + t15);
    t8 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t12, t6);
    t17 = ((STD_STANDARD) + 656);
    t19 = (t18 + 0U);
    t20 = (t19 + 0U);
    *((int *)t20) = 1;
    t20 = (t19 + 4U);
    *((int *)t20) = 26;
    t20 = (t19 + 8U);
    *((int *)t20) = 1;
    t21 = (26 - 1);
    t22 = (t21 * 1);
    t22 = (t22 + 1);
    t20 = (t19 + 12U);
    *((unsigned int *)t20) = t22;
    t9 = xsi_base_array_concat(t9, t16, t17, (char)97, t2, t18, (char)97, t8, t12, (char)101);
    t20 = (t0 + 2708U);
    t24 = *((char **)t20);
    t22 = (15 - 7);
    t25 = (t22 * 1U);
    t26 = (0 + t25);
    t20 = (t24 + t26);
    t27 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t23, t20);
    t30 = ((STD_STANDARD) + 656);
    t28 = xsi_base_array_concat(t28, t29, t30, (char)97, t9, t16, (char)97, t27, t23, (char)101);
    t31 = (t0 + 4256U);
    t32 = (t31 + 36U);
    t33 = *((char **)t32);
    t32 = (t33 + 0);
    t34 = (t12 + 12U);
    t35 = *((unsigned int *)t34);
    t35 = (t35 * 1U);
    t36 = (26U + t35);
    t37 = (t23 + 12U);
    t38 = *((unsigned int *)t37);
    t38 = (t38 * 1U);
    t39 = (t36 + t38);
    memcpy(t32, t28, t39);
    xsi_set_current_line(274, ng4);
    t2 = (t0 + 4256U);
    t4 = (t2 + 36U);
    t6 = *((char **)t4);
    xsi_report(t6, 200U, (unsigned char)0);
    xsi_set_current_line(277, ng4);
    t2 = (t0 + 3608U);
    t4 = *((char **)t2);
    t2 = (t0 + 5344);
    t6 = (t2 + 32U);
    t7 = *((char **)t6);
    t8 = (t7 + 32U);
    t9 = *((char **)t8);
    memcpy(t9, t4, 4U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(278, ng4);
    t2 = (t0 + 13635);
    t6 = (t0 + 5416);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 32U);
    t17 = *((char **)t9);
    memcpy(t17, t2, 24U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(279, ng4);
    t2 = (t0 + 13659);
    t6 = (t0 + 5452);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 32U);
    t17 = *((char **)t9);
    memcpy(t17, t2, 16U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(280, ng4);
    t2 = (t0 + 5380);
    t4 = (t2 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(281, ng4);
    t3 = (10 * 1000LL);
    t2 = (t0 + 4884);
    xsi_process_wait(t2, t3);

LAB26:    *((char **)t1) = &&LAB27;
    goto LAB1;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

LAB17:    xsi_set_current_line(267, ng4);
    t3 = (10 * 1000LL);
    t2 = (t0 + 4884);
    xsi_process_wait(t2, t3);

LAB22:    *((char **)t1) = &&LAB23;
    goto LAB1;

LAB18:;
LAB20:    goto LAB16;

LAB21:    goto LAB20;

LAB23:    goto LAB21;

LAB24:    xsi_set_current_line(282, ng4);
    t2 = (t0 + 5380);
    t4 = (t2 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(283, ng4);

LAB28:    t2 = (t0 + 1236U);
    t4 = *((char **)t2);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 != 0)
        goto LAB29;

LAB31:    xsi_set_current_line(287, ng4);
    t2 = (t0 + 13675);
    t6 = (t0 + 1052U);
    t7 = *((char **)t6);
    t13 = (15 - 15);
    t14 = (t13 * 1U);
    t15 = (0 + t14);
    t6 = (t7 + t15);
    t8 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t12, t6);
    t17 = ((STD_STANDARD) + 656);
    t19 = (t18 + 0U);
    t20 = (t19 + 0U);
    *((int *)t20) = 1;
    t20 = (t19 + 4U);
    *((int *)t20) = 10;
    t20 = (t19 + 8U);
    *((int *)t20) = 1;
    t21 = (10 - 1);
    t22 = (t21 * 1);
    t22 = (t22 + 1);
    t20 = (t19 + 12U);
    *((unsigned int *)t20) = t22;
    t9 = xsi_base_array_concat(t9, t16, t17, (char)97, t2, t18, (char)97, t8, t12, (char)101);
    t20 = (t0 + 1052U);
    t24 = *((char **)t20);
    t22 = (15 - 7);
    t25 = (t22 * 1U);
    t26 = (0 + t25);
    t20 = (t24 + t26);
    t27 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t23, t20);
    t30 = ((STD_STANDARD) + 656);
    t28 = xsi_base_array_concat(t28, t29, t30, (char)97, t9, t16, (char)97, t27, t23, (char)101);
    t31 = (t0 + 13685);
    t34 = ((STD_STANDARD) + 656);
    t37 = (t41 + 0U);
    t42 = (t37 + 0U);
    *((int *)t42) = 1;
    t42 = (t37 + 4U);
    *((int *)t42) = 14;
    t42 = (t37 + 8U);
    *((int *)t42) = 1;
    t43 = (14 - 1);
    t35 = (t43 * 1);
    t35 = (t35 + 1);
    t42 = (t37 + 12U);
    *((unsigned int *)t42) = t35;
    t33 = xsi_base_array_concat(t33, t40, t34, (char)97, t28, t29, (char)97, t31, t41, (char)101);
    t42 = (t0 + 960U);
    t44 = *((char **)t42);
    t35 = (23 - 19);
    t36 = (t35 * 1U);
    t38 = (0 + t36);
    t42 = (t44 + t38);
    t10 = work_a_4103101987_2372691052_sub_3895013716_4163069965(t0, t42);
    t47 = ((STD_STANDARD) + 656);
    t45 = xsi_base_array_concat(t45, t46, t47, (char)97, t33, t40, (char)99, t10, (char)101);
    t49 = (t0 + 960U);
    t50 = *((char **)t49);
    t39 = (23 - 15);
    t51 = (t39 * 1U);
    t52 = (0 + t51);
    t49 = (t50 + t52);
    t53 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t48, t49);
    t56 = ((STD_STANDARD) + 656);
    t54 = xsi_base_array_concat(t54, t55, t56, (char)97, t45, t46, (char)97, t53, t48, (char)101);
    t58 = (t0 + 960U);
    t59 = *((char **)t58);
    t60 = (23 - 7);
    t61 = (t60 * 1U);
    t62 = (0 + t61);
    t58 = (t59 + t62);
    t63 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t57, t58);
    t66 = ((STD_STANDARD) + 656);
    t64 = xsi_base_array_concat(t64, t65, t66, (char)97, t54, t55, (char)97, t63, t57, (char)101);
    t67 = (t0 + 4256U);
    t68 = (t67 + 36U);
    t69 = *((char **)t68);
    t68 = (t69 + 0);
    t70 = (t12 + 12U);
    t71 = *((unsigned int *)t70);
    t71 = (t71 * 1U);
    t72 = (10U + t71);
    t73 = (t23 + 12U);
    t74 = *((unsigned int *)t73);
    t74 = (t74 * 1U);
    t75 = (t72 + t74);
    t76 = (t75 + 14U);
    t77 = (t76 + 1U);
    t78 = (t48 + 12U);
    t79 = *((unsigned int *)t78);
    t79 = (t79 * 1U);
    t80 = (t77 + t79);
    t81 = (t57 + 12U);
    t82 = *((unsigned int *)t81);
    t82 = (t82 * 1U);
    t83 = (t80 + t82);
    memcpy(t68, t64, t83);
    xsi_set_current_line(295, ng4);
    t2 = (t0 + 4256U);
    t4 = (t2 + 36U);
    t6 = *((char **)t4);
    xsi_report(t6, 200U, (unsigned char)0);
    xsi_set_current_line(298, ng4);
    t2 = (t0 + 3608U);
    t4 = *((char **)t2);
    t2 = (t0 + 5344);
    t6 = (t2 + 32U);
    t7 = *((char **)t6);
    t8 = (t7 + 32U);
    t9 = *((char **)t8);
    memcpy(t9, t4, 4U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(299, ng4);
    t2 = (t0 + 13699);
    t6 = (t0 + 5416);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 32U);
    t17 = *((char **)t9);
    memcpy(t17, t2, 24U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(300, ng4);
    t2 = (t0 + 13723);
    t6 = (t0 + 5452);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 32U);
    t17 = *((char **)t9);
    memcpy(t17, t2, 16U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(301, ng4);
    t2 = (t0 + 5380);
    t4 = (t2 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(302, ng4);
    t3 = (10 * 1000LL);
    t2 = (t0 + 4884);
    xsi_process_wait(t2, t3);

LAB38:    *((char **)t1) = &&LAB39;
    goto LAB1;

LAB25:    goto LAB24;

LAB27:    goto LAB25;

LAB29:    xsi_set_current_line(284, ng4);
    t3 = (10 * 1000LL);
    t2 = (t0 + 4884);
    xsi_process_wait(t2, t3);

LAB34:    *((char **)t1) = &&LAB35;
    goto LAB1;

LAB30:;
LAB32:    goto LAB28;

LAB33:    goto LAB32;

LAB35:    goto LAB33;

LAB36:    xsi_set_current_line(303, ng4);
    t2 = (t0 + 5380);
    t4 = (t2 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(304, ng4);

LAB40:    t2 = (t0 + 1236U);
    t4 = *((char **)t2);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 != 0)
        goto LAB41;

LAB43:    xsi_set_current_line(308, ng4);
    t2 = (t0 + 13739);
    t6 = (t0 + 1052U);
    t7 = *((char **)t6);
    t13 = (15 - 15);
    t14 = (t13 * 1U);
    t15 = (0 + t14);
    t6 = (t7 + t15);
    t8 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t12, t6);
    t17 = ((STD_STANDARD) + 656);
    t19 = (t18 + 0U);
    t20 = (t19 + 0U);
    *((int *)t20) = 1;
    t20 = (t19 + 4U);
    *((int *)t20) = 10;
    t20 = (t19 + 8U);
    *((int *)t20) = 1;
    t21 = (10 - 1);
    t22 = (t21 * 1);
    t22 = (t22 + 1);
    t20 = (t19 + 12U);
    *((unsigned int *)t20) = t22;
    t9 = xsi_base_array_concat(t9, t16, t17, (char)97, t2, t18, (char)97, t8, t12, (char)101);
    t20 = (t0 + 1052U);
    t24 = *((char **)t20);
    t22 = (15 - 7);
    t25 = (t22 * 1U);
    t26 = (0 + t25);
    t20 = (t24 + t26);
    t27 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t23, t20);
    t30 = ((STD_STANDARD) + 656);
    t28 = xsi_base_array_concat(t28, t29, t30, (char)97, t9, t16, (char)97, t27, t23, (char)101);
    t31 = (t0 + 13749);
    t34 = ((STD_STANDARD) + 656);
    t37 = (t41 + 0U);
    t42 = (t37 + 0U);
    *((int *)t42) = 1;
    t42 = (t37 + 4U);
    *((int *)t42) = 14;
    t42 = (t37 + 8U);
    *((int *)t42) = 1;
    t43 = (14 - 1);
    t35 = (t43 * 1);
    t35 = (t35 + 1);
    t42 = (t37 + 12U);
    *((unsigned int *)t42) = t35;
    t33 = xsi_base_array_concat(t33, t40, t34, (char)97, t28, t29, (char)97, t31, t41, (char)101);
    t42 = (t0 + 960U);
    t44 = *((char **)t42);
    t35 = (23 - 19);
    t36 = (t35 * 1U);
    t38 = (0 + t36);
    t42 = (t44 + t38);
    t10 = work_a_4103101987_2372691052_sub_3895013716_4163069965(t0, t42);
    t47 = ((STD_STANDARD) + 656);
    t45 = xsi_base_array_concat(t45, t46, t47, (char)97, t33, t40, (char)99, t10, (char)101);
    t49 = (t0 + 960U);
    t50 = *((char **)t49);
    t39 = (23 - 15);
    t51 = (t39 * 1U);
    t52 = (0 + t51);
    t49 = (t50 + t52);
    t53 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t48, t49);
    t56 = ((STD_STANDARD) + 656);
    t54 = xsi_base_array_concat(t54, t55, t56, (char)97, t45, t46, (char)97, t53, t48, (char)101);
    t58 = (t0 + 960U);
    t59 = *((char **)t58);
    t60 = (23 - 7);
    t61 = (t60 * 1U);
    t62 = (0 + t61);
    t58 = (t59 + t62);
    t63 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t57, t58);
    t66 = ((STD_STANDARD) + 656);
    t64 = xsi_base_array_concat(t64, t65, t66, (char)97, t54, t55, (char)97, t63, t57, (char)101);
    t67 = (t0 + 4256U);
    t68 = (t67 + 36U);
    t69 = *((char **)t68);
    t68 = (t69 + 0);
    t70 = (t12 + 12U);
    t71 = *((unsigned int *)t70);
    t71 = (t71 * 1U);
    t72 = (10U + t71);
    t73 = (t23 + 12U);
    t74 = *((unsigned int *)t73);
    t74 = (t74 * 1U);
    t75 = (t72 + t74);
    t76 = (t75 + 14U);
    t77 = (t76 + 1U);
    t78 = (t48 + 12U);
    t79 = *((unsigned int *)t78);
    t79 = (t79 * 1U);
    t80 = (t77 + t79);
    t81 = (t57 + 12U);
    t82 = *((unsigned int *)t81);
    t82 = (t82 * 1U);
    t83 = (t80 + t82);
    memcpy(t68, t64, t83);
    xsi_set_current_line(316, ng4);
    t2 = (t0 + 4256U);
    t4 = (t2 + 36U);
    t6 = *((char **)t4);
    xsi_report(t6, 200U, (unsigned char)0);
    xsi_set_current_line(319, ng4);
    t2 = (t0 + 3676U);
    t4 = *((char **)t2);
    t2 = (t0 + 5344);
    t6 = (t2 + 32U);
    t7 = *((char **)t6);
    t8 = (t7 + 32U);
    t9 = *((char **)t8);
    memcpy(t9, t4, 4U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(320, ng4);
    t2 = (t0 + 13763);
    t6 = (t0 + 5416);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 32U);
    t17 = *((char **)t9);
    memcpy(t17, t2, 24U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(321, ng4);
    t2 = (t0 + 5380);
    t4 = (t2 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(322, ng4);
    t3 = (10 * 1000LL);
    t2 = (t0 + 4884);
    xsi_process_wait(t2, t3);

LAB50:    *((char **)t1) = &&LAB51;
    goto LAB1;

LAB37:    goto LAB36;

LAB39:    goto LAB37;

LAB41:    xsi_set_current_line(305, ng4);
    t3 = (10 * 1000LL);
    t2 = (t0 + 4884);
    xsi_process_wait(t2, t3);

LAB46:    *((char **)t1) = &&LAB47;
    goto LAB1;

LAB42:;
LAB44:    goto LAB40;

LAB45:    goto LAB44;

LAB47:    goto LAB45;

LAB48:    xsi_set_current_line(323, ng4);
    t2 = (t0 + 5380);
    t4 = (t2 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(324, ng4);

LAB52:    t2 = (t0 + 1236U);
    t4 = *((char **)t2);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 != 0)
        goto LAB53;

LAB55:    xsi_set_current_line(328, ng4);
    t2 = (t0 + 13787);
    t6 = (t0 + 2708U);
    t7 = *((char **)t6);
    t13 = (15 - 15);
    t14 = (t13 * 1U);
    t15 = (0 + t14);
    t6 = (t7 + t15);
    t8 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t12, t6);
    t17 = ((STD_STANDARD) + 656);
    t19 = (t18 + 0U);
    t20 = (t19 + 0U);
    *((int *)t20) = 1;
    t20 = (t19 + 4U);
    *((int *)t20) = 6;
    t20 = (t19 + 8U);
    *((int *)t20) = 1;
    t21 = (6 - 1);
    t22 = (t21 * 1);
    t22 = (t22 + 1);
    t20 = (t19 + 12U);
    *((unsigned int *)t20) = t22;
    t9 = xsi_base_array_concat(t9, t16, t17, (char)97, t2, t18, (char)97, t8, t12, (char)101);
    t20 = (t0 + 2708U);
    t24 = *((char **)t20);
    t22 = (15 - 7);
    t25 = (t22 * 1U);
    t26 = (0 + t25);
    t20 = (t24 + t26);
    t27 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t23, t20);
    t30 = ((STD_STANDARD) + 656);
    t28 = xsi_base_array_concat(t28, t29, t30, (char)97, t9, t16, (char)97, t27, t23, (char)101);
    t31 = (t0 + 13793);
    t34 = ((STD_STANDARD) + 656);
    t37 = (t41 + 0U);
    t42 = (t37 + 0U);
    *((int *)t42) = 1;
    t42 = (t37 + 4U);
    *((int *)t42) = 16;
    t42 = (t37 + 8U);
    *((int *)t42) = 1;
    t43 = (16 - 1);
    t35 = (t43 * 1);
    t35 = (t35 + 1);
    t42 = (t37 + 12U);
    *((unsigned int *)t42) = t35;
    t33 = xsi_base_array_concat(t33, t40, t34, (char)97, t28, t29, (char)97, t31, t41, (char)101);
    t42 = (t0 + 960U);
    t44 = *((char **)t42);
    t35 = (23 - 19);
    t36 = (t35 * 1U);
    t38 = (0 + t36);
    t42 = (t44 + t38);
    t10 = work_a_4103101987_2372691052_sub_3895013716_4163069965(t0, t42);
    t47 = ((STD_STANDARD) + 656);
    t45 = xsi_base_array_concat(t45, t46, t47, (char)97, t33, t40, (char)99, t10, (char)101);
    t49 = (t0 + 960U);
    t50 = *((char **)t49);
    t39 = (23 - 15);
    t51 = (t39 * 1U);
    t52 = (0 + t51);
    t49 = (t50 + t52);
    t53 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t48, t49);
    t56 = ((STD_STANDARD) + 656);
    t54 = xsi_base_array_concat(t54, t55, t56, (char)97, t45, t46, (char)97, t53, t48, (char)101);
    t58 = (t0 + 960U);
    t59 = *((char **)t58);
    t60 = (23 - 7);
    t61 = (t60 * 1U);
    t62 = (0 + t61);
    t58 = (t59 + t62);
    t63 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t57, t58);
    t66 = ((STD_STANDARD) + 656);
    t64 = xsi_base_array_concat(t64, t65, t66, (char)97, t54, t55, (char)97, t63, t57, (char)101);
    t67 = (t0 + 13809);
    t70 = ((STD_STANDARD) + 656);
    t73 = (t85 + 0U);
    t78 = (t73 + 0U);
    *((int *)t78) = 1;
    t78 = (t73 + 4U);
    *((int *)t78) = 2;
    t78 = (t73 + 8U);
    *((int *)t78) = 1;
    t86 = (2 - 1);
    t71 = (t86 * 1);
    t71 = (t71 + 1);
    t78 = (t73 + 12U);
    *((unsigned int *)t78) = t71;
    t69 = xsi_base_array_concat(t69, t84, t70, (char)97, t64, t65, (char)97, t67, t85, (char)101);
    t78 = (t0 + 4256U);
    t81 = (t78 + 36U);
    t87 = *((char **)t81);
    t81 = (t87 + 0);
    t88 = (t12 + 12U);
    t71 = *((unsigned int *)t88);
    t71 = (t71 * 1U);
    t72 = (6U + t71);
    t89 = (t23 + 12U);
    t74 = *((unsigned int *)t89);
    t74 = (t74 * 1U);
    t75 = (t72 + t74);
    t76 = (t75 + 16U);
    t77 = (t76 + 1U);
    t90 = (t48 + 12U);
    t79 = *((unsigned int *)t90);
    t79 = (t79 * 1U);
    t80 = (t77 + t79);
    t91 = (t57 + 12U);
    t82 = *((unsigned int *)t91);
    t82 = (t82 * 1U);
    t83 = (t80 + t82);
    t92 = (t83 + 2U);
    memcpy(t81, t69, t92);
    xsi_set_current_line(336, ng4);
    t2 = (t0 + 4256U);
    t4 = (t2 + 36U);
    t6 = *((char **)t4);
    xsi_report(t6, 200U, (unsigned char)0);
    xsi_set_current_line(339, ng4);
    t2 = (t0 + 3676U);
    t4 = *((char **)t2);
    t2 = (t0 + 5344);
    t6 = (t2 + 32U);
    t7 = *((char **)t6);
    t8 = (t7 + 32U);
    t9 = *((char **)t8);
    memcpy(t9, t4, 4U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(340, ng4);
    t2 = (t0 + 13811);
    t6 = (t0 + 5416);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 32U);
    t17 = *((char **)t9);
    memcpy(t17, t2, 24U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(341, ng4);
    t2 = (t0 + 5380);
    t4 = (t2 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(342, ng4);
    t3 = (10 * 1000LL);
    t2 = (t0 + 4884);
    xsi_process_wait(t2, t3);

LAB62:    *((char **)t1) = &&LAB63;
    goto LAB1;

LAB49:    goto LAB48;

LAB51:    goto LAB49;

LAB53:    xsi_set_current_line(325, ng4);
    t3 = (10 * 1000LL);
    t2 = (t0 + 4884);
    xsi_process_wait(t2, t3);

LAB58:    *((char **)t1) = &&LAB59;
    goto LAB1;

LAB54:;
LAB56:    goto LAB52;

LAB57:    goto LAB56;

LAB59:    goto LAB57;

LAB60:    xsi_set_current_line(343, ng4);
    t2 = (t0 + 5380);
    t4 = (t2 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(344, ng4);

LAB64:    t2 = (t0 + 1236U);
    t4 = *((char **)t2);
    t10 = *((unsigned char *)t4);
    t11 = (t10 == (unsigned char)3);
    if (t11 != 0)
        goto LAB65;

LAB67:    xsi_set_current_line(348, ng4);
    t2 = (t0 + 13835);
    t6 = (t0 + 2708U);
    t7 = *((char **)t6);
    t13 = (15 - 15);
    t14 = (t13 * 1U);
    t15 = (0 + t14);
    t6 = (t7 + t15);
    t8 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t12, t6);
    t17 = ((STD_STANDARD) + 656);
    t19 = (t18 + 0U);
    t20 = (t19 + 0U);
    *((int *)t20) = 1;
    t20 = (t19 + 4U);
    *((int *)t20) = 6;
    t20 = (t19 + 8U);
    *((int *)t20) = 1;
    t21 = (6 - 1);
    t22 = (t21 * 1);
    t22 = (t22 + 1);
    t20 = (t19 + 12U);
    *((unsigned int *)t20) = t22;
    t9 = xsi_base_array_concat(t9, t16, t17, (char)97, t2, t18, (char)97, t8, t12, (char)101);
    t20 = (t0 + 2708U);
    t24 = *((char **)t20);
    t22 = (15 - 7);
    t25 = (t22 * 1U);
    t26 = (0 + t25);
    t20 = (t24 + t26);
    t27 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t23, t20);
    t30 = ((STD_STANDARD) + 656);
    t28 = xsi_base_array_concat(t28, t29, t30, (char)97, t9, t16, (char)97, t27, t23, (char)101);
    t31 = (t0 + 13841);
    t34 = ((STD_STANDARD) + 656);
    t37 = (t41 + 0U);
    t42 = (t37 + 0U);
    *((int *)t42) = 1;
    t42 = (t37 + 4U);
    *((int *)t42) = 16;
    t42 = (t37 + 8U);
    *((int *)t42) = 1;
    t43 = (16 - 1);
    t35 = (t43 * 1);
    t35 = (t35 + 1);
    t42 = (t37 + 12U);
    *((unsigned int *)t42) = t35;
    t33 = xsi_base_array_concat(t33, t40, t34, (char)97, t28, t29, (char)97, t31, t41, (char)101);
    t42 = (t0 + 960U);
    t44 = *((char **)t42);
    t35 = (23 - 19);
    t36 = (t35 * 1U);
    t38 = (0 + t36);
    t42 = (t44 + t38);
    t10 = work_a_4103101987_2372691052_sub_3895013716_4163069965(t0, t42);
    t47 = ((STD_STANDARD) + 656);
    t45 = xsi_base_array_concat(t45, t46, t47, (char)97, t33, t40, (char)99, t10, (char)101);
    t49 = (t0 + 960U);
    t50 = *((char **)t49);
    t39 = (23 - 15);
    t51 = (t39 * 1U);
    t52 = (0 + t51);
    t49 = (t50 + t52);
    t53 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t48, t49);
    t56 = ((STD_STANDARD) + 656);
    t54 = xsi_base_array_concat(t54, t55, t56, (char)97, t45, t46, (char)97, t53, t48, (char)101);
    t58 = (t0 + 960U);
    t59 = *((char **)t58);
    t60 = (23 - 7);
    t61 = (t60 * 1U);
    t62 = (0 + t61);
    t58 = (t59 + t62);
    t63 = work_a_4103101987_2372691052_sub_339391397_4163069965(t0, t57, t58);
    t66 = ((STD_STANDARD) + 656);
    t64 = xsi_base_array_concat(t64, t65, t66, (char)97, t54, t55, (char)97, t63, t57, (char)101);
    t67 = (t0 + 13857);
    t70 = ((STD_STANDARD) + 656);
    t73 = (t85 + 0U);
    t78 = (t73 + 0U);
    *((int *)t78) = 1;
    t78 = (t73 + 4U);
    *((int *)t78) = 2;
    t78 = (t73 + 8U);
    *((int *)t78) = 1;
    t86 = (2 - 1);
    t71 = (t86 * 1);
    t71 = (t71 + 1);
    t78 = (t73 + 12U);
    *((unsigned int *)t78) = t71;
    t69 = xsi_base_array_concat(t69, t84, t70, (char)97, t64, t65, (char)97, t67, t85, (char)101);
    t78 = (t0 + 4256U);
    t81 = (t78 + 36U);
    t87 = *((char **)t81);
    t81 = (t87 + 0);
    t88 = (t12 + 12U);
    t71 = *((unsigned int *)t88);
    t71 = (t71 * 1U);
    t72 = (6U + t71);
    t89 = (t23 + 12U);
    t74 = *((unsigned int *)t89);
    t74 = (t74 * 1U);
    t75 = (t72 + t74);
    t76 = (t75 + 16U);
    t77 = (t76 + 1U);
    t90 = (t48 + 12U);
    t79 = *((unsigned int *)t90);
    t79 = (t79 * 1U);
    t80 = (t77 + t79);
    t91 = (t57 + 12U);
    t82 = *((unsigned int *)t91);
    t82 = (t82 * 1U);
    t83 = (t80 + t82);
    t92 = (t83 + 2U);
    memcpy(t81, t69, t92);
    xsi_set_current_line(356, ng4);
    t2 = (t0 + 4256U);
    t4 = (t2 + 36U);
    t6 = *((char **)t4);
    xsi_report(t6, 200U, (unsigned char)0);
    xsi_set_current_line(359, ng4);

LAB74:    *((char **)t1) = &&LAB75;
    goto LAB1;

LAB61:    goto LAB60;

LAB63:    goto LAB61;

LAB65:    xsi_set_current_line(345, ng4);
    t3 = (10 * 1000LL);
    t2 = (t0 + 4884);
    xsi_process_wait(t2, t3);

LAB70:    *((char **)t1) = &&LAB71;
    goto LAB1;

LAB66:;
LAB68:    goto LAB64;

LAB69:    goto LAB68;

LAB71:    goto LAB69;

LAB72:    goto LAB2;

LAB73:    goto LAB72;

LAB75:    goto LAB73;

}


void ieee_p_2592010699_sub_3130575329_503743352();

void ieee_p_2592010699_sub_3130575329_503743352();

extern void work_a_4103101987_2372691052_init()
{
	static char *pe[] = {(void *)work_a_4103101987_2372691052_p_0,(void *)work_a_4103101987_2372691052_p_1,(void *)work_a_4103101987_2372691052_p_2,(void *)work_a_4103101987_2372691052_p_3};
	static char *se[] = {(void *)work_a_4103101987_2372691052_sub_892846079_4163069965,(void *)work_a_4103101987_2372691052_sub_3895013716_4163069965,(void *)work_a_4103101987_2372691052_sub_339391397_4163069965};
	xsi_register_didat("work_a_4103101987_2372691052", "isim/FlashTest_isim_beh.exe.sim/work/a_4103101987_2372691052.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
	xsi_register_resolution_function(1, 2, (void *)ieee_p_2592010699_sub_3130575329_503743352, 5);
	xsi_register_resolution_function(2, 2, (void *)ieee_p_2592010699_sub_3130575329_503743352, 5);
}
