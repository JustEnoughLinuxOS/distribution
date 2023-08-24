# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vkmark"
PKG_VERSION="ab6e6f3"
PKG_LICENSE="LGPL-2.1-or-later"
PKG_SITE="https://github.com/vkmark/vkmark"
PKG_URL="https://github.com/vkmark/vkmark/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain glm assimp vulkan-loader"
PKG_LONGDESC="Vulkan benchmark"
PKG_BUILD_FLAGS="-parallel +speed"

case ${DISPLAYSERVER} in
  wl)
    PKG_DEPENDS_TARGET+=" wayland wayland-protocols"
    PKG_MESON_OPTS_TARGET="-Dwayland=true"
    ;;
  x11)
    PKG_DEPENDS_TARGET+=" libxcb xcb-util-wm"
    PKG_MESON_OPTS_TARGET="-Dxcb=true"
    ;;
  *)
    PKG_DEPENDS_TARGET+=" systemd libdrm mesa"
    PKG_MESON_OPTS_TARGET="-Dkms=true"
    ;;
esac
