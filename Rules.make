# Define target platform.
PLATFORM=omap5
REVISION=ES20
DEFAULT_LINUXKERNEL_CONFIG=omap2plus_defconfig
DEFAULT_UBOOT_CONFIG=omap5_uevm_config
DEFAULT_DTB_NAME=omap5-uevm.dtb

# Cross compiler used for building linux and u-boot
CROSS_COMPILE_PREFIX=arm-linux-gnueabihf-

# The installation directory of the SDK.
GLSDK_INSTALL_DIR=$(shell pwd)

# For backwards compatibility
DVSDK_INSTALL_DIR=$(GLSDK_INSTALL_DIR)

# The directory that points to your kernel source directory.
LINUXKERNEL_INSTALL_DIR=$(DVSDK_INSTALL_DIR)/board-support/linux
KERNEL_INSTALL_DIR=$(LINUXKERNEL_INSTALL_DIR)

# The directory that points to your u-boot source directory.
UBOOT_INSTALL_DIR=$(DVSDK_INSTALL_DIR)/board-support/u-boot

# Kernel/U-Boot build variables
LINUXKERNEL_BUILD_VARS = ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE_PREFIX)
UBOOT_BUILD_VARS = CROSS_COMPILE=$(CROSS_COMPILE_PREFIX)

# Where to copy the resulting executables
EXEC_DIR=$(HOME)/install/$(PLATFORM)
