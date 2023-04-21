# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2022 - Fewtarius

PKG_NAME="docker"
PKG_LICENSE="Apache-2.0"
PKG_SITE="www.jelos.org"
PKG_SECTION="virtual"
PKG_LONGDESC="Container support software metapackage."

PKG_CONTAINERSUPPORT="cli containerd moby runc tini"

PKG_DEPENDS_TARGET="${PKG_CONTAINERSUPPORT}"

