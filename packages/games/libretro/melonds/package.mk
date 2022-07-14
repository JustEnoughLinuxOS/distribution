# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="melonds"
PKG_VERSION="e93ec3e462d3dfc1556781510a3cee113f02abb2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://git.libretro.com/libretro/melonDS"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="MelonDS - Nintendo DS emulator for libretro"
PKG_TOOLCHAIN="make"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

pre_make_target() {

  cd ${PKG_BUILD}
  rm CMakeLists.txt
  
  if [[ "${DEVICE}" =~ RG351 ]]
  then
    PKG_MAKE_OPTS_TARGET=" platform=odroidgoa"
  elif [[ "${DEVICE}" =~ RG552 ]]
  then
    PKG_MAKE_OPTS_TARGET=" platform=RK3399"
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp melonds_libretro.so $INSTALL/usr/lib/libretro/
}
