################################################################################
#
# Rockchip loader binaries
#
################################################################################

ROCKCHIP_BLOBS_VERSION = $(call qstrip,$(BR2_PACKAGE_ROCKCHIP_BLOBS_VERSION))
ROCKCHIP_BLOBS_SOURCE = $(ROCKCHIP_BLOBS_VERSION).tar.gz
ROCKCHIP_BLOBS_SITE = https://github.com/rockchip-linux/rkbin/archive
ROCKCHIP_BLOBS_LICENSE = PROPRIETARY
ROCKCHIP_BLOBS_INSTALL_IMAGES = YES

define ROCKCHIP_BLOBS_INSTALL_IMAGES_CMDS
ifeq ($(BR2_PACKAGE_ROCKCHIP_BLOBS_ATF_INSTALL),y)
define ROCKCHIP_BLOBS_ATF_INSTALL
       $(INSTALL) -D -m 0644 $(@D)/$(BR2_PACKAGE_ROCKCHIP_BLOBS_ATF) $(BINARIES_DIR)/bl31.elf
endef
endif
ifeq ($(BR2_PACKAGE_ROCKCHIP_BLOBS_TPL_INSTALL),y)
define ROCKCHIP_BLOBS_TPL_INSTALL
       $(INSTALL) -D -m 0644 $(@D)/$(BR2_PACKAGE_ROCKCHIP_BLOBS_TPL) $(BINARIES_DIR)/ram_init.bin
endef
endif
endef

$(eval $(generic-package))

