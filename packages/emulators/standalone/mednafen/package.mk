# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present asoderq/sydarn2 (https://github.com/asoderq)

PKG_NAME="mednafen"
PKG_VERSION="1.31.0-UNSTABLE"
PKG_LICENSE="mixed"
PKG_SITE="https://mednafen.github.io/"
PKG_URL="${PKG_SITE}/releases/files/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain SDL2 libegl"
PKG_TOOLCHAIN="configure"

pre_configure_target() {

# unsupported modules
DISABLED_MODULES+=" --disable-apple2 \
		    --disable-sasplay \
                    --disable-ssfplay"

case ${DEVICE} in
  RK3326)
    DISABLED_MODULES+="   --disable-snes \
			 --disable-ss \
			 --disable-psx"
  ;;
  RK356*)
    DISABLED_MODULES+="  --disable-ss \
                         --disable-psx"
  ;;
esac

PKG_CONFIGURE_OPTS_TARGET="${DISABLED_MODULES}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -rf ${PKG_BUILD}/.${TARGET_NAME}/src/mednafen ${INSTALL}/usr/bin
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin

  chmod +x ${INSTALL}/usr/bin/start_mednafen.sh

  mkdir -p ${INSTALL}/usr/config/${PKG_NAME}
  if [ -d ${PKG_DIR}/config/${DEVICE} ]; then
    cp ${PKG_DIR}/config/${DEVICE}/* ${INSTALL}/usr/config/${PKG_NAME}
  else
    cp ${PKG_DIR}/config/common/* ${INSTALL}/usr/config/${PKG_NAME}
  fi
}

post_install() {
    case ${DEVICE} in
      S922X)
        LIBEGL="export SDL_VIDEO_GL_DRIVER=\/usr\/lib\/egl\/libGL.so.1 SDL_VIDEO_EGL_DRIVER=\/usr\/lib\/egl\/libEGL.so.1"
      ;;
      *)
        LIBEGL=""
      ;;
    esac
    sed -e "s/@LIBEGL@/${LIBEGL}/g" \
        -i ${INSTALL}/usr/bin/start_mednafen.sh
}
