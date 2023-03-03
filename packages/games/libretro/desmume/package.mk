# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="desmume"
PKG_VERSION="fb05195a535c834cbb521337b45eb09262f6fdb2"
PKG_LICENSE="GPLv2"
PKG_SITE="https://git.libretro.com/libretro/desmume"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain libpcap"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="DeSmuME - Nintendo DS libretro"
PKG_TOOLCHAIN="make"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi


pre_configure_target() {
  cd ${PKG_BUILD}/desmume/src/frontend/libretro
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp desmume_libretro.so ${INSTALL}/usr/lib/libretro/
}
