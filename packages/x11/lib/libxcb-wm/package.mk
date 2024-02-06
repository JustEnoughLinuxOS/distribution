# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libxcb-wm"
PKG_VERSION="0.4.2"

PKG_LICENSE="OSS"
PKG_SITE="https://wayland.freedesktop.org/"
PKG_URL="https://gitlab.freedesktop.org/xorg/lib/libxcb-wm/-/archive/xcb-util-wm-${PKG_VERSION}/${PKG_NAME}-xcb-util-wm-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libxcb util-macros xorgproto"
PKG_LONGDESC="Reference implementation of a Wayland compositor"
PKG_TOOLCHAIN="autotools"
