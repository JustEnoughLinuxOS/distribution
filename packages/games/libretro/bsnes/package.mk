# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="bsnes"
PKG_VERSION="eeb14cfc7abd75a01202d5dafb23fc4dcef96a4f"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/bsnes-libretro"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="libretro"
PKG_SHORTDESC="BSNES Super Nintendo Libretro Core"
PKG_IS_ADDON="no"
PKG_TOOLCHAIN="make"
PKG_AUTORECONF="no"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp bsnes_libretro.so ${INSTALL}/usr/lib/libretro/
}

