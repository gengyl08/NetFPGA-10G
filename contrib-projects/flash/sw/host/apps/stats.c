#include <fcntl.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

#define NF10_IOCTL_CMD_READ_STAT (SIOCDEVPRIVATE+0)
#define NF10_IOCTL_CMD_WRITE_REG (SIOCDEVPRIVATE+1)
#define NF10_IOCTL_CMD_READ_REG (SIOCDEVPRIVATE+2)

int main(){
    int f;
    uint64_t v;

    //----------------------------------------------------
    //-- open nf10 file descriptor for all the fun stuff
    //----------------------------------------------------
    f = open("/dev/nf10", O_RDWR);
    if(f < 0){
        perror("/dev/nf10");
        return 0;
    }
    
    printf("\n");

    v = 128+2;
    if(ioctl(f, NF10_IOCTL_CMD_READ_STAT, &v) < 0){
        perror("nf10 ioctl failed");
        return 0;
    }
    printf("PCIe RX: number of WRITE pkts:      %lld\n", v);

    v = 128+3;
    if(ioctl(f, NF10_IOCTL_CMD_READ_STAT, &v) < 0){
        perror("nf10 ioctl failed");
        return 0;
    }
    printf("PCIe RX: number of READ pkts:       %lld\n", v);

    v = 128+4;
    if(ioctl(f, NF10_IOCTL_CMD_READ_STAT, &v) < 0){
        perror("nf10 ioctl failed");
        return 0;
    }
    printf("PCIe RX: number of COMPLETION pkts: %lld\n", v);

    v = 128+5;
    if(ioctl(f, NF10_IOCTL_CMD_READ_STAT, &v) < 0){
        perror("nf10 ioctl failed");
        return 0;
    }
    printf("PCIe RX: number of ERRORS:          %lld\n", v);

    printf("\n");

    v = 128+9;
    if(ioctl(f, NF10_IOCTL_CMD_READ_STAT, &v) < 0){
        perror("nf10 ioctl failed");
        return 0;
    }
    printf("PCIe TX: number of WRITE pkts:      %lld\n", v);

    v = 128+10;
    if(ioctl(f, NF10_IOCTL_CMD_READ_STAT, &v) < 0){
        perror("nf10 ioctl failed");
        return 0;
    }
    printf("PCIe TX: number of READ pkts:       %lld\n", v);

    v = 128+11;
    if(ioctl(f, NF10_IOCTL_CMD_READ_STAT, &v) < 0){
        perror("nf10 ioctl failed");
        return 0;
    }
    printf("PCIe TX: number of COMPLETION pkts: %lld\n", v);

    v = 128+12;
    if(ioctl(f, NF10_IOCTL_CMD_READ_STAT, &v) < 0){
        perror("nf10 ioctl failed");
        return 0;
    }
    printf("PCIe TX: number of ERRORS:          %lld\n", v);

    printf("\n");

    v = 128+18;
    if(ioctl(f, NF10_IOCTL_CMD_READ_STAT, &v) < 0){
        perror("nf10 ioctl failed");
        return 0;
    }
    printf("AXIS TX: number of packets: %lld\n", v);

    v = 128+17;
    if(ioctl(f, NF10_IOCTL_CMD_READ_STAT, &v) < 0){
        perror("nf10 ioctl failed");
        return 0;
    }
    printf("AXIS TX: number of words:   %lld\n", v);

    v = 128+22;
    if(ioctl(f, NF10_IOCTL_CMD_READ_STAT, &v) < 0){
        perror("nf10 ioctl failed");
        return 0;
    }
    printf("AXIS RX: number of packets: %lld\n", v);

    v = 128+21;
    if(ioctl(f, NF10_IOCTL_CMD_READ_STAT, &v) < 0){
        perror("nf10 ioctl failed");
        return 0;
    }
    printf("AXIS RX: number of words:   %lld\n", v);

    v = 128+23;
    if(ioctl(f, NF10_IOCTL_CMD_READ_STAT, &v) < 0){
        perror("nf10 ioctl failed");
        return 0;
    }
    printf("AXIS RX: number of errors:  %lld\n", v);
    
    printf("\n");

    close(f);
    
    return 0;
}
