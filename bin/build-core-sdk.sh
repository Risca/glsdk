#!/bin/sh

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

echo "[PSDKLA]> ./oe-layertool-setup.sh -f configs/psdkla/processor-sdk-linux-automotive-03.00.00.03.txt"
./oe-layertool-setup.sh -f configs/psdkla/processor-sdk-linux-automotive-03.00.00.03.txt

cd $PSDKLA/yocto-layers

echo "[PSDKLA]> cd build"
cd ${PSDKLA}/yocto-layers/build

echo "[PSDKLA]> . conf/setenv"
. conf/setenv

echo "[PSDKLA]> cp conf/local.conf conf/local.conf.pristine"
cp conf/local.conf conf/local.conf.pristine

mkdir -p $dwn
sed -i -e "s#^DL_DIR =.*#DL_DIR = \"${dwn}\"#" conf/local.conf

echo "[PSDKLA]> MACHINE=$1 bitbake arago-glsdk-multimedia-image"
MACHINE=$1 bitbake arago-glsdk-multimedia-image

echo "[PSDKLA]>"
echo "[PSDKLA]> Completed Yocto build at `date`"
echo "[PSDKLA]>"
