# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023-present Fewtarius

PKG_NAME="netbase"
PKG_VERSION="6.4"
PKG_LICENSE="GPL"
PKG_SITE="https://anonscm.debian.org/cgit/users/md/netbase.git/"
PKG_URL="http://ftp.debian.org/debian/pool/main/n/netbase/netbase_${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="The netbase package provides data for network services and protocols from the iana db."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/etc
    cp ${PKG_BUILD}/etc/protocols ${INSTALL}/etc/protocols
    cp ${PKG_BUILD}/etc/services ${INSTALL}/etc/services
}
