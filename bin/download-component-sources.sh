#!/bin/sh

#Component Sources versions:
FRAMEWORK_COMP_VERSION="3_24_02_15"
CODEC_ENGINE_VERSION="3_24_00_08"
#OSAL_VERSION="1_24_00_09"
XDAIS_VERSION="7_24_00_04"
BIOS_VERSION="6_35_03_47"
XDCTOOLS_VERSION="3_25_04_88"

FRAMEWORK_COMP_WGET_URL="http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/fc/$FRAMEWORK_COMP_VERSION/exports/framework_components_$FRAMEWORK_COMP_VERSION.tar.gz"
CODEC_ENGINE_WGET_URL="http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/ce/$CODEC_ENGINE_VERSION/exports/codec_engine_$CODEC_ENGINE_VERSION.tar.gz"
#OSAL_WGET_URL="http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/osal/$OSAL_VERSION/exports/osal_$OSAL_VERSION.tar.gz"
XDAIS_WGET_URL="http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/xdais/$XDAIS_VERSION/exports/xdais_$XDAIS_VERSION.tar.gz"
BIOS_WGET_URL="http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/bios/sysbios/$BIOS_VERSION/exports/bios_setuplinux_$BIOS_VERSION.bin"
XDCTOOLS_WGET_URL="http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/rtsc/$XDCTOOLS_VERSION/exports/xdctools_setuplinux_$XDCTOOLS_VERSION.bin"

if [ ! -d "component-sources" ]; then
	mkdir "component-sources"
fi
if [ ! -d "component-sources/framework_components_$FRAMEWORK_COMP_VERSION" ]; then
	wget -nc $FRAMEWORK_COMP_WGET_URL
	echo "Extracting framework components..."
	tar -zxf framework_components_$FRAMEWORK_COMP_VERSION.tar.gz -C component-sources/
	mv framework_components*.tar.gz component-sources/
fi
if [ ! -d "component-sources/codec_engine_$CODEC_ENGINE_VERSION" ]; then
	wget -nc $CODEC_ENGINE_WGET_URL
	echo "Extracting codec engine..."
	tar -zxf codec_engine_$CODEC_ENGINE_VERSION.tar.gz -C component-sources/
	mv codec_engine*.tar.gz component-sources/
fi
#if [ ! -d "component-sources/osal_$OSAL_VERSION" ]; then
#	wget -nc $OSAL_WGET_URL
#	echo "Extracting OSAL..."
#	tar -zxf osal_$OSAL_VERSION.tar.gz -C component-sources/
#	mv osal*.tar.gz component-sources/
#fi
if [ ! -d "component-sources/xdais_$XDAIS_VERSION" ]; then
	wget -nc $XDAIS_WGET_URL
	echo "Extracting XDAIS..."
	tar -zxf xdais_$XDAIS_VERSION.tar.gz -C component-sources/
	mv xdais*.tar.gz component-sources/
fi
if [ ! -d "component-sources/bios_$BIOS_VERSION" ]; then
	wget -nc $BIOS_WGET_URL
	echo "Installing BIOS..."
	chmod +x bios_setuplinux_$BIOS_VERSION.bin
	./bios_setuplinux_$BIOS_VERSION.bin --prefix ./component-sources/ --mode unattended
	mv bios_setuplinux*.bin component-sources/
fi
if [ ! -d "component-sources/xdctools_$XDCTOOLS_VERSION" ]; then
	wget -nc $XDCTOOLS_WGET_URL
	echo "Installing XDC tools..."
	chmod +x xdctools_setuplinux_$XDCTOOLS_VERSION.bin
	./xdctools_setuplinux_$XDCTOOLS_VERSION.bin --prefix ./component-sources/ --mode unattended
	mv xdctools_setuplinux*.bin component-sources/

        # Workaround for the issue with 32-bit installer of XDC tools version 3.25.04.88
        MACHINE_TYPE=`uname -m`
        if [ ${MACHINE_TYPE} == 'x86_64' ]; then
              echo "Detected 64-bit machine, nothing to be done"
        else
              echo "Detected 32-bit machine"
              wget http://processors.wiki.ti.com/images/8/8c/Gmake.gz
              gunzip Gmake.gz
              chmod +x Gmake
              mv Gmake component-sources/xdctools_3_25_04_88/gmake
              echo "Replaced with the correct version of gmake"
        fi
fi
