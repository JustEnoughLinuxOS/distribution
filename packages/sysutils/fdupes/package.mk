# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fdupes"
PKG_VERSION="2.2.1"
PKG_LICENSE="GPL"
PKG_SITE="http://premium.caribe.net/~adrian2/fdupes.html"
PKG_URL="https://github.com/adrianlopezroche/fdupes/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A program for identifying or deleting duplicate files residing within specified directories."

makeinstall_target() {
  : # nop
}
