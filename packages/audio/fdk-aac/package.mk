# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="fdk-aac"
PKG_VERSION="2.0.2"
PKG_SHA256="7812b4f0cf66acda0d0fe4302545339517e702af7674dd04e5fe22a5ade16a90"
PKG_LICENSE="Apache2"
PKG_SITE="https://github.com/mstorsjo/fdk-aac"
PKG_URL="https://github.com/mstorsjo/fdk-aac/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="AAC bluetooth audio codec"
PKG_TOOLCHAIN="autotools"

#PKG_CONFIGURE_OPTS_TARGET=""

post_makeinstall_target() {
    cp -P -r ${INSTALL}/usr/lib/* ${SYSROOT_PREFIX}/usr/lib/
    cp -P -r ${INSTALL}/usr/include/* ${SYSROOT_PREFIX}/usr/include/
    rm -rf ${INSTALL}/usr/lib/pkgconfig
}
