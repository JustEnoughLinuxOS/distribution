# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="bsnes-mercury-performance"
PKG_VERSION="4ba6d8d88e57d3193d95e1bcf39e8d31121f76d4"
PKG_SHA256="7c0c84fe83c5b0dabcc35cf0195e2e54e5a17a828e40d95cd726ab3979589139"
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
  if [[ "${DEVICE}" =~ RG351 ]]
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

