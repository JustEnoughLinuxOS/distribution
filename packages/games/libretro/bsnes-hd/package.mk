# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2023-present Daedalia (https://github.com/daedalia)

PKG_NAME="bsnes-hd"
PKG_VERSION="04821703aefdc909a4fd66d168433fcac06c2ba7"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/DerKoun/bsnes-hd"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="libretro"
PKG_SHORTDESC="bsnes-hd is a fork of bsnes that adds HD video features such as widescreen, HD Mode 7 and true color"

PKG_IS_ADDON="no"
PKG_TOOLCHAIN="make"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_TARGET+=" -C bsnes target=libretro compiler=${TARGET_NAME}-g++"

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp bsnes/out/bsnes_hd_beta_libretro.so $INSTALL/usr/lib/libretro/
}

