# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="mupen64plus-nx-lr"
PKG_VERSION="0e1dc5abacf91f1640206d32d18735e82071681e"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mupen64plus-libretro-nx"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain nasm:host"
PKG_SECTION="libretro"
PKG_SHORTDESC="mupen64plus NX"
PKG_LONGDESC="mupen64plus NX"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-lto"

PKG_PATCH_DIRS+="${DEVICE}"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

pre_configure_target() {
  for SOURCE in ${PKG_BUILD}/mupen64plus-rsp-paraLLEl/rsp_disasm.cpp ${PKG_BUILD}/mupen64plus-rsp-paraLLEl/rsp_disasm.hpp
  do
    sed -i '/include <string>/a #include <cstdint>' ${SOURCE}
  done
  sed -e "s|^GIT_VERSION ?.*$|GIT_VERSION := \" ${PKG_VERSION:0:7}\"|" -i Makefile
  sed -i 's/\-O[23]/-Ofast/' ${PKG_BUILD}/Makefile
  case ${DEVICE} in
    RK3*|S922X*)
      PKG_MAKE_OPTS_TARGET=" platform=${DEVICE}"
    ;;
  esac
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp mupen64plus_next_libretro.so ${INSTALL}/usr/lib/libretro/
}
