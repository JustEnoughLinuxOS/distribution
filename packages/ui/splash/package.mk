# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="splash"
PKG_VERSION=""
PKG_ARCH="any"
PKG_LICENSE="apache2"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain imagemagick"
PKG_LONGDESC="Boot splash screens"
PKG_TOOLCHAIN="manual"

make_init() {
  :
}

make_target() {
  :
}

mksplash() {
  SPLASH="${ROOT}/distributions/${DISTRO}/splash/splash.png"
  cp ${SPLASH} ${1}
  convert ${SPLASH} -rotate 90 -quality 100 -background black -gravity center ${1}/splash_90.png
  convert ${SPLASH} -rotate 180 -quality 100 -background black -gravity center ${1}/splash_180.png
  convert ${SPLASH} -rotate 270 -quality 100 -background black -gravity center ${1}/splash_270.png
}

makeinstall_init() {
  mkdir -p ${INSTALL}/splash
  mksplash ${INSTALL}/splash
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config/splash
  mksplash ${INSTALL}/usr/config/splash
}
