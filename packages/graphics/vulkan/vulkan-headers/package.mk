# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vulkan-headers"
PKG_VERSION="1.3.277"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/KhronosGroup/Vulkan-Headers"
PKG_URL="https://github.com/KhronosGroup/Vulkan-Headers/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Vulkan Header files and API registry"

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-DCMAKE_BUILD_TYPE=Release"
}
