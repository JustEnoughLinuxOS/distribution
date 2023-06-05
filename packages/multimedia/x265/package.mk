# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="x265"
PKG_VERSION="3.5"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://www.videolan.org/developers/x265.html"
PKG_URL="https://bitbucket.org/multicoreware/x265_git/downloads/${PKG_NAME}_${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="x265 is a H.265/HEVC video encoder application library"
PKG_TOOLCHAIN="make"

if [ "${TARGET_ARCH}" = "x86_64" ]; then
  PKG_DEPENDS_TARGET+=" nasm:host"
fi


pre_configure_target() {
  LDFLAGS="${LDFLAGS} -ldl"

    # custom cmake build to override the LOCAL_CC/CXX
  cp ${CMAKE_CONF} cmake-x265.conf

  echo "SET(CMAKE_C_COMPILER   ${CC})"  >> cmake-x265.conf
  echo "SET(CMAKE_CXX_COMPILER ${CXX})" >> cmake-x265.conf

  cmake -DCMAKE_TOOLCHAIN_FILE=cmake-x265.conf -G "Unix Makefiles" ./source
}