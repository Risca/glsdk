#!/bin/sh

echo "[GLSDK]>"
echo "[GLSDK]> Testing for "yocto-layers""
if [ -d "yocto-layers" ]; then
	echo "[GLSDK]> yocto-layers is present. Proceed to next step"
else 
	echo "[GLSDK]> ERROR: yocto-layers is not present"
	echo "[GLSDK]>        Please run setup.sh and answer 'yes' to fetch-sources prompt"
	echo "[GLSDK]>        Refer to the GLSDK Software Developers Guide for details"
	echo "[GLSDK]> Exiting..."
	exit
fi

echo "[GLSDK]> Copying yocto build-scripts to yocto-layers"
cp bin/build-specific-recipe.sh yocto-layers
cp bin/clean-specific-recipe.sh yocto-layers
cp bin/build-core-sdk.sh yocto-layers

echo "[GLSDK]> cd yocto-layers"
cd yocto-layers

echo ["GLSDK]>  cp ../config/*.* configs/glsdk/. "
cp ../config/*.* configs/glsdk/.

echo "[GLSDK]>"
echo "[GLSDK]> Completed Yocto setup. You can now build using Yocto"
echo "[GLSDK]>"
