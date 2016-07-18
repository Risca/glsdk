# Define target platform.
PLATFORM=dra7xx
REVISION=ES10
DEFAULT_LINUXKERNEL_CONFIG=omap2plus_defconfig
DEFAULT_UBOOT_CONFIG=dra7xx_evm_config
DEFAULT_IPUMM_CONFIG=vayu_smp_config
DEFAULT_DSPDCE_CONFIG=vayu_config
BIOS_VERSION=6_45_01_29
IPC_VERSION=3_43_01_03
IPUMM_VERSION=3_00_11_00
DSPDCE_VERSION=1_00_00_08
DUCATI_FW_GEN=dra7xx-m4-ipu2.xem4
DUCATI_FW=dra7-ipu2-fw.xem4
DSP_FW_GEN=dra7xx-c66x-dsp.xe66
DSP_FW=dra7-dsp1-fw.xe66
XDC_VERSION=xdctools_3_32_00_06_core
FC_VERSION=framework_components_3_40_01_04
PLATFORM_IPC=DRA7XX
LINUXUTILS_VERSION=4_11_00_01

# Cross compiler used for building linux and u-boot
TOOLCHAIN_INSTALL_DIR=$(HOME)/gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux
CROSS_COMPILE_PREFIX=$(TOOLCHAIN_INSTALL_DIR)/bin/arm-linux-gnueabihf-

# The installation directory of the SDK.
PSDKLA_INSTALL_DIR=$(shell pwd)

# The directory that points to your kernel source directory.
LINUXKERNEL_INSTALL_DIR=$(PSDKLA_INSTALL_DIR)/board-support/linux
KERNEL_INSTALL_DIR=$(LINUXKERNEL_INSTALL_DIR)

# The directory that points to the SGX kernel module sources.
SGX_KERNEL_MODULE_PATH=$(PSDKLA_INSTALL_DIR)/board-support/external-linux-kernel-modules/omap5-sgx-ddk-linux/eurasia_km/eurasiacon/build/linux2/omap_linux

# The directory that points to your u-boot source directory.
UBOOT_INSTALL_DIR=$(PSDKLA_INSTALL_DIR)/board-support/u-boot

# The directory that points to your ARM Code Gen tools directory
TMS470CGTOOLPATH_INSTALL_DIR=$(PSDKLA_INSTALL_DIR)/ti-devkit/ti-cgt-arm_5.2.7

# The directory where the Code Gen is installed.
CODEGEN_INSTALL_DIR=$(PSDKLA_INSTALL_DIR)/ti-devkit/cgt6x_7_4_13

# The directory that points to the bios tools directory.
BIOSTOOLSROOT_INSTALL_DIR=$(PSDKLA_INSTALL_DIR)/component-sources

# The directory that points to your bios source directory.
BIOS_INSTALL_DIR=$(PSDKLA_INSTALL_DIR)/component-sources/bios_$(BIOS_VERSION)

# The directory that points to your bios source directory.
XDC_INSTALL_DIR=$(PSDKLA_INSTALL_DIR)/component-sources/$(XDC_VERSION)

# The directory that points to your ipc source directory.
IPC_INSTALL_DIR=$(PSDKLA_INSTALL_DIR)/component-sources/ipc_$(IPC_VERSION)

# The directory that points to your ipumm source directory.
IPUMM_INSTALL_DIR=$(PSDKLA_INSTALL_DIR)/component-sources/ipumm_$(IPUMM_VERSION)

# The directory that points to your dsp source directory.
DSPDCE_INSTALL_DIR=$(PSDKLA_INSTALL_DIR)/component-sources/dspdce_$(DSPDCE_VERSION)

# Directory where linux utils is installed
LINUXUTILS_INSTALL_DIR=${PSDKLA_INSTALL_DIR}/component-sources/linuxutils_${LINUXUTILS_VERSION}

# Kernel/U-Boot build variables
LINUXKERNEL_BUILD_VARS = ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE_PREFIX)
UBOOT_BUILD_VARS = CROSS_COMPILE=$(CROSS_COMPILE_PREFIX)

# Where to copy the resulting executables
EXEC_DIR=$(HOME)/install/$(PLATFORM)

# IPC variables
IPC_BUILD_VARS = TMS470CGTOOLPATH=$(TMS470CGTOOLPATH_INSTALL_DIR) \
	BIOSTOOLSROOT=$(BIOSTOOLSROOT_INSTALL_DIR) \
    C66XCGTOOLSPATH=$(CODEGEN_INSTALL_DIR) \
	XDCVERSION=$(XDC_VERSION) \
	XDC_INSTALL_DIR=$(BIOSTOOLSROOT_INSTALL_DIR)/$(XDC_VERSION) \
	BIOS_INSTALL_DIR=$(BIOS_INSTALL_DIR)

# IPUMM build variables
IPUMM_BUILD_VARS = BIOSTOOLSROOT=$(BIOSTOOLSROOT_INSTALL_DIR) \
	IPCSRC=$(IPC_INSTALL_DIR) \
	TMS470CGTOOLPATH=$(TMS470CGTOOLPATH_INSTALL_DIR) \
	BIOSVERSION=bios_$(BIOS_VERSION) \
	XDCVERSION=$(XDC_VERSION) \
	XDC_INSTALL_DIR=$(BIOSTOOLSROOT_INSTALL_DIR)/$(XDC_VERSION) \
	FCVERSION=$(FC_VERSION) \
	TRACELEVEL=1 \
	HWVERSION=$(REVISION)

# DSPDCE build variables
DSPDCE_BUILD_VARS = BIOSTOOLSROOT=$(BIOSTOOLSROOT_INSTALL_DIR) \
    IPCSRC=$(IPC_INSTALL_DIR) \
    IPCVERSION=ipc_$(IPC_VERSION) \
    BIOSVERSION=bios_$(BIOS_VERSION) \
    XDCVERSION=$(XDC_VERSION) \
    FCVERSION=$(FC_VERSION) \
    C66XCGTOOLSPATH=$(CODEGEN_INSTALL_DIR) \
    PLATFORM=$(REVISION)

# CMEM build variables
# Arguments for building the kernel module
CMEM_KO_BUILD_VARS = ARCH=arm TOOLCHAIN_PREFIX=$(CROSS_COMPILE_PREFIX) \
					 KERNEL_INSTALL_DIR=${KERNEL_INSTALL_DIR}
CMEM_CONFIG_VARS = ARCH=arm TOOLCHAIN_PREFIX=$(CROSS_COMPILE_PREFIX) \
	CC=$(CROSS_COMPILE_PREFIX)gcc --host=arm-linux-gnueabihf
