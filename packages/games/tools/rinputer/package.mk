# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="rinputer"
PKG_VERSION="74033c3"
PKG_LICENSE="BSD 4-Clause"
PKG_SITE="https://github.com/R-ARM/Rinputer3"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain rust cargo"
PKG_LONGDESC="Rinputer3, this time in Rust."
PKG_TOOLCHAIN="manual"

make_target() {
  cargo build --release
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp target/release/rinputer3 ${INSTALL}/usr/bin
  chmod 0755 ${INSTALL}/usr/bin/*
  mkdir -p ${INSTALL}/etc
  cp rinputer3.ron ${INSTALL}/etc/
  mkdir -p ${INSTALL}/usr/lib/system.d
  cp Rinputer3.service ${INSTALL}/usr/lib/system.d/
}

post_install() {
  enable_service Rinputer3.service
}
