# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Team CoreELEC (https://coreelec.org)

PKG_NAME="gperftools"
PKG_VERSION="2.13"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/gperftools/gperftools"
PKG_URL="https://github.com/gperftools/gperftools/archive/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Google Performance Tools"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-minimal --disable-debugalloc --disable-static"
