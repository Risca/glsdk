# Define target platform.
PLATFORM=omap5
REVISION=ES20
KERNEL_VERSION=3.8.13
UBOOT_VERSION=2013.04
DEFAULT_LINUXKERNEL_CONFIG=omap2plus_defconfig
DEFAULT_DTB_NAME=omap5-uevm.dtb

# Cross compiler used for building linux and u-boot
CROSS_COMPILE_PREFIX=arm-linux-gnueabihf-

# The installation directory of the SDK.
GLSDK_INSTALL_DIR=$(shell pwd)

# For backwards compatibility
DVSDK_INSTALL_DIR=$(GLSDK_INSTALL_DIR)

# The directory that points to your kernel source directory.
LINUXKERNEL_INSTALL_DIR=$(DVSDK_INSTALL_DIR)/board-support/linux_$(KERNEL_VERSION)
KERNEL_INSTALL_DIR=$(LINUXKERNEL_INSTALL_DIR)

# The directory that points to your u-boot source directory.
UBOOT_INSTALL_DIR=$(DVSDK_INSTALL_DIR)/board-support/u-boot_$(UBOOT_VERSION)

# Kernel/U-Boot build variables
LINUXKERNEL_BUILD_VARS = ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE_PREFIX)
UBOOT_BUILD_VARS = CROSS_COMPILE=$(CROSS_COMPILE_PREFIX)

# Where to copy the resulting executables
EXEC_DIR=$(HOME)/install/$(PLATFORM)
