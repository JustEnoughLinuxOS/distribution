
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Lakka (https://www.lakka.tv)

PKG_NAME="fake08-lr"
PKG_VERSION="aebd6b9648d1c450910ad79c78f9280dfbd20b25"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/jtothebell/fake-08"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A Pico-8 player/emulator for console homebrew"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C platform/libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v platform/libretro/fake08_libretro.{so,info} ${INSTALL}/usr/lib/libretro/
}
