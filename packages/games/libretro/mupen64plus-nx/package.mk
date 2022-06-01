# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius

PKG_NAME="mupen64plus-nx"
PKG_VERSION="9beacb26c543cc88c57ed96ca0a72c1925827870"
PKG_SHA256="a4c39df3c0350d93471e00e9b82bc7284d956e302a94bde64c5e0a1aba653314"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mupen64plus-libretro-nx"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain nasm:host ${OPENGLES}"
PKG_SECTION="libretro"
PKG_SHORTDESC="mupen64plus NX"
PKG_LONGDESC="mupen64plus NX"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-lto"

PKG_PATCH_DIRS+="${DEVICE}"

pre_configure_target() {
  sed -e "s|^GIT_VERSION ?.*$|GIT_VERSION := \" ${PKG_VERSION:0:7}\"|" -i Makefile
  if [[ "${DEVICE}" =~ RG351 ]]
  then
    PKG_MAKE_OPTS_TARGET=" platform=RK3326"
  elif [[ "${DEVICE}" =~ RG552 ]]
  then
    PKG_MAKE_OPTS_TARGET=" platform=RK3399"
  elif [[ "${DEVICE}" =~ RG503 ]]
  then
    PKG_MAKE_OPTS_TARGET=" platform=RK3566"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp mupen64plus_next_libretro.so ${INSTALL}/usr/lib/libretro/
}
