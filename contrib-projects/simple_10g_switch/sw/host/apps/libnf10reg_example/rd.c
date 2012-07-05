#include <netlink/netlink.h>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char* argv[])
{
    int         i;
    int         x;
    int         err;

    i = 4;
    while(i) {
        err = nf10_reg_rd(i, &x);
        if(err)
            printf("0x%08x: ERROR: %s\n", i, nl_geterror(err));
        else
            printf("0x%08x: rd 0x%08x\n", i, x);     

        i += 4;
    }

    return 0;
}
