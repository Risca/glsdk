include Rules.make

.PHONY:	components components_clean components_linux all clean help linux linux_clean linux_install install u-boot u-boot_clean u-boot_install

#==============================================================================
# Build everything rebuildable.
#==============================================================================
all: components apps

#==============================================================================
# Build components to enable all other build targets.
#==============================================================================
components: components_linux components_ipu components_dsp
components_linux: linux
components_ipu: ipumm
components_dsp: dspdce
#==============================================================================
# Install components
#==============================================================================
components_install: linux_install ipumm_install dspdce_install

#==============================================================================
# Clean up the targets built by 'make all'.
#==============================================================================
components_clean: linux_clean ipc_clean ipumm_clean dspdce_clean

#==============================================================================
# Build all Demos, Examples and Applications
#==============================================================================
apps: u-boot

#==============================================================================
# Install everything
#==============================================================================
apps_install: u-boot_install

#==============================================================================
# Clean all Demos, Examples and Applications
#==============================================================================
apps_clean: u-boot_clean

#==============================================================================
# Install everything
#==============================================================================
install: components_install apps_install
#==============================================================================
# Clean up all targets.
#==============================================================================
clean: components_clean apps_clean

#==============================================================================
# A help message target.
#==============================================================================
help:
	@echo
	@echo "Available build targets are  :"
	@echo
	@echo "    components_linux               : Build the Linux components"
	@echo "    components_ipu                 : Build the IPU components"
	@echo "    components_dsp                 : Build the DSP components"
	@echo "    components                     : Build the components for which a rebuild is necessary to enable all other build targets listed below. You must do this at least once upon installation prior to attempting the other targets."
	@echo "    components_clean               : Remove files generated by the 'components' target"
	@echo
	@echo "    apps                           : Build all Examples, Demos and Applications"
	@echo "    apps_clean                     : Remove all files generated by 'apps' target"
	@echo "    apps_install                   : Install all Examples, Demos and Applications the targets in $(EXEC_DIR)"
	@echo
	@echo
	@echo "    linux                          : Build Linux kernel uImage and module"
	@echo "    linux_clean                    : Remove generated Linux kernel files"
	@echo "    linux_install                  : Install kernel binary and  modules"
	@echo
	@echo "    ipc_ipu                        : Build ipc for IPU"
	@echo "    ipc_dsp                        : Build ipc for DSP"
	@echo "    ipc_clean                      : Remove generated ipc files"
	@echo
	@echo "    u-boot                         : Build the u-boot boot loader"
	@echo "    u-boot_clean                   : Remove generated u-boot files"
	@echo "    u-boot_install                 : Install the u-boot image"
	@echo
	@echo "    ipumm                          : Build the ipumm firmware"
	@echo "    ipumm_clean                    : Remove generated ipumm files"
	@echo "    ipumm_install                  : Install the ipumm firmware"
	@echo
	@echo
	@echo "    dspdce                          : Build the dspdce firmware"
	@echo "    dspdce_clean                    : Remove generated dspdce files"
	@echo "    dspdce_install                  : Install the dspdce firmware"
	@echo
	@echo
	@echo "    all                            : Rebuild everything"
	@echo "    clean                          : Remove all generated files"
	@echo
	@echo "    install                        : Install all the targets in "
	@echo "                            $(EXEC_DIR)"
	@echo

#==============================================================================
# Build the Linux kernel. Also, an explicit cleanup target is defined.
#==============================================================================
linux:
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm $(DEFAULT_LINUXKERNEL_CONFIG)
	cd board-support/linux/; pwd ; ./scripts/kconfig/merge_config.sh -m .config ti_config_fragments/audio_display.cfg ti_config_fragments/baseport.cfg ti_config_fragments/connectivity.cfg ti_config_fragments/ipc.cfg ti_config_fragments/power.cfg ti_config_fragments/wlan.cfg ti_config_fragments/system_test.cfg ti_config_fragments/auto.cfg ti_config_fragments/radio.cfg 
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) olddefconfig ARCH=arm
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) $(LINUXKERNEL_BUILD_VARS) zImage
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) $(LINUXKERNEL_BUILD_VARS) dtbs
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) $(LINUXKERNEL_BUILD_VARS) modules
	$(MAKE) -C $(SGX_KERNEL_MODULE_PATH) $(LINUXKERNEL_BUILD_VARS) KERNELDIR=$(LINUXKERNEL_INSTALL_DIR) DISCIMAGE=$(EXEC_DIR)

linux_clean:
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) mrproper
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) $(LINUXKERNEL_BUILD_VARS) clean

