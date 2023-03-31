# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2023-present Fewtarius

PKG_NAME="drm_tool"
PKG_VERSION="1cb5b10"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/NickCis/drm_tool"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A simple tool for getting drm info and setting properties."

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp drm_tool ${INSTALL}/usr/bin
}
