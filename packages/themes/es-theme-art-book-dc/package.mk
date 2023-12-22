# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020 Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2020 351ELEC team (https://github.com/fewtarius/351ELEC)
# Copyright (C) 2021 Fewtarius

PKG_NAME="es-theme-art-book-dc"
PKG_VERSION="d4406c994e9cb3ccc5b1684e02167385ad4f0f45"
PKG_ARCH="any"
PKG_LICENSE="CUSTOM"
PKG_SITE="https://github.com/UzuCore/es-theme-art-book-dc"
PKG_URL="${PKG_SITE}.git"
GET_HANDLER_SUPPORT="git"
PKG_SHORTDESC="Art Book dc"
PKG_LONGDESC="Art Book dc"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/themes/${PKG_NAME}
  cp -rf * ${INSTALL}/usr/share/themes/${PKG_NAME}
}
