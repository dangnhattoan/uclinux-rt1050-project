#
# This file contains common make rules for all projects.
#

MAKE		:= make -j9

KERNEL_CONFIG	:= kernel$(if $(MCU),.$(MCU))
KERNEL_LD	:= lds$(if $(MCU),.$(MCU))
KERNEL_DTS	:= dts$(if $(MCU),.$(MCU))$(if $(BRD),.$(BRD))
KERNEL_BOOT	:= $(INSTALL_ROOT)/linux/arch/arm/boot
RAMFS_CONFIG	:= initramfs
BUSYBOX_CONFIG	:= busybox
KERNEL_IMAGE	:= uImage
KERNEL_DTB	:= dtb

# Path to the kernel modules directory in context of which
# these loadable modules are built
KERNELDIR	:=  $(INSTALL_ROOT)/linux

CFLAGS		:= \
	"-Os -mcpu=cortex-m3 -mthumb -I$(INSTALL_ROOT)/A2F/root/usr/include"
LDFLAGS		:= \
	"-mcpu=cortex-m3 -mthumb -L$(INSTALL_ROOT)/A2F/root/usr/lib"

XIP_CFLAGS	:= "-Os -static -fPIC"
XIP_LDFLAGS	:= ""

ifeq ($(CROSS_COMPILE),arm-v7-linux-uclibceabi-)
KERNEL_CFLAGS	:= -mno-fdpic
endif

.PHONY	: all busybox linux kmenuconfig bmenuconfig clean kclean bclean aclean $(CUSTOM_APPS) $(XIP_CUSTOM_APPS) clone

all		: _do_modules linux

# For those projects that have support for loadable kernel modules
# enabled in the kernel configuration, we need to build and install
# modules in the kernel tree, as a first step in building the project.
# This is needed to allow us building an external module (or several
# such modules) as an external module from a project subdirectory
# and then to include the resultant module object in the project
# initramfs filesystem.

MODULES_ON	:= $(shell grep CONFIG_MODULES=y $(SAMPLE).$(KERNEL_CONFIG))
INSTALL_MOD_PATH:= $(INSTALL_ROOT)/linux

ifeq ($(MODULES_ON),)
_do_modules 	:
else
_do_modules	: _prepare_modules
endif

_prepare_modules:
	cp -f $(INSTALL_ROOT)/linux/initramfs-list-min.stub \
		$(INSTALL_ROOT)/linux/initramfs-list-min
	rm -f $(INSTALL_ROOT)/linux/usr/initramfs_data.cpio \
		$(INSTALL_ROOT)/linux/usr/initramfs_data.cpio.gz
	cp -f $(SAMPLE).$(KERNEL_CONFIG) $(INSTALL_ROOT)/linux/.config
	cp -f $(INSTALL_ROOT)/linux/arch/arm/kernel/vmlinux.lds.S.good \
		$(INSTALL_ROOT)/linux/arch/arm/kernel/vmlinux.lds.S
	([ -e $(SAMPLE).$(KERNEL_LD) ] && \
		cp -f $(SAMPLE).$(KERNEL_LD) \
		$(INSTALL_ROOT)/linux/arch/arm/kernel/vmlinux.lds.S) || \
	true;
	$(MAKE) -C $(INSTALL_ROOT)/linux vmlinux
	$(MAKE) -C $(INSTALL_ROOT)/linux modules

linux		: $(SAMPLE).$(KERNEL_IMAGE)

$(CUSTOM_APPS)	:
	 CROSS_COMPILE_APPS=$(CROSS_COMPILE) CFLAGS=${CFLAGS} LDFLAGS=${LDFLAGS} make -C $@ all

$(XIP_CUSTOM_APPS)	:
	 CROSS_COMPILE_APPS=arm-v7-linux-uclibceabi- CFLAGS=${XIP_CFLAGS} LDFLAGS=${XIP_LDFLAGS} make -C $@ all

clean		: kclean bclean aclean
	rm -rf $(SAMPLE).$(KERNEL_IMAGE) $(SAMPLE).$(KERNEL_DTB) ./fs *.img

kclean		:
	$(MAKE) -C $(INSTALL_ROOT)/linux clean

bclean		:
	$(MAKE) -C $(INSTALL_ROOT)/A2F/busybox clean

aclean		:
	@[ "x$(CUSTOM_APPS)" = "x" ] || \
		for i in $(CUSTOM_APPS); do \
			$(MAKE) -C $$i clean; \
		done
	@[ "x$(XIP_CUSTOM_APPS)" = "x" ] || \
		for i in $(XIP_CUSTOM_APPS); do \
			$(MAKE) -C $$i clean; \
		done

kmenuconfig	:
	cp -f $(SAMPLE).$(KERNEL_CONFIG) \
			$(INSTALL_ROOT)/linux/.config
	$(MAKE) -C $(INSTALL_ROOT)/linux menuconfig
	cp -f $(INSTALL_ROOT)/linux/.config \
			./$(SAMPLE).$(KERNEL_CONFIG)

bmenuconfig	:
	cp -f $(SAMPLE).busybox $(INSTALL_ROOT)/A2F/busybox/.config
	$(MAKE) -C $(INSTALL_ROOT)/A2F/busybox menuconfig
	cp -f $(INSTALL_ROOT)/A2F/busybox/.config $(SAMPLE).busybox

busybox		: $(SAMPLE).busybox
	@[ ! -s $(SAMPLE).busybox ] || \
	(cp -f $(SAMPLE).busybox $(INSTALL_ROOT)/A2F/busybox/.config; \
	 CROSS_COMPILE= $(MAKE) -C $(INSTALL_ROOT)/A2F/busybox)

dtb		: $(SAMPLE).$(KERNEL_DTS)
	cp -f $(SAMPLE).$(KERNEL_DTS) $(KERNEL_BOOT)/dts/$(MCU)-SOM.dts
	cp -f $(SAMPLE).$(KERNEL_CONFIG) $(INSTALL_ROOT)/linux/.config
	$(MAKE) -C $(INSTALL_ROOT)/linux $(MCU)-SOM.dtb

%.$(KERNEL_IMAGE) : \
	%.$(KERNEL_CONFIG) %.$(RAMFS_CONFIG) %.$(KERNEL_DTS) \
	$(CUSTOM_APPS) $(XIP_CUSTOM_APPS) busybox dtb
	SAMPLE=$(SAMPLE) ../rfs-builder.py generate-rfs-image $(SAMPLE).$(RAMFS_CONFIG) \
		1 > $(SAMPLE).$(RAMFS_CONFIG).processed
	rm -f $(INSTALL_ROOT)/linux/initramfs-list-min
	ln -s $(INSTALL_ROOT)/projects/$(SAMPLE)/$(SAMPLE).$(RAMFS_CONFIG).processed \
		$(INSTALL_ROOT)/linux/initramfs-list-min

	rm -f $(INSTALL_ROOT)/linux/usr/initramfs_data.cpio \
		$(INSTALL_ROOT)/linux/usr/initramfs_data.cpio.gz
	cp -f $(INSTALL_ROOT)/linux/arch/arm/kernel/vmlinux.lds.S.good \
		$(INSTALL_ROOT)/linux/arch/arm/kernel/vmlinux.lds.S
	([ -e $(SAMPLE).$(KERNEL_LD) ] && \
		cp -f $(SAMPLE).$(KERNEL_LD) \
		$(INSTALL_ROOT)/linux/arch/arm/kernel/vmlinux.lds.S) || \
	true;
	UIMAGE_TYPE=multi \
	UIMAGE_IN=$(KERNEL_BOOT)/Image:$(KERNEL_BOOT)/dts/$(MCU)-SOM.dtb \
	KCFLAGS=$(KERNEL_CFLAGS) $(MAKE) -C $(INSTALL_ROOT)/linux \
		$(KERNEL_IMAGE) SAMPLE=${SAMPLE}
	cp -f $(KERNEL_BOOT)/$(KERNEL_IMAGE) $@

#UBIFS         
	rm -rf ./fs
	mkdir -p ./fs/firmware
	cp -f $@ ./fs/firmware/project_tres.uImage
	mkfs.ubifs -v -m 2048 -e 129024 -c 900 -r ./fs/ ./ubifs.img
	mkimage -T script -C none -n "Zimplistic Script File" -A arm -d ../zpl.script ./zpl_script.img

clone		:
	@[ ! -z ${new} ] || \
	(echo "Please specify the new project name (\"make clone new=...\")";\
		 exit 1);
	@[ ! -d $(INSTALL_ROOT)/projects/${new} ] || \
		(echo \
		"Project $(INSTALL_ROOT)/projects/${new} already exists"; \
		 exit 1);
	@mkdir -p $(INSTALL_ROOT)/projects/${new}
	@cp -a .  $(INSTALL_ROOT)/projects/${new}
	@for i in \
		${KERNEL_CONFIG} \
		${KERNEL_DTS} \
		${KERNEL_LD} \
		${RAMFS_CONFIG} \
		${BUSYBOX_CONFIG}; do \
		[ -e $(INSTALL_ROOT)/projects/${new}/${SAMPLE}.$$i ] && \
		mv $(INSTALL_ROOT)/projects/${new}/${SAMPLE}.$$i \
			$(INSTALL_ROOT)/projects/${new}/${new}.$$i; \
	done
	@rm -f $(INSTALL_ROOT)/projects/${new}/${SAMPLE}.*
	@sed 's/SAMPLE.*\:=.*/SAMPLE\t\t:= ${new}/' Makefile > \
		$(INSTALL_ROOT)/projects/${new}/Makefile
	@echo "New project created in $(INSTALL_ROOT)/projects/${new}"
