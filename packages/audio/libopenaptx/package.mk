# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2022-present Marek Moeckel (wansti@discarded-ideas.org)

PKG_NAME="libopenaptx"
PKG_VERSION="0.2.1"
PKG_SHA256="f13eac1ebfe31a563943cd47819eece1109960e10a1e85c111975bcfd37d5361"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/pali/libopenaptx"
PKG_URL="https://github.com/pali/libopenaptx/releases/download/${PKG_VERSION}/libopenaptx-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="AptX bluetooth audio codec"
PKG_TOOLCHAIN="make"

post_makeinstall_target() {
    cp -P -r ${INSTALL}/usr/local/lib/* ${SYSROOT_PREFIX}/usr/lib/
    cp -P -r ${INSTALL}/usr/local/include/* ${SYSROOT_PREFIX}/usr/include/
    rm -rf ${INSTALL}/usr/local/lib/pkgconfig
}
