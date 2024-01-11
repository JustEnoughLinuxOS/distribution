# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="virtualgamepad"
PKG_VERSION="a6e8459"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/macromorgan/input-wrapper"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp wrap ${INSTALL}/usr/bin/virtualgamepad
  chmod 0755 ${INSTALL}/usr/bin/virtualgamepad
}

post_install() {
  enable_service virtualgamepad.service
}
