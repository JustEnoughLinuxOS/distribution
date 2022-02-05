# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="alekfull-nx"
PKG_REV="1"
PKG_VERSION="c365f69a9d9ad70e288de0d5c796f19c729c064f"
PKG_ARCH="any"
PKG_LICENSE="unknown"
PKG_SITE="https://github.com/fagnerpc/Alekfull-NX"
PKG_URL="$PKG_SITE.git"
GET_HANDLER_SUPPORT="git"
PKG_SHORTDESC="ALEKFULL NX theme"
PKG_LONGDESC="ALEKFULL NX theme"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/config/emulationstation/themes/$PKG_NAME
  cp -rf * $INSTALL/usr/config/emulationstation/themes/$PKG_NAME
}
