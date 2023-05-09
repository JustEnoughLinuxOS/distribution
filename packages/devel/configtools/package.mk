# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023-present Fewtarius

PKG_NAME="configtools"
PKG_VERSION="63acb96f92473ceb5e21d873d7c0aee266b3d6d3"
PKG_LICENSE="GPL"
PKG_SITE="http://git.savannah.gnu.org/cgit/config.git"
PKG_URL="http://git.savannah.gnu.org/cgit/config.git/snapshot/config-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST=""
PKG_LONGDESC="configtools"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/configtools
  cp config.* ${TOOLCHAIN}/configtools
}
