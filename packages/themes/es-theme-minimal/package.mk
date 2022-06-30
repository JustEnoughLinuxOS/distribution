# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2022-present Fewtarius

PKG_NAME="es-theme-minimal"
PKG_VERSION="b478b0e3986e557b40fcd25a9e48d9956fa11a96"
PKG_ARCH="any"
PKG_LICENSE="creative commons CC-BY-NC-SA"
PKG_SITE="https://github.com/fabricecaruso/es-theme-minimal"
PKG_URL="${PKG_SITE}.git"
GET_HANDLER_SUPPORT="git"
PKG_SHORTDESC="Minimal"
PKG_LONGDESC="Minimal theme by fabricecaruso"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/themes/${PKG_NAME}
  cp -rf * ${INSTALL}/usr/share/themes/${PKG_NAME}
}
