cmd_/home/build/fdpic/install/sysroot/usr/include/rdma/.install := /bin/sh /home/build/fdpic/scratch/kernel/scripts/headers_install.sh /home/build/fdpic/install/sysroot/usr/include/rdma /home/build/fdpic/scratch/kernel/include/uapi/rdma ib_user_cm.h ib_user_mad.h ib_user_sa.h ib_user_verbs.h rdma_netlink.h rdma_user_cm.h; /bin/sh /home/build/fdpic/scratch/kernel/scripts/headers_install.sh /home/build/fdpic/install/sysroot/usr/include/rdma /home/build/fdpic/scratch/kernel/include/rdma ; /bin/sh /home/build/fdpic/scratch/kernel/scripts/headers_install.sh /home/build/fdpic/install/sysroot/usr/include/rdma /home/build/fdpic/build/kernelheader/include/generated/uapi/rdma ; for F in ; do echo "\#include <asm-generic/$$F>" > /home/build/fdpic/install/sysroot/usr/include/rdma/$$F; done; touch /home/build/fdpic/install/sysroot/usr/include/rdma/.install
