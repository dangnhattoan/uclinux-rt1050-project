cmd_/home/build/fdpic/install/sysroot/usr/include/linux/isdn/.install := /bin/sh /home/build/fdpic/scratch/kernel/scripts/headers_install.sh /home/build/fdpic/install/sysroot/usr/include/linux/isdn /home/build/fdpic/scratch/kernel/include/uapi/linux/isdn capicmd.h; /bin/sh /home/build/fdpic/scratch/kernel/scripts/headers_install.sh /home/build/fdpic/install/sysroot/usr/include/linux/isdn /home/build/fdpic/scratch/kernel/include/linux/isdn ; /bin/sh /home/build/fdpic/scratch/kernel/scripts/headers_install.sh /home/build/fdpic/install/sysroot/usr/include/linux/isdn /home/build/fdpic/build/kernelheader/include/generated/uapi/linux/isdn ; for F in ; do echo "\#include <asm-generic/$$F>" > /home/build/fdpic/install/sysroot/usr/include/linux/isdn/$$F; done; touch /home/build/fdpic/install/sysroot/usr/include/linux/isdn/.install
