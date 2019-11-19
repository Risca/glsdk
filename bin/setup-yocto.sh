#!/bin/sh

TOOLS_DOWNLOAD_LOCATION=/sdk/tools

GCC_ARM_TOOLCHAIN_PATH=$TOOLS_DOWNLOAD_LOCATION/gcc-arm-8.3-2019.03-x86_64-arm-linux-gnueabihf/bin/
PSDKLA=$(pwd)

echo "[PSDKLA]>"
echo "[PSDKLA]> Testing for "yocto-layers""
if [ -d "yocto-layers" ]; then
	echo "[PSDKLA]> yocto-layers is present. Proceed to next step"
else 
	echo "[PSDKLA]> ERROR: yocto-layers is not present"
	echo "[PSDKLA]>        Please run setup.sh and answer 'yes' to fetch-sources prompt"
	echo "[PSDKLA]>        Refer to the Processor SDK Linux Automotive Software Developers Guide for details"
	echo "[PSDKLA]> Exiting..."
	exit
fi

echo "[PSDKLA]> Copying yocto build-scripts to yocto-layers"
cp bin/build-specific-recipe.sh yocto-layers
cp bin/clean-specific-recipe.sh yocto-layers
cp bin/build-core-sdk.sh yocto-layers


echo "[PSDKLA]> cd yocto-layers"
cd yocto-layers

echo ["PSDKLA]>  mkdir configs/psdkla/. "
mkdir configs/psdkla/

echo ["PSDKLA]>  cp ../config/*.* configs/psdkla/. "
cp ../config/*.* configs/psdkla/.

if [ -d "$GCC_ARM_TOOLCHAIN_PATH" ]; then
    echo "SUCCESS: GCC Arm tool chain path has been set correctly"
else
    echo "ERROR: GCC Arm tool chain does not exist at $GCC_ARM_TOOLCHAIN_PATH. Please download or set the path correct."
    exit 1
fi

dwndefault="${PSDKLA}/yocto-layers/downloads"

echo "In which directory do you want to place the downloads for the Yocto build ?(if this directory does not exist it will be created)"
echo "Ensure that complete path is provided."
read -p "[ $dwndefault ] " dwn

#Check if input is not NULL
if [ ! -n "$dwn" ]; then
    dwn=$dwndefault
fi

echo "[PSDKLA]>"
echo "[PSDKLA]> Current Directory is `pwd`"
echo "[PSDKLA]> PATH is $PATH"
echo "[PSDKLA]> Building on `hostname` running `uname -a`"
echo "[PSDKLA]> Starting Yocto build at `date`"
echo "[PSDKLA]>"

echo "[PSDKLA]> ./oe-layertool-setup.sh -f configs/psdkla/psdkla-06_00_00_00_dra7xx.txt"
./oe-layertool-setup.sh -f configs/psdkla/psdkla-06_00_00_00_dra7xx.txt

echo "[PSDKLA]> cd build"
cd ${PSDKLA}/yocto-layers/build

echo "[PSDKLA]> . conf/setenv"
. conf/setenv

echo "[PSDKLA]> cp conf/local.conf conf/local.conf.pristine"
cp conf/local.conf conf/local.conf.pristine

mkdir -p $dwn
sed -i -e "s#^DL_DIR =.*#DL_DIR = \"${dwn}\"#" conf/local.conf

echo "[PSDKLA]>"
echo "[PSDKLA]> Completed Yocto setup. You can now build using Yocto"
echo "[PSDKLA]>"
