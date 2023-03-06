# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present Fewtarius

PKG_NAME="minivmac"
PKG_VERSION="7a774cd"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/libretro-minivmac"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="libretro"
PKG_SHORTDESC="Virtual Macintosh"
PKG_TOOLCHAIN="make"


makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp ${PKG_BUILD}/minivmac_libretro.so ${INSTALL}/usr/lib/libretro/
}
