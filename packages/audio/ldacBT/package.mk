# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ldacBT"
PKG_VERSION="af2dd23979453bcd1cad7c4086af5fb421a955c5"
PKG_LICENSE="Apache"
PKG_SITE="https://github.com/EHfive/ldacBT"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_UNPACK="libldac"
PKG_LONGDESC="LDAC Bluetooth encoder library (build tools)"

PKG_CMAKE_OPTS_TARGET="-DLDAC_SOFT_FLOAT=OFF"

post_unpack() {
  rm -rf ${PKG_BUILD}/libldac
  ln -sf $(get_build_dir libldac) ${PKG_BUILD}/libldac
}
