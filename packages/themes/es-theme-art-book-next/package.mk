# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020 Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2020 351ELEC team (https://github.com/fewtarius/351ELEC)
# Copyright (C) 2021 Fewtarius

PKG_NAME="es-theme-art-book-next"
PKG_VERSION="f8c18db7824cabda52e762214e6b526835cf92dc"
PKG_ARCH="any"
PKG_LICENSE="CUSTOM"
PKG_SITE="https://github.com/anthonycaccese/art-book-next-jelos"
PKG_URL="${PKG_SITE}.git"
GET_HANDLER_SUPPORT="git"
PKG_SHORTDESC="Art Book Next"
PKG_LONGDESC="Art Book Next"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/themes/${PKG_NAME}
  cp -rf * ${INSTALL}/usr/share/themes/${PKG_NAME}
}
