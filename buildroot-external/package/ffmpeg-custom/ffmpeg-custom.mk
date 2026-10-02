FFMPEG_CUSTOM_VERSION = n7.1                      # tag or full commit hash
FFMPEG_CUSTOM_SITE = https://github.com/FFmpeg/FFmpeg.git
FFMPEG_CUSTOM_SITE_METHOD = git
FFMPEG_CUSTOM_INSTALL_STAGING = YES
FFMPEG_CUSTOM_LICENSE = LGPL-2.1+
FFMPEG_CUSTOM_LICENSE_FILES = COPYING.LGPLv2.1

FFMPEG_CUSTOM_CONF_OPTS = \
	--prefix=/usr \
	--enable-cross-compile \
	--cross-prefix=$(TARGET_CROSS) \
	--sysroot=$(STAGING_DIR) \
	--host-cc="$(HOSTCC)" \
	--arch=$(BR2_ARCH) \
	--target-os=linux \
	--disable-doc \
	--disable-debug \
	--enable-shared \
	--disable-static \
	--enable-pic \
	--pkg-config="$(PKG_CONFIG_HOST_BINARY)"

# FFmpeg's configure is not autotools-generated, so it needs a custom configure step
define FFMPEG_CUSTOM_CONFIGURE_CMDS
	cd $(FFMPEG_CUSTOM_SRCDIR) && rm -rf config.cache && \
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_CONFIGURE_ARGS) \
	./configure $(FFMPEG_CUSTOM_CONF_OPTS)
endef

define FFMPEG_CUSTOM_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define FFMPEG_CUSTOM_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(STAGING_DIR) install
endef

define FFMPEG_CUSTOM_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
