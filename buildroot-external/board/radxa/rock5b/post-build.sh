#!/bin/sh
# $1 is the target directory (the rootfs staging dir)
TARGET_DIR="$1"

chmod 755 "$TARGET_DIR/usr/sbin/lan-leds"
chmod 755 "$TARGET_DIR/etc/init.d/S99lan-leds" 2>/dev/null || true
