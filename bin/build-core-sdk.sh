#!/bin/sh

TOOLS_DOWNLOAD_LOCATION=$HOME

GCC_LINARO_TOOLCHAIN_PATH=$TOOLS_DOWNLOAD_LOCATION/gcc-linaro-5.3-2016.02-x86_64_arm-linux-gnueabihf/bin/
CCS_DOWNLOAD_LOCATION=$TOOLS_DOWNLOAD_LOCATION
CCS_VERSION=CCS6.1.3.00033_linux.tar.gz

if [ -d "$GCC_LINARO_TOOLCHAIN_PATH" ]; then
    echo "SUCCESS: GCC Linaro tool chain path has been set correctly"
else
    echo "ERROR: GCC Linaro tool chain does not exist at $GCC_LINARO_TOOLCHAIN_PATH. Please download or set the path correct."
    exit 1
fi


if [ -f "$CCS_DOWNLOAD_LOCATION/$CCS_VERSION" ]; then
    echo "SUCCESS: CCS path has been set correctly"
else
    echo "ERROR: CCS has not been downloaded, please download it from TI website and place it in this path: $CCS_DOWNLOAD_LOCATION/$CCS_VERSION"
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

echo "[PSDKLA]> ./oe-layertool-setup.sh -f configs/psdkla/processor-sdk-linux-automotive-03.01.00.03.txt"
./oe-layertool-setup.sh -f configs/psdkla/processor-sdk-linux-automotive-03.01.00.03.txt

cd $PSDKLA/yocto-layers

echo "[PSDKLA]> cd build"
cd ${PSDKLA}/yocto-layers/build

echo "[PSDKLA]> . conf/setenv"
. conf/setenv

echo "[PSDKLA]> cp conf/local.conf conf/local.conf.pristine"
cp conf/local.conf conf/local.conf.pristine

mkdir -p $dwn
sed -i -e "s#^DL_DIR =.*#DL_DIR = \"${dwn}\"#" conf/local.conf

cp $CCS_DOWNLOAD_LOCATION/$CCS_VERSION $dwn/.
touch $dwn/$CCS_VERSION.done

echo "[PSDKLA]> MACHINE=$1 bitbake tisdk-rootfs-image "
MACHINE=$1 bitbake tisdk-rootfs-image 

echo "[PSDKLA]>"
echo "[PSDKLA]> Completed Yocto build at `date`"
echo "[PSDKLA]>"
