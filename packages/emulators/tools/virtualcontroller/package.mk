# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="virtualcontroller"
PKG_VERSION="31985f2e1da8cfcf599a068845ddd3713ba3616c"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/macromorgan/input-wrapper"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp virtual_controller ${INSTALL}/usr/bin/virtual_controller
  chmod 0755 ${INSTALL}/usr/bin/virtual_controller
}

post_install() {
  enable_service virtualcontroller.service
}
