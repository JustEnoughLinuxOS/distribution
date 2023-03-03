# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2020-present Fewtarius

PKG_NAME="poppler"
PKG_VERSION="12853d2"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/freedesktop/poppler"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib libpng libjpeg-turbo fontconfig boost"
PKG_LONGDESC="This is Poppler, a library for rendering PDF files, and examining or modifying their structure."
PKG_TOOLCHAIN="cmake"

pre_configure_target() { 
  PKG_CMAKE_OPTS_TARGET="-DCMAKE_BUILD_TYPE=release \
                       -DENABLE_LIBOPENJPEG=none \
                       -DENABLE_GLIB=ON \
                       -DENABLE_QT5=off \
                       -DENABLE_CPP=off"
                       
  # Disable "gobject-introspection"
  sed -i "s|set(HAVE_INTROSPECTION \${INTROSPECTION_FOUND})|set(HAVE_INTROSPECTION "NO")|g" ${PKG_BUILD}/CMakeLists.txt
}

