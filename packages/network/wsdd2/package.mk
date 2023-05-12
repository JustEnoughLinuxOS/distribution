# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023-present Fewtarius

PKG_NAME="wsdd2"
PKG_VERSION="1.8.7"
PKG_LICENSE="GPL 3.0"
PKG_SITE="https://github.com/Netgear/wsdd2/"
PKG_URL="https://github.com/Netgear/wsdd2/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="WSD/LLMNR Discovery/Name Service Daemon"
PKG_BUILD_FLAGS="+size"

post_install() {
  enable_service wsdd2.service
}
