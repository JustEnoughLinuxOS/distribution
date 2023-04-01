# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="quirks"
PKG_VERSION="$(date +%Y%m%d)"
PKG_ARCH="any"
PKG_LICENSE="apache2"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain autostart"
PKG_SHORTDESC="Quirks is a simple package that provides device quirks."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/autostart/quirks
  cp -r ${PKG_DIR}/sources/quirks/* ${INSTALL}/usr/lib/autostart/quirks
  chmod -R 0755 ${INSTALL}/usr/lib/autostart/quirks
}
