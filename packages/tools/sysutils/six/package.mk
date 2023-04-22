# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="six"
PKG_VERSION="3b7efbcca41857da03fb01f004ccc425ab82dfbf"
PKG_LICENSE="OSS"
PKG_SITE="https://github.com/benjaminp/six"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 distutilscross:host"
PKG_LONGDESC="Python 2 and 3 compatibility library "
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

post_makeinstall_target() {
  find ${INSTALL}/usr/lib/python*/site-packages/  -name "*.py" -exec rm -rf {} ";"
}
