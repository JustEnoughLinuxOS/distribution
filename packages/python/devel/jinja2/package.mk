# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2022-present Fewtarius
#
PKG_NAME="jinja2"
PKG_VERSION="b08cd4b" # 3.1.2
PKG_LICENSE="BSD"
PKG_SITE="https://pypi.org/project/Jinja2/"
PKG_URL="https://github.com/pallets/jinja.git"
PKG_DEPENDS_HOST="Python3:host setuptools:host MarkupSafe:host"
PKG_LONGDESC="Jinja is a fast, expressive, extensible templating engine."
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  exec_thread_safe python3 setup.py install --prefix=${TOOLCHAIN}
}
