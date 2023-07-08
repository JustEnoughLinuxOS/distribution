# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present Fewtarius

PKG_NAME="pyelftools"
PKG_VERSION="15f032b"
PKG_ARCH="any"
PKG_LICENSE="public domain"
PKG_SITE="https://github.com/eliben/pyelftools"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain Python3"
PKG_LONGDESC="A pure-Python library for parsing and analyzing ELF files and DWARF debugging information."
PKG_TOOLCHAIN="manual"

pre_make_target() {
  export PYTHONXCPREFIX="${SYSROOT_PREFIX}/usr"
  export LDFLAGS="${LDFLAGS} -L${SYSROOT_PREFIX}/usr/lib -L${SYSROOT_PREFIX}/lib"
  export LDSHARED="${CC} -shared"
}

make_target() {
  python3 setup.py build --cross-compile
}

makeinstall_target() {
  python3 setup.py install --root=${INSTALL} --prefix=/usr
}
