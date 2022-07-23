# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="libvdpau"
PKG_VERSION="1.2"
PKG_LICENSE="MIT"
PKG_SITE="https://wiki.freedesktop.org/www/Software/VDPAU/"
PKG_URL="https://secure.freedesktop.org/~aplattner/vdpau/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libX11 xorgproto libXext"
PKG_LONGDESC="VDPAU is the Video Decode and Presentation API for UNIX."

PKG_CONFIGURE_OPTS_TARGET="--enable-dri2 \
                           --disable-documentation \
                           --with-module-dir=/usr/lib/vdpau"
