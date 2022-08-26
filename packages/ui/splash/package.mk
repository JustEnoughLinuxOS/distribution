# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="splash"
PKG_VERSION="$(date +%Y%m%d)"
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
  if [ -n "${DISPLAY_RESOLUTION}" ]
  then
    convert ${SPLASH} -quality 100 -background black -resize ${DISPLAY_RESOLUTION} -gravity center -extent ${DISPLAY_RESOLUTION} ${1}/splash.png
    convert ${SPLASH} -quality 100 -rotate 270 -background black -resize ${DISPLAY_RESOLUTION} -gravity center -extent ${DISPLAY_RESOLUTION} ${1}/splashl.png
  else
    cp ${SPLASH} ${INSTALL}/splash
    convert ${SPLASH} -quality 100 -rotate 270 -background black ${INSTALL}/splash/splashl.png
  fi
}

makeinstall_init() {
  mkdir -p ${INSTALL}/splash
  mksplash ${INSTALL}/splash
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config/splash
  mksplash ${INSTALL}/usr/config/splash
}
