# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="libthai"
PKG_VERSION="0.1.29"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/tlwg/libthai"
PKG_URL="${PKG_SITE}/releases/download/v${PKG_VERSION}/libthai-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libtool libdatrie"
PKG_BUILD_FLAGS="+pic"
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET=" --disable-dict --disable-doxygen-doc"

pre_configure_target() {
cd ${PKG_BUILD}
  ./configure --disable-dict --disable-doxygen-doc
}


