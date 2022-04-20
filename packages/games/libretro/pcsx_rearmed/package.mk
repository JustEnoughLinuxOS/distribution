# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020 Trond Haugland (trondah@gmail.com)

PKG_NAME="pcsx_rearmed"
PKG_VERSION="e24732050e902bd5402b2b7da7c391d2ca8fa799"
PKG_SHA256="96b933eb2877ff224b3b00af0e9f4f3560d3d0b1c0bb18f67060e7e5598c1757"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="ARM optimized PCSX fork"
PKG_TOOLCHAIN="manual"
PKG_PATCH_DIRS+="${DEVICE}"

make_target() {
  cd ${PKG_BUILD}
  if [[ "${DEVICE}" =~ RG351 ]]
  then
    make -f Makefile.libretro GIT_VERSION=${PKG_VERSION} platform=RG351x
  else
    make -f Makefile.libretro GIT_VERSION=${PKG_VERSION} platform=${DEVICE}
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp pcsx_rearmed_libretro.so $INSTALL/usr/lib/libretro/
}
