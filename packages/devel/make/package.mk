# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023-present Fewtarius

PKG_NAME="make"
PKG_VERSION="4.4.1"
PKG_LICENSE="GPLv3"
PKG_SITE="https://www.gnu.org/software/make/"
PKG_URL="http://ftpmirror.gnu.org/make/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST=""
PKG_LONGDESC="Utility to maintain groups of programs."
PKG_BUILD_FLAGS="+local-cc"

post_makeinstall_host() {
  ln -sf make ${TOOLCHAIN}/bin/gmake
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/share/locale
}
