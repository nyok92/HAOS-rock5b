################################################################################
#
# ROCKCHIP_RGA
#
################################################################################
# v1.10.6
#ROCKCHIP_RGA_VERSION = 2b32edcb97b601b25683e2941d888c8515da6d55
#ROCKCHIP_RGA_SITE = $(call github,airockchip,librga,$(ROCKCHIP_RGA_VERSION))
ROCKCHIP_RGA_VERSION = master
ROCKCHIP_RGA_SITE = $(call github,tsukumijima,librga-rockchip,$(ROCKCHIP_RGA_VERSION))
ROCKCHIP_RGA_LICENSE = Apache-2.0
ROCKCHIP_RGA_LICENSE_FILES = CHANGELOG.md
ROCKCHIP_RGA_INSTALL_STAGING = YES

ROCKCHIP_RGA_DEPENDENCIES = libdrm

ROCKCHIP_RGA_CONF_OPTS = \
	-Dlibdrm=true \
	-Dlibrga_demo=false

define ROCKCHIP_RGA_CLEAN_TARGET
	rm -rf $(TARGET_DIR)/usr/include/rga
	rm -f $(TARGET_DIR)/usr/lib/librga.a
	rm -f $(TARGET_DIR)/usr/lib/pkgconfig/librga.pc
endef
ROCKCHIP_RGA_POST_INSTALL_TARGET_HOOKS += ROCKCHIP_RGA_CLEAN_TARGET

$(eval $(meson-package))
