# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="librsvg"
PKG_VERSION="2.57.0"
PKG_LICENSE="LGPL-2.1"
PKG_SITE="https://gitlab.gnome.org/GNOME/librsvg"
PKG_URL="https://download.gnome.org/sources/librsvg/${PKG_VERSION:0:4}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain cargo:host gdk-pixbuf pango libcroco"
PKG_LONGDESC="This is librsvg - A small library to render Scalable Vector Graphics (SVG), associated with the GNOME Project."
PKG_TOOLCHAIN="autotools"

pre_configure_target() {
  PKG_CONFIGURE_OPTS_TARGET="ac_cv_path_GDK_PIXBUF_QUERYLOADERS="${SYSROOT_PREFIX}/usr/bin/gdk-pixbuf-query-loaders" \
                            --enable-installed-tests=no \
                            --disable-tools \
                            --enable-introspection=no"
}

pre_make_target() {
  sed -e "s:^GLIB_MKENUMS =.*:GLIB_MKENUMS = ${SYSROOT_PREFIX}/usr/bin/glib-mkenums:g" -i ${PKG_BUILD}/.${TARGET_NAME}/Makefile
}
