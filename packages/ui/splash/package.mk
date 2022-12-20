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
  if [ -n "${SPLASH_RESOLUTION}" ]
  then

    # Switch the resolution so the rotated image will scale correctly.
    HRES=$(echo "${SPLASH_RESOLUTION}" | awk 'BEGIN {FS="x"} {print $1}')
    VRES=$(echo "${SPLASH_RESOLUTION}" | awk 'BEGIN {FS="x"} {print $2}')
    if [ "${VRES}" -gt "${HRES}" ]
    then
      convert ${SPLASH} -quality 100 -background black -resize ${VRES}x${HRES} -gravity center -extent ${VRES}x${HRES} ${1}/splash.png
    else
      convert ${SPLASH} -quality 100 -background black -resize ${SPLASH_RESOLUTION} -gravity center -extent ${SPLASH_RESOLUTION} ${1}/splash.png
    fi
    convert ${SPLASH} -rotate 90 -quality 100 -background black -resize ${SPLASH_RESOLUTION} -gravity center -extent ${SPLASH_RESOLUTION} ${1}/splash_90.png
    convert ${SPLASH} -rotate 180 -quality 100 -background black -resize ${SPLASH_RESOLUTION} -gravity center -extent ${SPLASH_RESOLUTION} ${1}/splash_180.png
    convert ${SPLASH} -rotate 270 -quality 100 -background black -resize ${SPLASH_RESOLUTION} -gravity center -extent ${SPLASH_RESOLUTION} ${1}/splash_270.png
  else
    cp ${SPLASH} ${1}
    convert ${SPLASH} -rotate 90 -quality 100 -background black -gravity center ${1}/splash_90.png
    convert ${SPLASH} -rotate 180 -quality 100 -background black -gravity center ${1}/splash_180.png
    convert ${SPLASH} -rotate 270 -quality 100 -background black -gravity center ${1}/splash_270.png
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
