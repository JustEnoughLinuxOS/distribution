# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="squirreljme"
PKG_VERSION="fd13ff92e858436fa76e6786771ed1cd7b7dad55"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/SquirrelJME/SquirrelJME"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="SquirrelJME - a java system emulator"
PKG_TOOLCHAIN="make"

pre_make_target() {

  cd ${PKG_BUILD}/ratufacoat
  rm CMakeLists.txt
  mv makefilelibretro Makefile
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp squirreljme_libretro.so $INSTALL/usr/lib/libretro/
  cp squirreljme_libretro.info $INSTALL/usr/lib/libretro/
}
