#include <netlink/netlink.h>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char* argv[])
{
    int         i;
    int         err;

    i = 4;
    while(i) {
        err = nf10_reg_wr(i, i);
        if(err)
            printf("0x%08x: ERROR: %s\n", i, nl_geterror(err));
        else
            printf("0x%08x: wr 0x%08x\n", i, i);     

        i += 4;
    }

    return 0;
}
