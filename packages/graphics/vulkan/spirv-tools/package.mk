# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="spirv-tools"
# The SPIRV-Tools have to be specific versions matching the glslang pkg version
# https://github.com/KhronosGroup/glslang/blob/11.12.0/known_good.json
# if you update glslang make sure spirv-tools & spirv-headers versions a known good
PKG_VERSION="eb0a36633d2acf4de82588504f951ad0f2cecacb"
PKG_SHA256="9f7c423c9dad6c9e664e0600226646232a328051f73f30d6795360370aa06a2f"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/KhronosGroup/SPIRV-Tools"
PKG_URL="https://github.com/KhronosGroup/SPIRV-Tools/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST=""
PKG_LONGDESC="The SPIR-V Tools project provides an API and commands for processing SPIR-V modules."
PKG_TOOLCHAIN="manual"
