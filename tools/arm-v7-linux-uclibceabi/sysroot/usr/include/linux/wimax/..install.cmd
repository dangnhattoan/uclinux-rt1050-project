cmd_/home/build/fdpic/install/sysroot/usr/include/linux/wimax/.install := /bin/sh /home/build/fdpic/scratch/kernel/scripts/headers_install.sh /home/build/fdpic/install/sysroot/usr/include/linux/wimax /home/build/fdpic/scratch/kernel/include/uapi/linux/wimax i2400m.h; /bin/sh /home/build/fdpic/scratch/kernel/scripts/headers_install.sh /home/build/fdpic/install/sysroot/usr/include/linux/wimax /home/build/fdpic/scratch/kernel/include/linux/wimax ; /bin/sh /home/build/fdpic/scratch/kernel/scripts/headers_install.sh /home/build/fdpic/install/sysroot/usr/include/linux/wimax /home/build/fdpic/build/kernelheader/include/generated/uapi/linux/wimax ; for F in ; do echo "\#include <asm-generic/$$F>" > /home/build/fdpic/install/sysroot/usr/include/linux/wimax/$$F; done; touch /home/build/fdpic/install/sysroot/usr/include/linux/wimax/.install
