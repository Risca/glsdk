#!/bin/sh

echo "[GLSDK]>"
echo "[GLSDK]> Current Directory is `pwd`"
echo "[GLSDK]> PATH is $PATH"
echo "[GLSDK]> Building on `hostname` running `uname -a`"
echo "[GLSDK]> Starting Yocto build at `date`"
echo "[GLSDK]>"

echo "[GLSDK]> cd build"
cd build

echo "[GLSDK]> . conf/setenv"
. conf/setenv

export MACHINE=$1
shift
echo "[GLSDK]> MACHINE=$MACHINE bitbake $@ -c cleanall"
bitbake $@ -c cleanall

echo "[GLSDK]>"
echo "[GLSDK]> Completed Yocto build at `date`"
echo "[GLSDK]>"
