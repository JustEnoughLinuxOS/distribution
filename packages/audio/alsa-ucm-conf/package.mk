# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="alsa-ucm-conf"
PKG_VERSION="0b2aa9d22f8897cbe68f1aa2ffe437ad3194ec4b"
PKG_LICENSE="GPL"
PKG_SITE="http://www.alsa-project.org/"
PKG_URL="https://github.com/alsa-project/alsa-ucm-conf.git"
GET_HANDLER_SUPPORT="git"
PKG_DEPENDS_TARGET="toolchain alsa-lib"
PKG_LONGDESC="ALSA Use Case Manager configuration"
PKG_TOOLCHAIN="manual"

make_target() {
  echo
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/alsa
  cp -PR $PKG_BUILD/* $INSTALL/usr/share/alsa
}
