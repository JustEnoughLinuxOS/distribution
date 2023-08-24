# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vadumpcaps"
PKG_VERSION="792c27f"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/fhvwy/vadumpcaps"
PKG_URL="https://github.com/fhvwy/vadumpcaps/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="This is a utility to show all capabilities of a VAAPI device/driver."
PKG_DEPENDS_TARGET="toolchain libva"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp vadumpcaps ${INSTALL}/usr/bin
}
