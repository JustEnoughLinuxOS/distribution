# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="egl-wayland"
PKG_VERSION="1.1.13"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/NVIDIA/egl-wayland"
PKG_URL=${PKG_SITE}/archive/refs/tags/${PKG_VERSION}.tar.gz
PKG_DEPENDS_TARGET="toolchain eglexternalplatform"
PKG_LONGDESC="Wayland EGL External Platform library."

configure_package() {
  if [ "${DISPLAYSERVER}" = "wl" ]
  then
    PKG_DEPENDS_TARGET+=" wayland"
  fi
}

