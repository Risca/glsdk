#!/bin/sh

echo "[PSDKLA]>"
echo "[PSDKLA]> Current Directory is `pwd`"
echo "[PSDKLA]> PATH is $PATH"
echo "[PSDKLA]> Building on `hostname` running `uname -a`"
echo "[PSDKLA]> Starting Yocto build at `date`"
echo "[PSDKLA]>"

echo "[PSDKLA]> cd build"
cd build

echo "[PSDKLA]> . conf/setenv"
. conf/setenv

echo "[PSDKLA]> cp conf/local.conf conf/local.conf.pristine"
cp conf/local.conf conf/local.conf.pristine

echo "[PSDKLA]> MACHINE=$1 bitbake tisdk-rootfs-image "
MACHINE=$1 bitbake tisdk-rootfs-image 

echo "[PSDKLA]>"
echo "[PSDKLA]> Completed Yocto build at `date`"
echo "[PSDKLA]>"
