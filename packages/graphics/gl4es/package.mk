# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)
# Copyright (C) 2023-present Fewtarius

PKG_NAME="gl4es"
PKG_LICENSE="GPL"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain ${OPENGLES}"
PKG_LONGDESC="OpenGL 2.x functionality for GLES2.0 accelerated Hardware"
PKG_TOOLCHAIN="cmake-make"

case ${DEVICE} in
  S922X)
    PKG_SITE="https://github.com/JohnnyonFlame/gl4es"
    PKG_URL="${PKG_SITE}.git"
    PKG_VERSION="17a7876ae76eb7b50ff375d80abd35018e58a50d"
    PKG_GIT_CLONE_BRANCH="ge2d"
  ;;
  *)
    PKG_SITE="https://github.com/ptitSeb/gl4es"
    PKG_URL="${PKG_SITE}.git"
    PKG_VERSION="22eaac79757b0e4fe011deef9cc0596ba35c22b0"
  ;;
esac


pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET=" -DGBM=ON -DCMAKE_BUILD_TYPE=Release "
  if [ ! "${DISPLAYSERVER}" = "x11" ]
  then
    PKG_CMAKE_OPTS_TARGET+=" -DNOX11=ON"
  else
    PKG_DEPENDS_TARGET+=" libX11"
  fi
    PKG_CMAKE_OPTS_TARGET+=" -DGLX_STUBS=ON -DEGL_WRAPPER=ON -DGBM=ON"
}
