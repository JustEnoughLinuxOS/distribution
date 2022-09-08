# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="wxwidgets"
PKG_VERSION="87ad6fa"
PKG_LICENSE="wxWindows Library Licence"
PKG_SITE="https://github.com/wxWidgets/wxWidgets"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain zlib libpng libjpeg-turbo gdk-pixbuf gtk3"
PKG_LONGDESC="wxWidgets is a free and open source cross-platform C++ framework for writing advanced GUI applications using native controls."
PKG_BUILD_FLAGS="+pic"
PKG_GIT_CLONE_BRANCH="WX_3_0_BRANCH"

pre_configure_target() {
  LDFLAGS="${LDFLAGS} -fPIC"
  CXXFLAGS="${CXXFLAGS} -fPIC"
}

post_install() {
  sed -i 's#^prefix=.*#prefix='${SYSROOT_PREFIX}/usr'#' ${SYSROOT_PREFIX}/usr/bin/wx-config
  sed -i 's#^exec_prefix=.*#exec_prefix='${SYSROOT_PREFIX}/usr'#' ${SYSROOT_PREFIX}/usr/bin/wx-config
}
