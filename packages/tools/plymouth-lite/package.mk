# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="plymouth-lite"
PKG_VERSION="92b3d5b"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/JustEnoughLinuxOS/plymouth-lite"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_INIT="toolchain ccache:init libpng"
PKG_DEPENDS_TARGET="toolchain libpng"
PKG_LONGDESC="Boot splash screen based on Fedora's Plymouth code"

if [ "$UVESAFB_SUPPORT" = yes ]; then
  PKG_DEPENDS_INIT="$PKG_DEPENDS_INIT v86d:init"
fi

pre_configure_init() {
  # plymouth-lite dont support to build in subdirs
  cd ${PKG_BUILD}
    rm -rf .${TARGET_NAME}-init
}

makeinstall_init() {
  mkdir -p ${INSTALL}/usr/bin
    cp ply-image ${INSTALL}/usr/bin

  mkdir -p ${INSTALL}/splash
  find_file_path splash/splash.conf && cp ${FOUND_PATH} ${INSTALL}/splash
  find_file_path "splash/splash-*.png" && cp ${FOUND_PATH} ${INSTALL}/splash
}

pre_configure_target() {
  # plymouth-lite dont support to build in subdirs
  cd ${PKG_BUILD}
    rm -rf .${TARGET_NAME}-init
}

post_makeinstall_target() {

  mkdir -p ${INSTALL}/usr/config/splash

  find_file_path "splash/splash-*.png" && cp ${FOUND_PATH} ${INSTALL}/usr/config/splash

}
