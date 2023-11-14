# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fuse-exfat"
PKG_VERSION="0b41c6d"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://github.com/relan/exfat"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain fuse"
PKG_LONGDESC="This project aims to provide a full-featured exFAT file system implementation for GNU/Linux other Unix-like systems as a FUSE module."
PKG_TOOLCHAIN="autotools"
