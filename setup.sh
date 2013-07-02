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

echo "Do you want to fetch all the sources y/N "
read -p "[ n ]" choice
if [  ! -n "$choice" ]; then
    choice="n"
fi
if [ $choice = "y" -o $choice = "Y" ]; then
    $cwd/bin/fetch-sources.sh

    #To be removed in the next release
    cd yocto-layers
    git am ../patches/0001-configs-glsdk-6.01.00-Update-commitids-for-staged-tr.patch
fi

echo
echo "TISDK setup completed!"
echo "Please continue reading the Software Developer's Guide for more information on"
echo "how to develop software on the EVM"
