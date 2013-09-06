# Define target platform.
PLATFORM=dra7xx
REVISION=ES10
DEFAULT_LINUXKERNEL_CONFIG=omap2plus_defconfig
DEFAULT_UBOOT_CONFIG=dra7xx_evm_config
DEFAULT_DTB_NAME=dra7-evm.dtb
DEFAULT_IPUMM_CONFIG=vayu_smp_config
IPC_VERSION=3_10_00_08
IPUMM_VERSION=3_00_00_05
XDC_VERSION=xdctools_3_25_02_70
PLATFORM_IPC=dra7xx

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
TMS470CGTOOLPATH_INSTALL_DIR=$(DVSDK_INSTALL_DIR)/ti-devkit/ti-devkit/TI_CGT_TI\ ARM_5.1.0/

# The directory that points to the bios tools directory.
BIOSTOOLSROOT_INSTALL_DIR=$(DVSDK_INSTALL_DIR)/component-sources

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
	XDCVERSION=$(XDC_VERSION)

# IPUMM build variables
IPUMM_BUILD_VARS = BIOSTOOLSROOT=$(BIOSTOOLSROOT_INSTALL_DIR) \
	IPCSRC=$(IPC_INSTALL_DIR) \
	TMS470CGTOOLPATH=$(TMS470CGTOOLPATH_INSTALL_DIR) \
	PLATFORM=$(REVISION)

# Where to copy the resulting executables
EXEC_DIR=$(HOME)/install/$(PLATFORM)
