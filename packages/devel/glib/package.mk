# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="glib"
PKG_VERSION="2.78.3"
PKG_LICENSE="LGPL"
PKG_SITE="https://www.gtk.org/"
PKG_URL="https://download.gnome.org/sources/glib/$(get_pkg_version_maj_min)/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="libffi:host pcre2:host Python3:host meson:host ninja:host"
PKG_DEPENDS_TARGET="toolchain pcre2 zlib libffi Python3:host util-linux"
PKG_LONGDESC="A library which includes support routines for C such as lists, trees, hashes, memory allocation."

PKG_MESON_OPTS_HOST="-Ddefault_library=shared \
                     -Dinstalled_tests=false \
                     -Dlibmount=disabled \
                     -Dtests=false"

PKG_MESON_OPTS_TARGET="-Ddefault_library=shared \
                       -Dinstalled_tests=false \
                       -Dselinux=disabled \
                       -Dxattr=true \
                       -Dgtk_doc=false \
                       -Dman=false \
                       -Ddtrace=false \
                       -Dsystemtap=false \
                       -Dbsymbolic_functions=true \
                       -Dforce_posix_threads=true \
                       -Dtests=false"

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin
  rm -rf ${INSTALL}/usr/lib/gdbus-2.0
  rm -rf ${INSTALL}/usr/lib/glib-2.0
  rm -rf ${INSTALL}/usr/lib/installed-tests
  rm -rf ${INSTALL}/usr/share

  sed -e "s#bindir=\${prefix}/bin#bindir=${TOOLCHAIN}/bin#" -i "${SYSROOT_PREFIX}/usr/lib/pkgconfig/"{gio,glib}-2.0.pc
}
