cmd_/home/build/fdpic/install/sysroot/usr/include/linux/tc_act/.install := /bin/sh /home/build/fdpic/scratch/kernel/scripts/headers_install.sh /home/build/fdpic/install/sysroot/usr/include/linux/tc_act /home/build/fdpic/scratch/kernel/include/uapi/linux/tc_act tc_csum.h tc_defact.h tc_gact.h tc_ipt.h tc_mirred.h tc_nat.h tc_pedit.h tc_skbedit.h; /bin/sh /home/build/fdpic/scratch/kernel/scripts/headers_install.sh /home/build/fdpic/install/sysroot/usr/include/linux/tc_act /home/build/fdpic/scratch/kernel/include/linux/tc_act ; /bin/sh /home/build/fdpic/scratch/kernel/scripts/headers_install.sh /home/build/fdpic/install/sysroot/usr/include/linux/tc_act /home/build/fdpic/build/kernelheader/include/generated/uapi/linux/tc_act ; for F in ; do echo "\#include <asm-generic/$$F>" > /home/build/fdpic/install/sysroot/usr/include/linux/tc_act/$$F; done; touch /home/build/fdpic/install/sysroot/usr/include/linux/tc_act/.install
