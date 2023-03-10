# Define target platform.
PLATFORM=omap5
REVISION=ES20
DEFAULT_LINUXKERNEL_CONFIG=omap2plus_defconfig
DEFAULT_UBOOT_CONFIG=omap5_uevm_config
DEFAULT_DTB_NAME=omap5-uevm.dtb
DEFAULT_IPUMM_CONFIG=omap5_smp_config
BIOS_VERSION=6_35_03_47
IPC_VERSION=3_20_00_06
IPUMM_VERSION=3_00_03_04
DUCATI_FW_GEN=omap5-m4-ipu.xem4
DUCATI_FW=ducati-m3-core0.xem3
XDC_VERSION=xdctools_3_25_04_88
PLATFORM_IPC=OMAP54XX

# Cross compiler used for building linux and u-boot
CROSS_COMPILE_PREFIX=arm-linux-gnueabihf-
TOOLCHAIN_INSTALL_DIR=$(HOME)/gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux

# The installation directory of the SDK.
GLSDK_INSTALL_DIR=$(shell pwd)

# For backwards compatibility
DVSDK_INSTALL_DIR=$(GLSDK_INSTALL_DIR)

# The directory that points to your kernel source directory.
LINUXKERNEL_INSTALL_DIR=$(DVSDK_INSTALL_DIR)/board-support/linux
KERNEL_INSTALL_DIR=$(LINUXKERNEL_INSTALL_DIR)

# The directory that points to the SGX kernel module sources.
SGX_KERNEL_MODULE_PATH=$(GLSDK_INSTALL_DIR)/board-support/external-linux-kernel-modules/omap5-sgx-ddk-linux/eurasia_km/eurasiacon/build/linux2/omap5430_linux

# The directory that points to your u-boot source directory.
UBOOT_INSTALL_DIR=$(DVSDK_INSTALL_DIR)/board-support/u-boot

# The directory that points to your u-boot source directory.
TMS470CGTOOLPATH_INSTALL_DIR=$(DVSDK_INSTALL_DIR)/ti-devkit/cgt470_5_0_1

# The directory that points to the bios tools directory.
BIOSTOOLSROOT_INSTALL_DIR=$(DVSDK_INSTALL_DIR)/component-sources

# The directory that points to your bios source directory.
BIOS_INSTALL_DIR=$(DVSDK_INSTALL_DIR)/component-sources/bios_$(BIOS_VERSION)

# The directory that points to your ipc source directory.
IPC_INSTALL_DIR=$(DVSDK_INSTALL_DIR)/component-sources/ipc_$(IPC_VERSION)

# The directory that points to your ipumm source directory.
IPUMM_INSTALL_DIR=$(DVSDK_INSTALL_DIR)/component-sources/ipumm_$(IPUMM_VERSION)

# Kernel/U-Boot build variables
LINUXKERNEL_BUILD_VARS = ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE_PREFIX)
UBOOT_BUILD_VARS = CROSS_COMPILE=$(CROSS_COMPILE_PREFIX)

# Where to copy the resulting executables
EXEC_DIR=$(HOME)/install/$(PLATFORM)

# IPC variables
IPC_BUILD_VARS = TMS470CGTOOLPATH=$(TMS470CGTOOLPATH_INSTALL_DIR) \
	BIOSTOOLSROOT=$(BIOSTOOLSROOT_INSTALL_DIR) \
	XDCVERSION=$(XDC_VERSION) \
	XDC_INSTALL_DIR=$(BIOSTOOLSROOT_INSTALL_DIR)/$(XDC_VERSION) \
	BIOS_INSTALL_DIR=$(BIOS_INSTALL_DIR)

# IPUMM build variables
IPUMM_BUILD_VARS = BIOSTOOLSROOT=$(BIOSTOOLSROOT_INSTALL_DIR) \
	IPCSRC=$(IPC_INSTALL_DIR) \
	TMS470CGTOOLPATH=$(TMS470CGTOOLPATH_INSTALL_DIR) \
	HWVERSION=$(REVISION)

# Where to copy the resulting executables
EXEC_DIR=$(HOME)/install/$(PLATFORM)
