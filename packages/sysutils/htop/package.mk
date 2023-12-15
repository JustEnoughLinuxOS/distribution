# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="htop"
PKG_VERSION="f55b7a6e1d2625be51e95c13da52d68b80071271" # 3.2.2
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/htop-dev/htop"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_LONGDESC="An interactive process viewer for Unix."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-unicode \
                           HTOP_NCURSES_CONFIG_SCRIPT=ncurses6-config"

