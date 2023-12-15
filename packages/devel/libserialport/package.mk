# SPDX-License-Identifier: GPL-2.0

PKG_NAME="libserialport"
PKG_VERSION="fd20b0fc5a34cd7f776e4af6c763f59041de223b"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/sigrokproject/libserialport"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A minimal, cross-platform shared library written in C that is intended to take care of the OS-specific details when writing software that uses serial ports."
PKG_TOOLCHAIN="make"

make_target() {
  cd ${PKG_BUILD}

  ./autogen.sh
  ./configure --host=${TARGET_NAME} --with-sysroot=${SYSROOT_PREFIX} --prefix=/usr
}
