#! /bin/bash

#echo off
#clear

# Generate sb file that flashloader can use
echo Generating u-boot sb file....
../flashloader/elftosb/linux/i386/elftosb -f kinetis -V -c bd/program_semcNand.bd -o u-boot-dtb-signed.sb $1
echo ...Done

#Download flashloader binary using Serial Download Protocol (Refer to Kinetis SDPHost User's Guide)
echo Downloading flashloader binary...
../flashloader/sdphost/linux/i386/sdphost -u 0x1FC9,0x0130 -- write-file 0x20000000 ../flashloader/bin/ivt_flashloader.bin
../flashloader/sdphost/linux/i386/sdphost -u 0x1FC9,0x0130 -- jump-address 0x20000400
echo ...Done
#Add delay to give time for the Kinetis Bootloader to Initialize
sleep 2s

#:: Ask if user want to program hash to OCOTP
#set /p bProgHashFuse="Program Hash to OCOTP (Y/N): "
#if %bProgHashFuse% == Y (
#  echo Programming Hash to fuse...
#  if %commToUse% == 1 (
#    ..\flashloader\blhost\win\blhost.exe -p %BoardComPort% -- receive-sb-file binary\program_hash_fuse.sb
#  ) else (
#    ..\flashloader\blhost\win\blhost.exe -u 0x15A2,0x73 -- receive-sb-file binary\program_hash_fuse.sb
#  )
#  echo ...Done
#  echo.
#) else (
#  echo Skipped Hash OCOTP programming
#  echo.
#)

#Download IMX bootable image using Kinetis Bootloader Host (Refer to Kinetis blhost User's Guide)
echo Downloading u-boot bootable imx image...
../flashloader/blhost/linux/i386/blhost -u 0x15A2,0x73 -- receive-sb-file u-boot-dtb-signed.sb
echo ...Done

exit 0
