#include <fcntl.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

#define NF10_IOCTL_CMD_READ_STAT (SIOCDEVPRIVATE+0)
#define NF10_IOCTL_CMD_WRITE_REG (SIOCDEVPRIVATE+1)
#define NF10_IOCTL_CMD_READ_REG (SIOCDEVPRIVATE+2)

int main(int argc, char* argv[]){
    int f;
    uint64_t v;
    uint64_t addr;

    if(argc < 2){
        printf("usage: rdaxi reg_addr(in hex)\n\n");
        return 0;
    }
    else{
        sscanf(argv[1], "%llx", &addr);
    }

    //----------------------------------------------------
    //-- open nf10 file descriptor for all the fun stuff
    //----------------------------------------------------
    f = open("/dev/nf10", O_RDWR);
    if(f < 0){
        perror("/dev/nf10");
        return 0;
    }
    
    printf("\n");

    v = addr;
    if(ioctl(f, NF10_IOCTL_CMD_READ_REG, &v) < 0){
        perror("nf10 ioctl failed");
        return 0;
    }
    v &= 0xffffffff;

    printf("AXI reg 0x%llx=0x%llx\n", addr, v);
    
    printf("\n");

    close(f);
    
    return 0;
}
