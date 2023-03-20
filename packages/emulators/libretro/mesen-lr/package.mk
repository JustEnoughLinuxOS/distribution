# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="mesen-lr"
PKG_VERSION="d0a48b6d4eb94fd577487f6285a1d2e8cbf879fb"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/Mesen"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Mesen is a cross-platform NES/Famicom emulator for Windows & Linux built in C++ and C#."
PKG_TOOLCHAIN="make"

make_target() {
  make -C Libretro/
}


makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp Libretro/mesen_libretro.so ${INSTALL}/usr/lib/libretro/
}
