# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2023-present Fewtarius

PKG_NAME="box64"
PKG_VERSION="cabcca2"
PKG_ARCH="aarch64"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/ptitSeb/box64"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain gl4es"
PKG_LONGDESC="Box64 lets you run x86_64 Linux programs (such as games) on non-x86_64 Linux systems, like ARM."
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET+=" -DCMAKE_BUILD_TYPE=Release"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_BUILD}/.${TARGET_NAME}/box64 ${INSTALL}/usr/bin
  cp ${PKG_BUILD}/tests/bash ${INSTALL}/usr/bin/bash-x64

  mkdir -p ${INSTALL}/etc/binfmt.d
  ln -fs /storage/.config/box64.conf ${INSTALL}/etc/binfmt.d/box64.conf

  mkdir ${INSTALL}/usr/config
  touch ${INSTALL}/usr/config/box64.conf
}
