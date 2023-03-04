# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present Fewtarius
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="lutris-wine"
PKG_VERSION="7.2-2"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lutris/wine"
PKG_URL="${PKG_SITE}/archive/refs/tags/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain bison flex lutris-wine:host"
PKG_DEPENDS_HOST="toolchain bison:host flex:host"
PKG_TOOLCHAIN="configure"

pre_configure_host() {
  PKG_CONFIGURE_OPTS_HOST+=" --enable-win64 --disable-tests"
}

pre_configure_target() {
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-win64 --disable-tests --with-wine-tools=${TOOLCHAIN}/wine"
}

make_host() {
  make -C ${PKG_BUILD}/.${HOST_NAME}
  make -C ${PKG_BUILD}/.${HOST_NAME}/tools
  make -C ${PKG_BUILD}/.${HOST_NAME}/tools/sfnt2fon
  make -C ${PKG_BUILD}/.${HOST_NAME}/tools/widl
  make -C ${PKG_BUILD}/.${HOST_NAME}/tools/winebuild
  make -C ${PKG_BUILD}/.${HOST_NAME}/tools/winegcc
  make -C ${PKG_BUILD}/.${HOST_NAME}/tools/wmc
  make -C ${PKG_BUILD}/.${HOST_NAME}/tools/wrc
}

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/wine/tools
  cp -rf ${PKG_BUILD}/.${HOST_NAME}/tools/* ${TOOLCHAIN}/wine/tools
}
