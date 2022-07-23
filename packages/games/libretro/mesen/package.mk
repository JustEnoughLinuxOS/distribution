# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="mesen"
PKG_VERSION="bb9ea02eba28682986044a6f49329ec533aa26ba"
PKG_SHA256="ff1b5b567d5e11c1ea63c2d58b1e7c8d7b673bb425908f115f516b1faa446e5f"
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
