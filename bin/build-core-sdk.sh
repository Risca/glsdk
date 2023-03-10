#!/bin/sh

dwndefault="${GLSDK}/yocto-layers/downloads"

echo "[GLSDK]>"
echo "[GLSDK]> Current Directory is `pwd`"
echo "[GLSDK]> PATH is $PATH"
echo "[GLSDK]> Building on `hostname` running `uname -a`"
echo "[GLSDK]> Starting Yocto build at `date`"
echo "[GLSDK]>"

echo "[GLSDK]> ./oe-layertool-setup.sh -f configs/glsdk/glsdk-06.03.00.01-config.txt"
./oe-layertool-setup.sh -f configs/glsdk/glsdk-06.03.00.01-config.txt

echo "[GLSDK]> cd build"
cd build

echo "[GLSDK]> . conf/setenv"
. conf/setenv

echo "[GLSDK]> cp conf/local.conf conf/local.conf.pristine"
cp conf/local.conf conf/local.conf.pristine

echo "[GLSDK]> echo ARAGO_BRAND = \"glsdk\" >> conf/local.conf"
echo "ARAGO_BRAND = \"glsdk\"" >> conf/local.conf

echo "In which directory do you want to place the downloads for the Yocto build ?(if this directory does not exist it will be created)"
echo "Ensure that complete path is provided."
read -p "[ $dwndefault ] " dwn

if [ ! -n "$dwn" ]; then
    dwn=$dwndefault
fi

mkdir -p $dwn
sed -i -e "s#^DL_DIR =.*#DL_DIR = \"${dwn}\"#" conf/local.conf

echo "[GLSDK]> MACHINE=$1 bitbake arago-glsdk-multimedia-image"
MACHINE=$1 bitbake arago-glsdk-multimedia-image

echo "[GLSDK]>"
echo "[GLSDK]> Completed Yocto build at `date`"
echo "[GLSDK]>"
