# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wayland-protocols"
PKG_VERSION="cc0cd4addf68df7a14bf7f4c9c2daa6489fc20d7"
PKG_LICENSE="OSS"
PKG_SITE="https://gitlab.freedesktop.org/wayland/wayland-protocols"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain wayland:host"
PKG_LONGDESC="Specifications of extended Wayland protocols"

PKG_MESON_OPTS_TARGET="-Dtests=false"

post_makeinstall_target() {
  safe_remove ${INSTALL}
}
