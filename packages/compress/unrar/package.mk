# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="unrar"
PKG_VERSION="df15c8c3c9f4105d3501bc477e80ac6b8e227677"
PKG_LICENSE="free"
PKG_SITE="http://www.rarlab.com"
PKG_URL="https://github.com/pmachapman/unrar.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="unrar extract, test and view RAR archives"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="+pic"

make_target() {
  make CXX="${CXX}" \
     CXXFLAGS="${TARGET_CXXFLAGS}" \
     RANLIB="$RANLIB" \
     AR="${AR}" \
     STRIP="${STRIP}" \
     -f makefile unrar

  make clean

  make CXX="${CXX}" \
     CXXFLAGS="${TARGET_CXXFLAGS}" \
     RANLIB="$RANLIB" \
     AR="${AR}" \
     -f makefile lib
}

post_make_target() {
  rm -f libunrar.so
}