linux_install:
	install -d $(EXEC_DIR)/boot
	install  $(LINUXKERNEL_INSTALL_DIR)/arch/arm/boot/zImage $(EXEC_DIR)/boot
	install  $(LINUXKERNEL_INSTALL_DIR)/arch/arm/boot/dts/*.dtb $(EXEC_DIR)/boot
	install  $(LINUXKERNEL_INSTALL_DIR)/vmlinux $(EXEC_DIR)/boot
	install  $(LINUXKERNEL_INSTALL_DIR)/System.map $(EXEC_DIR)/boot
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) $(LINUXKERNEL_BUILD_VARS) INSTALL_MOD_PATH=$(EXEC_DIR)/ modules_install
	$(MAKE) -C $(SGX_KERNEL_MODULE_PATH) $(LINUXKERNEL_BUILD_VARS) KERNELDIR=$(LINUXKERNEL_INSTALL_DIR) DISCIMAGE=$(EXEC_DIR) kbuild_install

#==============================================================================
# Build u-boot. Also, an explicit cleanup target is defined.
#==============================================================================
u-boot:
	$(MAKE) -C $(UBOOT_INSTALL_DIR) $(UBOOT_BUILD_VARS) $(DEFAULT_UBOOT_CONFIG)
	$(MAKE) -C $(UBOOT_INSTALL_DIR) $(UBOOT_BUILD_VARS)

u-boot_clean:
	$(MAKE) -C $(UBOOT_INSTALL_DIR) $(UBOOT_BUILD_VARS) distclean

u-boot_install:
	install -d $(EXEC_DIR)/boot
	install $(UBOOT_INSTALL_DIR)/MLO $(EXEC_DIR)/boot
	install $(UBOOT_INSTALL_DIR)/u-boot.img $(EXEC_DIR)/boot
	install $(UBOOT_INSTALL_DIR)/u-boot.map $(EXEC_DIR)/boot

#==============================================================================
# Build ipc for ipu. Also, an explicit cleanup target is defined.
#==============================================================================
ipc_ipu:
	$(MAKE) -C $(IPC_INSTALL_DIR) PLATFORM=${PLATFORM_IPC} ti.targets.arm.elf.M4=${TMS470CGTOOLPATH_INSTALL_DIR} XDC_INSTALL_DIR=${XDC_INSTALL_DIR} BIOS_INSTALL_DIR=${BIOS_INSTALL_DIR} -ef ipc-bios.mak all

#==============================================================================
# Build ipc for dsp. Also, an explicit cleanup target is defined.
#==============================================================================
ipc_dsp:
	$(MAKE) -C $(IPC_INSTALL_DIR) PLATFORM=${PLATFORM_IPC} ti.targets.elf.C66=${CODEGEN_INSTALL_DIR} XDC_INSTALL_DIR=${XDC_INSTALL_DIR} BIOS_INSTALL_DIR=${BIOS_INSTALL_DIR} -f ipc-bios.mak all

ipc_mpu: linux_utils
	$(MAKE) -e -C $(IPC_INSTALL_DIR) PLATFORM=${PLATFORM_IPC} \
		CMEM_INSTALL_DIR=${LINUXUTILS_INSTALL_DIR} \
		TOOLCHAIN_LONGNAME=arm-linux-gnueabihf \
		TOOLCHAIN_PREFIX=${CROSS_COMPILE_PREFIX} \
		KERNEL_INSTALL_DIR=${KERNEL_INSTALL_DIR} \
		-f ipc-linux.mak config
	$(MAKE) -C $(IPC_INSTALL_DIR)

ipc_clean:
	$(MAKE) -C $(IPC_INSTALL_DIR) $(IPC_BUILD_VARS) -f ipc-bios.mak clean


#==============================================================================
# Build ipumm. Also, an explicit cleanup target is defined.
#==============================================================================
ipumm:ipc_ipu
	$(MAKE) -C $(IPUMM_INSTALL_DIR) $(IPUMM_BUILD_VARS) $(DEFAULT_IPUMM_CONFIG)
	$(MAKE) -C $(IPUMM_INSTALL_DIR) $(IPUMM_BUILD_VARS)

ipumm_clean:
	$(MAKE) -C $(IPUMM_INSTALL_DIR) $(IPUMM_BUILD_VARS) clean

ipumm_install:
	install -d $(EXEC_DIR)/lib/firmware
	install  $(IPUMM_INSTALL_DIR)/$(DUCATI_FW_GEN) $(EXEC_DIR)/lib/firmware/$(DUCATI_FW)

#==============================================================================
# Build dspdce. Also, an explicit cleanup target is defined.
#==============================================================================
dspdce:ipc_dsp
	$(MAKE) -C $(DSPDCE_INSTALL_DIR) $(DSPDCE_BUILD_VARS) $(DEFAULT_DSPDCE_CONFIG)
	$(MAKE) -C $(DSPDCE_INSTALL_DIR) $(DSPDCE_BUILD_VARS)

dspdce_clean:
	$(MAKE) -C $(DSPDCE_INSTALL_DIR) $(DSPDCE_BUILD_VARS) clean

dspdce_install:
	install -d $(EXEC_DIR)/lib/firmware
	install  $(DSPDCE_INSTALL_DIR)/$(DSP_FW_GEN) $(EXEC_DIR)/lib/firmware/$(DSP_FW)

#==============================================================================
# Build Linux Utils. This is required for using CMEM allocator in user space
#==============================================================================
linux_utils:
	cd $(LINUXUTILS_INSTALL_DIR);./configure --prefix=${LINUXUTILS_INSTALL_DIR}/out \
	   $(CMEM_CONFIG_VARS)
	make -C $(LINUXUTILS_INSTALL_DIR)
	make -C $(LINUXUTILS_INSTALL_DIR) install
	make -e -C $(LINUXUTILS_INSTALL_DIR)/src/cmem/module \
	   $(CMEM_KO_BUILD_VARS)
