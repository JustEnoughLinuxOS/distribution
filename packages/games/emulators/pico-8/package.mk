# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2022-present Fewtarius

PKG_NAME="pico-8"
PKG_VERSION="deb7006ab08b2d93ecacc146e77cc68874826317"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain SDL2"
PKG_SECTION="emulators"
PKG_SHORTDESC="PICO-8 Fantasy Console"
PKG_TOOLCHAIN="manual"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_DIR}/sources/start_pico8.sh ${INSTALL}/usr/bin
  chmod 0755 ${INSTALL}/usr/bin/start_pico8.sh

  mkdir -p ${INSTALL}/usr/lib/autostart/common
  cp ${PKG_DIR}/sources/autostart/common/* ${INSTALL}/usr/lib/autostart/common
  chmod 0755 ${INSTALL}/usr/lib/autostart/common/*
}
