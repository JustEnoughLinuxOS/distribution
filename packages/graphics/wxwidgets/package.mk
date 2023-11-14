# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="wxwidgets"
PKG_VERSION="b958f602fa1cdd77ee3d6a77537d4d3850d8230a"
PKG_LICENSE="wxWindows Library Licence"
PKG_SITE="https://github.com/wxWidgets/wxWidgets"
PKG_URL="${PKG_SITE}.git"
PKG_GIT_CLONE_BRANCH="3.2"
PKG_DEPENDS_TARGET="toolchain zlib libpng libjpeg-turbo gdk-pixbuf gtk3 libaio"
PKG_LONGDESC="wxWidgets is a free and open source cross-platform C++ framework for writing advanced GUI applications using native controls."
PKG_BUILD_FLAGS="+pic"

pre_configure_target() {
  LDFLAGS="${LDFLAGS} -fPIC"
  CXXFLAGS="${CXXFLAGS} -fPIC"
}

post_install() {
  cp ${PKG_BUILD}/.${TARGET_NAME}/lib/wx/config/gtk3-unicode-3.2 ${SYSROOT_PREFIX}/usr/bin/wx-config
  sed -i 's#^prefix=.*#prefix='${SYSROOT_PREFIX}/usr'#' ${SYSROOT_PREFIX}/usr/bin/wx-config
  sed -i 's#^exec_prefix=.*#exec_prefix='${SYSROOT_PREFIX}/usr'#' ${SYSROOT_PREFIX}/usr/bin/wx-config
}
