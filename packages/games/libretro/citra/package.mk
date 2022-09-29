# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="citra"
PKG_VERSION="70bf7d8a63b0b501e8f5cff89a86a3e2d4083aa0"
PKG_REV="1"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/citra"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain boost"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Citra - Nintendo 3DS emulator for libretro"
PKG_TOOLCHAIN="make"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

pre_make_target() {

  cd ${PKG_BUILD}
  if [ -e "CMakeLists.txt" ]
  then
    rm CMakeLists.txt
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp citra_libretro.so $INSTALL/usr/lib/libretro/
}
