/* NetFPGA-10G http://www.netfpga.org
 * 
 * NetFPGA-10G Register Access Library Header File
 *
 * Description:
 *  Set of definitions for the NF10 register access library.
 *
 * Revision history: 
 *  2011/07/06 Jonathan Ellithorpe: Created.
 */


/* Function prototypes. */
int         nf10_reg_rd(uint32_t addr, uint32_t *val_ptr);
int         nf10_reg_wr(uint32_t addr, uint32_t val);
