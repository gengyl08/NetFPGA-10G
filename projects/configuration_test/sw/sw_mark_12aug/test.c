#include <stdlib.h>



int main()
{


#define Flash_BaseAddress   0x00000000
#define CMD_REG_OFFSET      0x00000000
#define DATA_IN_REG_OFFSET  0x00000004
#define ADDR_REG_OFFSET     0x00000008
#define DATA_OUT_REG_OFFSET 0x0000000C


#define address1 0xDE000000
#define address2 0xDFFF0000



system ("./swctl" address1+" 0xDFFF0000 wunreset 0" );
//system ("./swctl 0xDE000000 0xDFFF0000 wop 0 initialize" );
//system ("./swctl 0xDE000000 0xDFFF0000 wop 0 start" );



return 0;

}
