# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="bsnes-mercury-performance"
PKG_VERSION="fb9a41fe9bc230a07c4506cad3cbf21d3fa635b4"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/bsnes-mercury"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="libretro"
PKG_SHORTDESC="BSNES Super Nintendo Libretro Core"
PKG_IS_ADDON="no"
PKG_TOOLCHAIN="make"
PKG_AUTORECONF="no"

pre_make_target() {
  if [[ "${DEVICE}" =~ RG351 ]] || [[ "${DEVICE}" =~ RGB20S ]]
  then
    PKG_MAKE_OPTS_TARGET+=" platform=RK3326"
  elif [[ "${DEVICE}" =~ RG503 ]] || [[ "${DEVICE}" =~ RG353P ]]
  then
    PKG_MAKE_OPTS_TARGET+=" platform=RK3566"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=${DEVICE}"
  fi
}

make_target() {
  make PROFILE=performance
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp bsnes_mercury_performance_libretro.so $INSTALL/usr/lib/libretro/
}

