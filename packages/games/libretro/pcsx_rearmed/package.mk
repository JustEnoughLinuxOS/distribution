# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020 Trond Haugland (trondah@gmail.com)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="pcsx_rearmed"
PKG_VERSION="185a13abc899e25fe7b8048b21a3b1dc1a7259b9"
PKG_SHA256="ec60894f27edacf29258db34da56b2a6ba6f0aabc54dfffddd6d522b1204bec2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="ARM optimized PCSX fork"
PKG_TOOLCHAIN="manual"
PKG_PATCH_DIRS+="${TARGET_ARCH}/${DEVICE}"

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
  ## Install the 64bit core.
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp pcsx_rearmed_libretro.so ${INSTALL}/usr/lib/libretro/
  ## Install the 32bit core.
  cp -vP ${PKG_BUILD}/../../build.${DISTRO}-${DEVICE}.arm/pcsx_rearmed-*/.install_pkg/usr/lib/libretro/pcsx_rearmed_libretro.so ${INSTALL}/usr/lib/libretro/pcsx_rearmed32_libretro.so
}
