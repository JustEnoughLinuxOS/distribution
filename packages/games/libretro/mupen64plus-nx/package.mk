# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius

PKG_NAME="mupen64plus-nx"
PKG_VERSION="4684cfa56ae7752be284eaaa165c1dc34ec63eb7"
PKG_SHA256="01d63e3f3ecebcb207a5176117f5ad8623c5b3be8c99161695e843e9dea7ee42"
PKG_ARCH="any"
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
  sed -e "s|^GIT_VERSION ?.*$|GIT_VERSION := \" ${PKG_VERSION:0:7}\"|" -i Makefile
  if [[ "${DEVICE}" =~ RG351 ]]
  then
    PKG_MAKE_OPTS_TARGET=" platform=RK3326"
  elif [[ "${DEVICE}" =~ RG552 ]]
  then
    PKG_MAKE_OPTS_TARGET=" platform=RK3399"
  elif [[ "${DEVICE}" =~ RG503 ]] || [[ "${DEVICE}" =~ RG353P ]]
  then
    PKG_MAKE_OPTS_TARGET=" platform=RK3566"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp mupen64plus_next_libretro.so ${INSTALL}/usr/lib/libretro/
}
