#!/bin/sh

echo
echo "--------------------------------------------------------------------------------"
echo "TISDK setup script"
echo
echo "This script will set up your development host for sdk development."
echo "Parts of this script require administrator priviliges (sudo access)."
echo "--------------------------------------------------------------------------------"

cwd=`dirname $0`
. $cwd/bin/common.sh

$cwd/bin/setup-host-check.sh
check_status

$cwd/bin/setup-package-install.sh
check_status

$cwd/bin/setup-targetfs-nfs.sh
check_status

sudo $cwd/bin/setup-minicom.sh
check_status

$cwd/bin/setup-uboot-env.sh
check_status

$cwd/bin/setup-cross-compile.sh
check_status

$cwd/bin/setup-repo.sh
check_status

echo "This step will download ducati build tools"

echo "The following components will be downloaded from the specified locations:"
echo " "
echo "Framework Components: "
echo "          http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/fc"
echo "Codec Engine:"
echo "          http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/ce"
echo "XDAIS:"
echo "          http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/xdais"
echo "SYSBIOS:"
echo "          http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/bios/sysbios"
echo "XDCTools:"
echo "          http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/rtsc/"

echo "You must agree and abide to respective license terms in order to continue."
echo "Please refer to individual manifest files for license information."

echo "Do you want to download all the ducati build tools? y/N"

read -p "[ n ]" choice
if [  ! -n "$choice" ]; then
    choice="n"
fi
if [ $choice = "y" -o $choice = "Y" ]; then
    $cwd/bin/download-component-sources.sh
fi


echo "Do you want to fetch all the sources y/N "
read -p "[ n ]" choice
if [  ! -n "$choice" ]; then
    choice="n"
fi
if [ $choice = "y" -o $choice = "Y" ]; then
    $cwd/bin/fetch-sources.sh
fi


echo "Do you want to extract linux-devkit y/N "
read -p "[ n ]" choice
if [  ! -n "$choice" ]; then
    choice="n"
fi
if [ $choice = "y" -o $choice = "Y" ]; then
    chmod +x $cwd/bin/setup-linux-devkit.sh
    $cwd/bin/setup-linux-devkit.sh
fi

echo
echo "Process SDK Linux Automotive setup completed!"
echo "Please continue reading the Software Developer's Guide for more information on"
echo "how to develop software on the EVM"
