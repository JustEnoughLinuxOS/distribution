# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="ecwolf_libretro"
PKG_VERSION="f098da0d003c4780adf6a9503801081f1f25cc27"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/ecwolf"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain SDL2 SDL2_mixer SDL2_net libjpeg-turbo bzip2"
PKG_SHORTDESC="ECWolf is a port of the Wolfenstein 3D engine based of Wolf4SDL."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C src/libretro"

pre_make_target() {
  cd ${PKG_BUILD}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp src/libretro/ecwolf_libretro.so ${INSTALL}/usr/lib/libretro/
}
