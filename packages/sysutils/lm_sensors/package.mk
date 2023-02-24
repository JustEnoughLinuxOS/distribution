# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lm_sensors"
PKG_VERSION="42f240d"
PKG_ARCH="arm x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://secure.netroedge.com/~lm78/"
PKG_URL="https://github.com/lm-sensors/lm-sensors.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Provides user-space support for the hardware monitoring drivers."

PKG_MAKEINSTALL_OPTS_TARGET="PREFIX=/usr"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET="PREFIX=/usr CC=${CC} AR=$AR"

  export CFLAGS="${TARGET_CFLAGS}"
  export CPPFLAGS="${TARGET_CPPFLAGS}"
}

