# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="glu"
PKG_VERSION="9.0.3"
PKG_LICENSE="OSS"
PKG_SITE="https://gitlab.freedesktop.org/mesa/glu/"
PKG_URL="https://mesa.freedesktop.org/archive/glu/glu-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain ${OPENGL}"
PKG_NEED_UNPACK="$(get_pkg_directory mesa)"
PKG_LONGDESC="libglu is the The OpenGL utility library"
