# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2023-present UzuCore

PKG_NAME="es-theme-anbernic-dc"
PKG_VERSION="faa6e2c5d3987d4f4993a3439a94ea469b312fde"
PKG_ARCH="any"
PKG_LICENSE="CUSTOM"
PKG_SITE="https://github.com/UzuCore/es-theme-anbernic-dc"
PKG_URL="${PKG_SITE}.git"
GET_HANDLER_SUPPORT="git"
PKG_SHORTDESC="Epic Noir"
PKG_LONGDESC="Anbernic Epic Noir"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/themes/${PKG_NAME}
  cp -rf * ${INSTALL}/usr/share/themes/${PKG_NAME}
}
