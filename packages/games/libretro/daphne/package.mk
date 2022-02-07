# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="daphne"
PKG_VERSION="0a7e6f0fda1348144369ce0a889876df60263e8f"
PKG_SHA256="49a5c0310e769f389e5d4ce0bc082f89c7eafa8eef8d05cc0d00ebe71c7e5b14"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://github.com/libretro/daphne"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="This is a Daphne core"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp daphne_libretro.so $INSTALL/usr/lib/libretro/
}

