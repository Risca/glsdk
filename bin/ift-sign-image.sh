#!/bin/bash

# certificate signature information
CERT_KERNEL_MAGIC=0x534c4E4B
CERT_U_BOOT_MAGIC=0x53544255
CERT_RAMDISK_MAGIC=0x534B4452
CERT_DTB_MAGIC=0x53425444
CERT_RIGHTS_OTHER=0x20
CERT_INFO="CERT_OTHER"
CERT_SIGN=$CERT_RIGHTS_OTHER

#-----------------------------------------------------------------------------------
# function to display the syntax of command
#-----------------------------------------------------------------------------------
function fn_display_usage {
	echo "!Error: $1"
	echo ""
	echo "!make sure {MSHIELD_DK_DIR} environment vairable point to M-Shield Image Formatting Tool"
	echo "This script is used to sign the MLO, u-boot, kernel, ramdisk & dtb binaries"
	echo ""
	echo "Usage: ift-sign-image.sh -<image-type> <file-name>"
	echo "	<image-type> :  -kernel for kernel image type"
	echo "			-ramdisk for ramdisk image type"
	echo "			-dtb for dtb file" 
	echo "			-mlo {-dra7xx or -omap5} MLO"
	echo "sign the image using m-shield-dk/ift tool located at env variable {MSHIELD_DK_DIR}"
	echo ""
	echo "Signing MLO for dra7xx/omap5"
	echo "	# ift-sign-image.sh -mlo -dra7xx"
	echo "	# ift-sign-image.sh -mlo -omap5"
	echo "		- The spl/u-boot-spl.bin signed using the generate_MLO script of m-shield-dk"
	echo "		  and outpile file is MLO is created"
	echo "		- output file: MLO"
	echo "Signing kernel zImage"
	echo "	# ift-sign-image.sh -kernel zImage"
	echo "		- This will create sign the zImage with certificate and"
	echo "		  creates the signed uImage using mkimage tool"
	echo "		- output file: uImage.signed"
	echo "Signing dtb file"
	echo "	# ift-sign-image.sh -dtb <filename>.dtb"	
	echo "		- This will sign the <filename>.dtb file with certificate"
	echo "		- outputfile: <filename>.dtb.signed"
	echo ""
	exit
}

# check if M-shield-DK tool is installed
TOOL=${MSHIELD_DK_DIR}
STR=""
if [ "$TOOL" == "$STR" ]
then
	fn_display_usage "M-Shield-DK is not installed, m-shield-dk/ift tool is required to sign the image"
fi

# validate input parameter
if [ $# -lt 2 ]
then
	fn_display_usage "missing parameter"	
fi

# generate MLO using M-sheild-dk generate_MLO script
if [ "$1" == "-mlo" ]; then
	cp ./spl/u-boot-spl.bin MLO
	if [ "$2" == "-dra7xx" ]; then
		${MSHIELD_DK_DIR}/generate_MLO DRA7XX ES1.0 MLO MLO
		exit
	fi
	if [ "$2" == "-omap5" ]; then
		${MSHIELD_DK_DIR}/generate_MLO OMAP5430 ES2.0 MLO MLO
		exit
	else
		fn_display_usage "Missing options: specifiy -dra7xx or -omap5"
	fi
	exit
fi

# ensure file size is 32 bit word aligned
R_ALIGN=$((4-($(stat -c %s $2) % 4)))
IS_ALIGN=$(($(stat -c %s $2) % 4))
cp $2 $2.aligned
if [ $IS_ALIGN != 0 ]; then
	truncate -c $2.aligned --size +${R_ALIGN}
fi

IS_VALID=0
# chose certificate signature information
if [ "$1" == "-kernel" ]; then
	CERT_INFO="CERT_KERNEL"
	CERT_SIGN=$CERT_KERNEL_MAGIC
	IS_VALID=1
fi

if [ "$1" == "-uboot" ]; then
	CERT_INFO="CERT_U-BOOT"
	CERT_SIGN=$CERT_U_BOOT_MAGIC
	IS_VALID=1
fi

if [ "$1" == "-ramdisk" ]; then
	CERT_INFO="CERT_RAMDISK"
	CERT_SIGN=$CERT_RAMDISK_MAGIC
	IS_VALID=1
fi

if [ "$1" == "-dtb" ]; then
	CERT_INFO="CERT_DTB"
	CERT_SIGN=$CERT_DTB_MAGIC
	IS_VALID=1
fi

if [ $IS_VALID -eq 0 ]; then
	fn_display_usage "Invalid paramerter: $1"
fi

# create a certificate image with .signed extension
${MSHIELD_DK_DIR}/ift/ift M -chip OMAP5430_ES2 -cert_sign -input $2.aligned -out $2.signed -certkey keys/rsa2048_6.pem -certkeyid e -certkeytype 0 -certsignerinfo $CERT_INFO -certsiginfo $CERT_SIGN

if [ "$1" == "-kernel" ]; then
	echo "removing intermediate file $2.signed"
	mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 -n "Linux" -d $2.signed uImage.signed
	rm $2.signed
	echo "uImage.signed Ready"
fi

# remove the intermediate files
rm $2.aligned
