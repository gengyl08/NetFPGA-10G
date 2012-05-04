obj-m += nf10.o
nf10-objs += nf10driver.o
nf10-objs += nf10iface.o
nf10-objs += nf10fops.o
nf10-objs += nf10priv.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean