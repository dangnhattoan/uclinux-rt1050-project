SAMPLE		:= rootfs
CUSTOM_APPS	:= env mpu

all: fw

fw:
	cp -f firmware/rt28xx/rt2870.bin ${INSTALL_ROOT}/linux/firmware

include ../Rules.make
