# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius

PKG_NAME="mupen64plus-nx"
PKG_VERSION="9f0849454dee17e66099ef8cdf8d53a86a3ade02"
PKG_SHA256="7fe742f5dd47bc5b0c354630b33f81981e76dc0f6d4f2a746b298fc3ac440502"
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
