# Copyright (C) 2022-present Brooksytech (https://github.com/brooksytech)

PKG_NAME="rinputer2"
PKG_VERSION="b1fc0fb69047011d99b54029be500280d33a8027"
PKG_ARCH="aarch64"
PKG_LICENSE="BSD 4-Clause-modified"
PKG_SITE="https://github.com/R-ARM/rinputer2"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_TOOLCHAIN="make"
GET_HANDLER_SUPPORT="git"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp rinputer2 ${INSTALL}/usr/bin
  chmod 0755 ${INSTALL}/usr/bin/rinputer2
}

post_install() {
  enable_service Rinputer2.service
}
