# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="spirv-headers"
# The SPIRV-Headers have to be specific versions matching the glslang pkg version
# https://github.com/KhronosGroup/glslang/blob/11.12.0/known_good.json
# if you update glslang make sure spirv-tools & spirv-headers versions a known good
PKG_VERSION="85a1ed200d50660786c1a88d9166e871123cce39"
PKG_SHA256="9729304d0915e758c5ea2a1c60b55a123d976f172c0a8dae3162ad23c77ef33b"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/KhronosGroup/SPIRV-headers"
PKG_URL="https://github.com/KhronosGroup/SPIRV-headers/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST=""
PKG_LONGDESC="SPIRV-Headers"
PKG_TOOLCHAIN="manual"
