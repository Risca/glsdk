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
echo "This is needed only if you need to rebuild ipumm firmware"
echo "You can also download them later when needed"
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

	cd yocto-layers
	git am ../patches/0001-configs-Lock-down-the-GLSDK-release-6.02.01.02.patch
fi

echo
echo "GLSDK setup completed!"
echo "Please continue reading the Software Developer's Guide for more information on"
echo "how to develop software on the EVM"
