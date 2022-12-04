################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#      Copyright (C) 2020      351ELEC team (https://github.com/fewtarius/351ELEC)
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="mame2015"
PKG_VERSION="2599c8aeaf84f62fe16ea00daa460a19298c121c"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2015-libretro"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="libretro"
PKG_SHORTDESC="Late 2014/Early 2015 version of MAME (0.160-ish) for libretro. Compatible with MAME 0.160 romsets."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-lto"

pre_make_target() {
  export REALCC=$CC
  export CC=$CXX
  export LD=$CXX
}

pre_configure_target() {
  case ${ARCH} in
    arm|aarch64)
      PKG_MAKE_OPTS_TARGET=" platform=armv8-neon-hardfloat-cortex-a53"
      sed -i 's/LDFLAGS += -Wl,--fix-cortex-a8 -Wl,--no-as-needed//g' Makefile
      sed -i 's/CCOMFLAGS += -mstructure-size-boundary=32//g' Makefile
    ;;
  esac
}

makeinstall_target() {
  case ${ARCH} in
    arm|aarch64)
      aarch64-linux-gnu-strip -s *.so
    ;;
  esac
  mkdir -p $INSTALL/usr/lib/libretro
  cp mame*_libretro.so $INSTALL/usr/lib/libretro/
}
