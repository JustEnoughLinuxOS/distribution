# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Matthias Reichl <hias@horus.com>

PKG_NAME="terminus-font"
PKG_MAJOR="4.49"
PKG_MINOR=".1"
PKG_LICENSE="OFL1_1"
PKG_SITE="https://terminus-font.sourceforge.net/"
PKG_URL="https://downloads.sourceforge.net/project/${PKG_NAME}/${PKG_NAME}-${PKG_MAJOR}/${PKG_NAME}-${PKG_MAJOR}${PKG_MINOR}.tar.gz"

PKG_DEPENDS_INIT="toolchain Python3:host"
PKG_DEPENDS_TARGET="toolchain Python3"
PKG_LONGDESC="This package contains the Terminus Font"
PKG_TOOLCHAIN="manual"

pre_configure_init() {
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}-${TARGET}
}

pre_configure_target() {
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}-${TARGET}
}

configure_init() {
  ./configure INT=${TOOLCHAIN}/bin/python3
}

configure_target() {
  ./configure
}

make_init() {
  make all
}

make_target() {
  make all
}

makeinstall_init() {
  mkdir -p ${INSTALL}/usr/share/consolefonts
  cp -rf *.bdf ${INSTALL}/usr/share/consolefonts
  cp -rf *.psf ${INSTALL}/usr/share/consolefonts
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/consolefonts
  cp -rf ${PKG_BUILD}/*.bdf ${INSTALL}/usr/share/consolefonts
  cp -rf ${PKG_BUILD}/*.psf ${INSTALL}/usr/share/consolefonts
}
