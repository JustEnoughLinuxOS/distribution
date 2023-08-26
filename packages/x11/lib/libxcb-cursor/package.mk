# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023 Fewtarius

PKG_NAME="libxcb-cursor"
PKG_VERSION="103bccad6f4a421ede6a0ef2eecc2749ff9be083"
PKG_LICENSE="OSS"
PKG_SITE="https://gitlab.freedesktop.org/xorg/lib/libxcb-cursor"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain xcb-proto libxcb xcb-util-renderutil xcb-util-image"
PKG_LONGDESC="Port of libXcursor."
PKG_BUILD_FLAGS="+pic"
PKG_TOOLCHAIN="autotools"
