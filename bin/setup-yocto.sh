#!/bin/sh

echo "[GLSDK]>"
echo "[GLSDK]> Testing for "yocto-layers""
if [ -d "yocto-layers" ]; then
	echo "[GLSDK]> yocto-layers is present. Proceed to next step"
else 
	echo "[GLSDK]> yocto-layers is not present. Cloning it."
	echo "[GLSDK]> git clone https://github.com/Risca/glsdk-oe-layersetup.git yocto-layers"
	git clone https://github.com/Risca/glsdk-oe-layersetup.git yocto-layers
fi

echo "[GLSDK]> Copying yocto build-scripts to yocto-layers"
cp bin/build-specific-recipe.sh yocto-layers
cp bin/clean-specific-recipe.sh yocto-layers
cp bin/build-core-sdk.sh yocto-layers

echo "[GLSDK]> cd yocto-layers"
cd yocto-layers

echo "[GLSDK]> ./oe-layertool-setup.sh -f configs/glsdk/glsdk-06.03.00.01-config.txt"
./oe-layertool-setup.sh -f configs/glsdk/glsdk-06.03.00.01-config.txt

echo "[GLSDK]>"
echo "[GLSDK]> Completed Yocto setup. You can now build using Yocto"
echo "[GLSDK]>"
