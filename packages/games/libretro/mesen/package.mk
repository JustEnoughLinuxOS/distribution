# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="mesen"
PKG_VERSION="9b412c1533a6d7eec7b2904775cbd26c21f02119"
PKG_SHA256=""
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/Mesen"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Mesen is a cross-platform NES/Famicom emulator for Windows & Linux built in C++ and C#."
PKG_TOOLCHAIN="make"

make_target() {
  make -C Libretro/
}


makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp Libretro/mesen_libretro.so $INSTALL/usr/lib/libretro/
}
