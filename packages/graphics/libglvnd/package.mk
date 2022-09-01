# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libglvnd"
PKG_VERSION="1.4.0"
PKG_SHA256="1eb5c2be8d213ad5d31cfb4efbb331d42f3d9f5617c885ce7e89f572ec2bb4b8"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/NVIDIA/libglvnd"
PKG_URL="https://github.com/NVIDIA/libglvnd/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libglvnd is a vendor-neutral dispatch layer for arbitrating OpenGL API calls between multiple vendors."

configure_package() {
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" libX11 libXext xorgproto"
  fi
}

pre_configure_target(){
  if [ ! "${OPENGL}" = "no" ]
  then
    PKG_MESON_OPTS_TARGET+=" -Dgles1=true -Dgles2=true -Degl=true -Dheaders=true"
  fi
    
  if [ "${OPENGLES_SUPPORT}" = "no" ]; then
    PKG_MESON_OPTS_TARGET+=" -Dgles2=false"
  fi
}

