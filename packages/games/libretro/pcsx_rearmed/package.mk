# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020 Trond Haugland (trondah@gmail.com)

PKG_NAME="pcsx_rearmed"
PKG_VERSION="e09212db7aff5064a7eaaa9008f8c69d465c54f7"
PKG_SHA256="5bfb9cf2780e91741a8b7f5ae776e5bcca2ca0c5136c05f93df7198f2ec3ab95"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="ARM optimized PCSX fork"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="+speed -gold"
PKG_PATCH_DIRS+="${DEVICE}"

if [ "${ARCH}" = "arm" ]
then
 make -f Makefile.libretro clean && make -f Makefile.libretro GIT_VERSION=${PKG_VERSION} PKG_MAKE_OPTS_TARGET+=" platform=rg552"
else
  make_target() {
    :
  }
fi

makeinstall_target() {
  INSTALLTO="/usr/lib/libretro/"

  mkdir -p ${INSTALL}${INSTALLTO}
  cd ${PKG_BUILD}
  if [ "${ARCH}" = "aarch64" ]; then
    cp -vP ${PKG_BUILD}/../../build.${DISTRO}-${DEVICE}.arm/pcsx_rearmed-*/.install_pkg/usr/lib/libretro/pcsx_rearmed_libretro.so ${INSTALL}${INSTALLTO}
  else
    cp pcsx_rearmed_libretro.so ${INSTALL}${INSTALLTO}
  fi
}
