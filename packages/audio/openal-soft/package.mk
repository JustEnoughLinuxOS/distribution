# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="openal-soft"
PKG_VERSION="d441125"
PKG_LICENSE="GPL"
PKG_SITE="http://www.openal.org/"
PKG_URL="https://github.com/kcat/openal-soft/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib"
PKG_LONGDESC="OpenAL Soft is a software implementation of the OpenAL 3D audio API."

PKG_CMAKE_OPTS_TARGET="-DALSOFT_BACKEND_OSS=off \
                       -DALSOFT_BACKEND_PULSEAUDIO=off \
                       -DALSOFT_BACKEND_WAVE=off \
                       -DALSOFT_EXAMPLES=off \
                       -DALSOFT_UTILS=off"

