# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023-present Fewtarius

PKG_NAME="pyelftools"
PKG_VERSION="b5840ce" # 0.30
PKG_LICENSE="public domain"
PKG_SITE="https://github.com/eliben/pyelftools"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_HOST="toolchain Python3:host"
PKG_LONGDESC="A pure-Python library for parsing and analyzing ELF files"
PKG_TOOLCHAIN="manual"

make_host() {
  python3 setup.py build
}

makeinstall_host() {
  exec_thread_safe python3 setup.py install --prefix=${TOOLCHAIN} --skip-build

  # Avoid using full path to python3 that may exceed 128 byte limit.
  # Instead use PATH as we know our toolchain is first.
  sed -e '1 s/^#!.*$/#!\/usr\/bin\/env python3/' -i ${TOOLCHAIN}/bin/meson
}
