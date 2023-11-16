# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="rdfind"
PKG_VERSION="1.6.0"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/pauldreik/rdfind"
PKG_URL="${PKG_SITE}/archive/refs/tags/releases/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="A command line tool that finds duplicate files."
PKG_DEPENDS_HOST="nettle:host"
PKG_TOOLCHAIN="autotools"

pre_configure_host() {
  export LDFLAGS="${LDFLAGS} -L${TOOLCHAIN}/lib64"
}
