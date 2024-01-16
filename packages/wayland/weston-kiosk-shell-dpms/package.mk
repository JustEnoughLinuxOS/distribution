# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="weston-kiosk-shell-dpms"
PKG_VERSION="dccd7db3905464bb0c00b65ee554b0fd2e3ba7b6"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/akhilharihar/Weston-kiosk-shell-DPMS"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain weston"
PKG_LONGDESC="A dpms module for Weston's kiosk shell."

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_BUILD}/.${TARGET_NAME}/dpms-client ${INSTALL}/usr/bin
  chmod 0755 ${INSTALL}/usr/bin/dpms-client
}
