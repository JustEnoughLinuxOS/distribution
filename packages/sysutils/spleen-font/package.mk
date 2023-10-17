# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="spleen-font"
PKG_VERSION="2.0.0"
PKG_LICENSE="BSD-2-Clause"
PKG_SITE="https://github.com/fcambus/spleen"
PKG_URL="${PKG_SITE}/releases/download/${PKG_VERSION}/spleen-${PKG_VERSION}.tar.gz"

PKG_DEPENDS_INIT="toolchain"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="This package contains the Spleen Font"
PKG_TOOLCHAIN="manual"

pre_configure_init() {
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}-${TARGET}
}

pre_configure_target() {
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}-${TARGET}
}

configure_init() {
  :
}

configure_target() {
  :
}

make_init() {
  :
}

make_target() {
  :
}

makeinstall_init() {
  mkdir -p ${INSTALL}/usr/share/consolefonts
  cp -rf *.bdf ${INSTALL}/usr/share/consolefonts
  cp -rf *.psfu ${INSTALL}/usr/share/consolefonts
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/consolefonts
  cp -rf ${PKG_BUILD}/*.bdf ${INSTALL}/usr/share/consolefonts
  cp -rf ${PKG_BUILD}/*.psfu ${INSTALL}/usr/share/consolefonts
}
