# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="wlan-firmware"
PKG_VERSION="8c5dcb7"
PKG_LICENSE="Free-to-use"
PKG_SITE="https://github.com/LibreELEC/wlan-firmware"
PKG_URL="https://github.com/LibreELEC/wlan-firmware/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain rfkill linux kernel-firmware"
PKG_LONGDESC="wlan-firmware: firmwares for various WLAN drivers"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  DESTDIR=${INSTALL}/$(get_kernel_overlay_dir) ./install
}
