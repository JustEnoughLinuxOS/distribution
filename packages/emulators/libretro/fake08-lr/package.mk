
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Lakka (https://www.lakka.tv)

PKG_NAME="fake08-lr"
PKG_VERSION="eff624cf155018642e598709bdffe5b3feb9bd2c"
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
