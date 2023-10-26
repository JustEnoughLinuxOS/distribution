# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present asoderq/sydarn2 (https://github.com/asoderq)

PKG_NAME="mednafen"
PKG_VERSION="1.31.0-UNSTABLE"
PKG_LICENSE="mixed"
PKG_SITE="https://mednafen.github.io/"
PKG_URL="${PKG_SITE}/releases/files/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain SDL2"
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
  RK3399|RK35*)
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

  mkdir -p ${INSTALL}/usr/config
  if [ -d ${PKG_DIR}/config/${DEVICE} ]; then
    cp ${PKG_DIR}/config/${DEVICE}/* ${INSTALL}/usr/config/
  else
    cp ${PKG_DIR}/config/common/* ${INSTALL}/usr/config/
  fi
}
