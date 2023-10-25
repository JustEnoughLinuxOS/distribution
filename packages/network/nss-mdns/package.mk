# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="nss-mdns"
PKG_VERSION="0.15.1"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lathiat/nss-mdns"
PKG_URL="https://github.com/lathiat/nss-mdns/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain avahi"
PKG_LONGDESC="A plugin for nss to allow name resolution via Multicast DNS."
PKG_TOOLCHAIN="autotools"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/etc
  cp ${PKG_DIR}/config/nsswitch.conf ${INSTALL}/etc/nsswitch.conf
}
