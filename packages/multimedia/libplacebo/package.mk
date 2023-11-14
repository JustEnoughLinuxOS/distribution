# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="libplacebo"
PKG_VERSION="c02c40cc3f5eb4fd736eebf6056ae4ec0df2448b"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://code.videolan.org/videolan/libplacebo"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain ffmpeg SDL2 luajit libass waf:host"
PKG_LONGDESC="The core rendering algorithms and ideas of mpv rewritten as an independent library."

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers"
  PKG_MESON_OPTS_TARGET+=" -Dvulkan=enabled"
else
  PKG_MESON_OPTS_TARGET+=" -Dvulkan=disabled"
fi
