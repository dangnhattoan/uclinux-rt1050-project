# uclinux-rt1050-project boot log
U-Boot 2017.09-rc1 (Nov 27 2020 - 22:14:32 +0800)

CPU: i.MX RT105x at 600MHz
Model: NXP i.RT1050 EVK
DRAM:  32 MiB
MMC:   FSL_SDHC: 0
reading uboot.env

** Unable to read "uboot.env" from mmc0:1 **
Using default environment

Video: 480x272x24
In:    serial@40184000
Out:   serial@40184000
Err:   serial@40184000
Net:   eth0: ethernet@402D8000
reading splash-rt1050-series_24.bmp
** Unable to read file splash-rt1050-series_24.bmp **
reading mxrt105x-evk.ini
** Unable to read file mxrt105x-evk.ini **
Hit any key to stop autoboot:  0 
reading rootfs.uImage
1293570 bytes read in 318 ms (3.9 MiB/s)
## Booting kernel from Legacy Image at 80007fc0 ...
   Image Name:   Linux-4.5.0-ga880c5b0-dirty
   Image Type:   ARM Linux Multi-File Image (uncompressed)
   Data Size:    1293506 Bytes = 1.2 MiB
   Load Address: 80008000
   Entry Point:  80008001
   Contents:
      Image 0: 1283840 Bytes = 1.2 MiB
      Image 1: 9654 Bytes = 9.4 KiB
   Verifying Checksum ... OK
## Flattened Device Tree from multi component Image at 80007FC0
   Booting using the fdt at 0x8014170c
   Loading Multi-File Image ... OK
   Loading Device Tree to 81e77000, end 81e7c5b5 ... OK

Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 4.5.0-ga880c5b0-dirty (toan@toan-System-Product-Name) (gcc version 4.7.4 20130508 (prerelease) (20170818-165657- build on build.emcraft by build) ) #34 Sat Nov 28 12:41:21 +08 2020
CPU: ARMv7-M [411fc271] revision 1 (ARMv7M), cr=00000000
CPU: WBA data cache, WBA instruction cache
Machine model: NXP IMXRT1050 board
debug: ignoring loglevel setting.
On node 0 totalpages: 8192
free_area_init_node: node 0, pgdat 80141124, node_mem_map 81ec0000
  Normal zone: 64 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 8192 pages, LIFO batch:0
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0 
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 8128
Kernel command line: console=ttyLP0,115200 consoleblank=0 ignore_loglevel ip=172.17.44.111:172.17.0.1::255.255.0.0::eth0:off
PID hash table entries: 128 (order: -3, 512 bytes)
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 30072K/32768K available (754K kernel code, 37K rwdata, 140K rodata, 320K init, 57K bss, 2696K reserved, 0K cma-reserved)
Virtual kernel memory layout:
    vector  : 0x00000000 - 0x00001000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0x00000000 - 0xffffffff   (4095 MB)
    lowmem  : 0x80000000 - 0x82000000   (  32 MB)
      .text : 0x80008000 - 0x800e7ca0   ( 896 kB)
      .init : 0x800e8000 - 0x80138000   ( 320 kB)
      .data : 0x80138000 - 0x80141700   (  38 kB)
       .bss : 0x80141700 - 0x8014fba8   (  58 kB)
NR_IRQS:16 nr_irqs:16 16
sched_clock: 32 bits at 75MHz, resolution 13ns, wraps every 28633115129ns
clocksource: vf-pit: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 25483472618 ns
Calibrating delay loop... 1196.85 BogoMIPS (lpj=5984256)
pid_max: default: 4096 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
pinctrl core: initialized pinctrl subsystem
imxrt105x-pinctrl 401f8000.iomuxc: initialized IMX pinctrl driver
clocksource: Switched to clocksource vf-pit
futex hash table entries: 16 (order: -5, 192 bytes)
fuse init (API version 7.24)
40184000.serial: ttyLP0 at MMIO 0x40184000 (irq = 44, base_baud = 375000) is a FSL_LPUART
console [ttyLP0] enabled
fsl-lpuart 40184000.serial: DMA tx channel request failed, operating without tx DMA
fsl-lpuart 40184000.serial: DMA rx channel request failed, operating without rx DMA
Serial: VF610 driver
Freeing unused kernel memory: 320K (800e8000 - 80138000)
init started: BusyBox v1.24.2 (2020-11-28 12:41:08 +08)


