# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2022-present Fewtarius

PKG_NAME="es-theme-minielec"
PKG_VERSION="b200af4"
PKG_ARCH="any"
PKG_LICENSE="CC BY-NC-SA 4.0"
PKG_SITE="https://github.com/Rose22/es-theme-minielec"
PKG_URL="${PKG_SITE}.git"
GET_HANDLER_SUPPORT="git"
PKG_SHORTDESC="Minielec"
PKG_LONGDESC="Minielec theme by Rose22"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/themes/${PKG_NAME}
  cp -rf * ${INSTALL}/usr/share/themes/${PKG_NAME}
}
