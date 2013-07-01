#!/bin/bash

cwd=`dirname $0`
. $cwd/common.sh

echo
echo "--------------------------------------------------------------------------------"
echo "This step will set up the u-boot variables for booting the EVM."
platform=`grep PLATFORM= $cwd/../Rules.make | cut -d= -f2`
prompt="DRA752 EVM #"

echo "Select Linux kernel location:"
echo " 1: SD card"
echo
read -p "[ 1 ] " kernel

if [ ! -n "$kernel" ]; then
    kernel="1"
fi

echo
echo "Select root file system location:"
echo " 1: SD card"
echo
read -p "[ 1 ] " fs

if [ ! -n "$fs" ]; then
    fs="1"
fi

if [ "$kernel" -eq "1" ]; then
    if [ "$fs" -eq "1" ]; then
        baseargs="elevator=noop console=ttyO0,115200n8  earlyprintk"
        fssdargs="root=/dev/mmcblk0p2 rw rootwait fixrtc"
        loaddtb="fatload mmc 0:1 0x825f0000 dra7-evm.dtb"
        loaduimage="fatload mmc 0:1 0x80300000 uImage"
        bootargs="setenv bootargs '$baseargs $fssdargs'"
        bootcmd=" bootm 0x80300000 - 0x825f0000"
        fdtargs="setenv fdt_high 0x84000000"
        cfg="uimage-sd_fs-sd"
    fi
fi

echo
echo "Resulting u-boot variable settings:"
echo
echo "setenv baudrate 115200"
echo $loaddtb
echo $loaduimage
echo $bootargs
echo $fdtargs
echo $bootcmd
echo "--------------------------------------------------------------------------------"
