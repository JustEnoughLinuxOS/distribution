# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 0riginally created by Escalade (https://github.com/escalade)
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)
# Copyright (C) 2023-present Fewtarius

PKG_NAME="SDL_sound"
PKG_VERSION="ba43565897dbada7868456cce0a9727271c5d06b"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/icculus/SDL_sound"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain alsa-lib SDL2"
PKG_LONGDESC="SDL_sound library"

PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr \
                           --disable-speex \
                           ac_cv_path_SDL2_CONFIG=${SYSROOT_PREFIX}/usr/bin/sdl2-config"

pre_configure_target() {
  export LDFLAGS="${LDFLAGS} -lm"
}

