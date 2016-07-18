#!/bin/sh

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

echo ["PSDKLA]>  cp ../config/*.* configs/glsdk/. "
cp ../config/*.* configs/glsdk/.

echo "[PSDKLA]>"
echo "[PSDKLA]> Completed Yocto setup. You can now build using Yocto"
echo "[PSDKLA]>"
