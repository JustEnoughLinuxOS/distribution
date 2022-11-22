# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2022-present Marek Moeckel (wansti@discarded-ideas.org)

PKG_NAME="libldac"
PKG_VERSION="fbffba45d15d959da6ee04eafe14c0d4721f6030"
PKG_LICENSE="Apache2"
PKG_SITE="https://github.com/EHfive/ldacBT"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="LDAC bluetooth audio codec"
PKG_TOOLCHAIN="cmake-make"
GET_HANDLER_SUPPORT="git"

post_makeinstall_target() {
    cp -P -r ${INSTALL}/usr/lib/* ${SYSROOT_PREFIX}/usr/lib/
    cp -P -r ${INSTALL}/usr/include/* ${SYSROOT_PREFIX}/usr/include/
    rm -rf ${INSTALL}/usr/lib/pkgconfig
}
