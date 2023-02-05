# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2022-present Fewtarius

PKG_NAME="ectool"
PKG_VERSION="4d661eebe95b06acae7d99777ed36ba56a560112"
PKG_LICENSE="GPL"
PKG_SITE="https://review.coreboot.org/coreboot"
PKG_URL="${PKG_SITE}.git"
PKG_ARCH="x86_64"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A simple tool for manipulating the embedded controller."

make_target() {
  cd util/ectool
  make
}

