# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="minivmac-lr"
PKG_VERSION="45edc82baae906b90b67cce66761557923a6ba75"
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
