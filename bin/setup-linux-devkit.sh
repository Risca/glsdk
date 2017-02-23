#!/bin/sh

echo "[PSDKLA]> cd filesystem"
cd filesystem

echo "[PSDKLA]>  mkdir devkit-extract; cd devkit-extract"
mkdir devkit-extract
cd devkit-extract

echo "[PSDKLA]>  tar xf ../arago-core-tisdk-image-dra7xx-evm.tar.xz "
tar xf ../arago-core-tisdk-image-dra7xx-evm.tar.xz

echo "[PSDKLA]>  sh linux-devkit.sh -d ../../linux-devkit -y "
sh linux-devkit.sh -d ../../linux-devkit -y

echo "[PSDKLA]> cd .."
cd ..

echo "[PSDKLA]> rm -rf devkit-extract"
rm -rf devkit-extract

echo "[PSDKLA]> cd .."
cd ..

echo "[PSDKLA]>"
echo "[PSDKLA]> Completed linux devkit setup"
echo "[PSDKLA]>"
