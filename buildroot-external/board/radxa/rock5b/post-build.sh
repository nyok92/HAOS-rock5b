#!/bin/sh
# $1 is the target directory (the rootfs staging dir)
TARGET_DIR="$1"
mkdir -p "$TARGET_DIR/etc/systemd/system/multi-user.target.wants"
ln -sf /etc/systemd/system/lan-leds.service \
  "$TARGET_DIR/etc/systemd/system/multi-user.target.wants/lan-leds.service"
chmod 755 "$TARGET_DIR/usr/sbin/lan-leds"
