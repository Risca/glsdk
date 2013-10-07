# Define target platform.
PLATFORM=omap5
REVISION=ES20
DEFAULT_LINUXKERNEL_CONFIG=omap2plus_defconfig
DEFAULT_UBOOT_CONFIG=omap5_uevm_config
DEFAULT_DTB_NAME=omap5-uevm.dtb
DEFAULT_IPUMM_CONFIG=omap5_smp_config
BIOS_VERSION=6_35_02_45
IPC_VERSION=3_10_00_08
IPUMM_VERSION=3_00_03_02
XDC_VERSION=xdctools_3_25_02_70
PLATFORM_IPC=omap54xx_smp

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
	PLATFORM=$(REVISION)

# Where to copy the resulting executables
EXEC_DIR=$(HOME)/install/$(PLATFORM)
