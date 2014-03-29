#!/bin/sh

cwd=`dirname $0`
. $cwd/common.sh

ccdefault="${HOME}"
ccbinary="gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux"

echo
echo "--------------------------------------------------------------------------------"
echo "To use the SDK, you need to have Linaro cross compiler toolchain installed"
echo "Do you want to install it now Y/n  "
read -p "[ y ]" choice
if [ ! -n "$choice" ]; then
	choice="y"
fi
if [ $choice = "y" -o $choice = "Y" ]; then
	echo
else
	exit 0
fi

echo "In which directory do you want to fetch the cross compiler on the host?(if this directory does not exist it will be created)"
read -p "[ $ccdefault ] " dst

if [ ! -n "$dst" ]; then
    dst=$ccdefault
fi

mkdir -p $dst

echo "--------------------------------------------------------------------------------"

fetch_cc() {
    ccBinaryURL="https://launchpad.net/linaro-toolchain-binaries/trunk/2013.03/+download/gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux.tar.bz2"
    check_status
    wget --no-check-certificate $ccBinaryURL
    check_status
    tar -jxf "$ccbinary.tar.bz2" -C $1
    check_status
    echo
    echo "Successfully extracted the cross compiler to $1"

    uname -m | grep 64 2>&1 >/dev/null
    if [ $? -eq "0" ]; then
        echo "You seem to have 64 bit ubuntu, installing ia32-libs..."
        sudo apt-get install ia32-libs -y
    fi

    echo "Updating cross compiler used by Makefile"
    sed -i "s=^TOOLCHAIN_INSTALL_DIR.*$=TOOLCHAIN_INSTALL_DIR\=$1=g" $cwd/../Rules.make
    sed -i "s=^CROSS_COMPILE_PREFIX.*$=CROSS_COMPILE_PREFIX\=$1/$ccbinary/bin/arm-linux-gnueabihf-=g" $cwd/../Rules.make
}

    fetch_cc $dst

echo "--------------------------------------------------------------------------------"
