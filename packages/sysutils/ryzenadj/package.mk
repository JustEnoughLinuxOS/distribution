# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="ryzenadj"
PKG_VERSION="32c89f84ac218d64e424a2aafc1151601d2520be"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/FlyGoat/RyzenAdj"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain pciutils systemd"
PKG_LONGDESC="Adjust power management settings for Ryzen Mobile Processors."
PKG_BUILD_FLAGS="+pic"

pre_configure_target() {
  export TARGET_LDFLAGS="${TARGET_LDFLAGS} -ludev"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib
  cp libryzenadj.so ${INSTALL}/usr/lib
  mkdir -p ${INSTALL}/usr/bin 
  cp ryzenadj ${INSTALL}/usr/bin
}
