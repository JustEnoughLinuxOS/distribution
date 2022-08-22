# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="splash"
PKG_VERSION="$(date +%Y%m%d)"
PKG_ARCH="any"
PKG_LICENSE="apache2"
PKG_SITE=""
PKG_URL=""
PKG_LONGDESC="Boot splash screens"
PKG_TOOLCHAIN="manual"

make_target() {
 :
}

makeinstall_target() {
  mkdir -p ${INSTALL}/splash
  find_file_path splash/splash.conf && cp ${FOUND_PATH} ${INSTALL}/splash
  find_file_path "splash/splash-*.png" && cp ${FOUND_PATH} ${INSTALL}/splash
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config/splash
  find_file_path "splash/splash-*.png" && cp ${FOUND_PATH} ${INSTALL}/usr/config/splash
}
