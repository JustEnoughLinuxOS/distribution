# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="glew-cmake"
PKG_VERSION="2.2.0"
PKG_SHA256="cdd82afba80f7cf34548cf5c902240d6721ec5a27ec9e075851b4a3a79ec6907"
PKG_LICENSE="The OpenGL Extension Wrangler Library"
PKG_SITE="https://github.com/Perlmint/glew-cmake"
PKG_URL="https://github.com/Perlmint/glew-cmake/archive/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libXi glu"
PKG_LONGDESC="The OpenGL Extension Wrangler Library (GLEW) is a cross-platform open-source C/C++ extension loading library."

PKG_CMAKE_OPTS_TARGET="-Dglew-cmake_BUILD_STATIC=off \
                       -DUSE_GLU=on \
                       -DPKG_CONFIG_REPRESENTATIVE_TARGET="libglew_shared" \
                       -DONLY_LIBS=on"
