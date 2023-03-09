# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)
# Copyright (C) 2023-present Fewtarius

PKG_NAME="gl4es"
PKG_VERSION="57240b0f06551a49c94f90abccc54767c738791e"
PKG_SITE="https://github.com/ptitSeb/gl4es"
PKG_LICENSE="GPL"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain ${OPENGLES}"
PKG_LONGDESC="OpenGL 2.x functionality for GLES2.0 accelerated Hardware"
PKG_TOOLCHAIN="cmake-make"

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET=" -DGBM=ON -DCMAKE_BUILD_TYPE=Release "
  if [ ! "${DISPLAYSERVER}" = "x11" ]
  then
    PKG_CMAKE_OPTS_TARGET+=" -DNOX11=1"
  else
    PKG_DEPENDS_TARGET+=" libX11"
  fi
}
