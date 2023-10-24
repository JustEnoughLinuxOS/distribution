# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023-present - The JELOS Project (https://github.com/JustEnoughLinuxOS)

PKG_NAME="yamlcpp"
PKG_VERSION="f732014"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/jbeder/yaml-cpp"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A C++ library for YAML."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic"

