# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="libp11-kit"
PKG_VERSION="3f6233d70ed81fdbc81b9bff345ea90ec2496b3b"
PKG_LICENSE="libp11-kit"
PKG_SITE="https://github.com/p11-glue/p11-kit"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="p11-kit aims to solve problems with coordinating the use of PKCS 11 by different components or libraries. "

PKG_MESON_OPTS_TARGET+=" -Dtest=false"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib
  cp -rf ${PKG_BUILD}/.${TARGET_NAME}/p11-kit/libp11-kit.so* ${INSTALL}/usr/lib/
}
