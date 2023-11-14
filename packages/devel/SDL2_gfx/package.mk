# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="SDL2_gfx"
PKG_VERSION="29927b3"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/jjYBdx4IL/SDL2_gfx"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain SDL2"
PKG_LONGDESC="SDL_image is an image file loading library. "
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET=" --disable-mmx"

pre_configure_target() {
  export CC=${CC}
}

