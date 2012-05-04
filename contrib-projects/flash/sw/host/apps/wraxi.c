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
    uint64_t val;

    if(argc < 3){
        printf("usage: rdaxi reg_addr(in hex) reg_val(in_hex)\n\n");
        return 0;
    }
    else{
        sscanf(argv[1], "%llx", &addr);
        sscanf(argv[2], "%llx", &val);
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

    v = (addr << 32) + val;
    if(ioctl(f, NF10_IOCTL_CMD_WRITE_REG, v) < 0){
        perror("nf10 ioctl failed");
        return 0;
    }
    printf("\n");

    close(f);
    
    return 0;
}
