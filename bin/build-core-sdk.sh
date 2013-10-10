#!/bin/sh

echo "[GLSDK]>"
echo "[GLSDK]> Current Directory is `pwd`"
echo "[GLSDK]> PATH is $PATH"
echo "[GLSDK]> Building on `hostname` running `uname -a`"
echo "[GLSDK]> Starting Yocto build at `date`"
echo "[GLSDK]>"

echo "[GLSDK]> ./oe-layertool-setup.sh -f configs/glsdk-06.02.01.01-config.txt"
./oe-layertool-setup.sh -f configs/glsdk-06.02.01.01-config.txt

echo "[GLSDK]> cd build"
cd build

echo "[GLSDK]> . conf/setenv"
. conf/setenv

echo "[GLSDK]> cp conf/local.conf conf/local.conf.pristine"
cp conf/local.conf conf/local.conf.pristine

echo "[GLSDK]> echo ARAGO_BRAND = \"glsdk\" >> conf/local.conf"
echo "ARAGO_BRAND = \"glsdk\"" >> conf/local.conf

echo "[GLSDK]> MACHINE=$1 bitbake arago-glsdk-multimedia-image"
MACHINE=$1 bitbake arago-glsdk-multimedia-image

echo "[GLSDK]>"
echo "[GLSDK]> Completed Yocto build at `date`"
echo "[GLSDK]>"
