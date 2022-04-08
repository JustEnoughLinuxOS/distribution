################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2022-present Fewtarius
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="flycast_libretro"
PKG_VERSION="886188804de48a4bd9324046598e8dedfd0d2099"
PKG_SHA256="9e84dcd7efe38198c2b34904f3e0ff44455b1391b1f281fb3ef940e58b113ee3"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/flycast"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ${OPENGLES}"
PKG_LONGDESC="Flycast is a multiplatform Sega Dreamcast emulator "
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-gold"
PKG_PATCH_DIRS+="${DEVICE}"

pre_configure_target() {
  sed -i 's/define CORE_OPTION_NAME "reicast"/define CORE_OPTION_NAME "flycast"/g' core/libretro/libretro_core_option_defines.h 
  PKG_MAKE_OPTS_TARGET="ARCH=${TARGET_ARCH} HAVE_OPENMP=1 GIT_VERSION=${PKG_VERSION:0:7} FORCE_GLES=1 HAVE_LTCG=0"

}

pre_make_target() {
  export BUILD_SYSROOT=${SYSROOT_PREFIX}

  if [[ "${DEVICE}" =~ RG351 ]]
  then
    PKG_MAKE_OPTS_TARGET+=" platform=RG351x"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=${DEVICE}"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp flycast_libretro.so ${INSTALL}/usr/lib/libretro/flycast_libretro_libretro.so
}
