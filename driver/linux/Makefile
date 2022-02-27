# Linux 2.6 Kernel Makefile
# New format.  All building is done within the kernel development
# tree.  The user's makefile no longer needs to specify all build rules
# and kernel defines.  Its all done by the kernel now.
#
# For full details on bulding a kernel module see:
#
# To build with more verbose output run:
#  $> make V=1

#    install -m 0644  9-ea90_dma.rules /etc/udev/rules.d
#    /sbin/insmod -f ea90_dma.ko
#
#    /sbin/rmmod -v ea90_dma.ko
#


ifneq ($(KERNELRELEASE),)

obj-m := ea90_dma.o
ea90_dma-objs := tsev_driver.o tsev_file_ops.o tsev_irq_ops.o
EXTRA_CFLAGS += -I.

else

KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

all :
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

clean :
	rm *.o *.ko *.mod.c
endif
