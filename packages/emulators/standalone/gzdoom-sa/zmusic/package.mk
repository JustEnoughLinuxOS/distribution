# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)
# Copyright (C) 2023-present Fewtarius

PKG_NAME="zmusic"
PKG_VERSION="d8e6e28879ee97d00ce0eb9ad13ba462d85faf29"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/coelckers/ZMusic"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="GZDoom's music system as a standalone library"
GET_HANDLER_SUPPORT="git"
PKG_TOOLCHAIN="cmake-make"

make_target() {
  mkdir ${PKG_BUILD}/build_target
  cd ${PKG_BUILD}/build_target
  cmake -DCMAKE_BUILD_TYPE=Release ..
  cmake --build .
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/{lib,include}
  cp -f ${PKG_BUILD}/build_target/source/libzmusic* ${SYSROOT_PREFIX}/usr/lib/
  cp -f ${PKG_BUILD}/include/zmusic.h ${SYSROOT_PREFIX}/usr/include
}
