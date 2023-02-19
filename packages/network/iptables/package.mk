# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018 Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2018-present Team CoreELEC (https://coreelec.org)

PKG_NAME="iptables"
PKG_LICENSE="GPL"
PKG_SITE="http://www.netfilter.org/"
PKG_DEPENDS_TARGET="toolchain linux libmnl libnftnl"
PKG_LONGDESC="IP packet filter administration."
PKG_TOOLCHAIN="autotools"


case ${DEVICE} in
  RK3566)
    PKG_VERSION="1.8.3"
    PKG_PATCH_DIRS+="4.x"
    PKG_CONFIGURE_OPTS_TARGET="--with-kernel=$(kernel_path)
    CPPFLAGS=-I${SYSROOT_PREFIX}/usr/include"
  ;;
  *)
    PKG_VERSION="1.8.8"
    PKG_PATCH_DIRS+="5.x"
  ;;
esac

PKG_URL="https://www.netfilter.org/projects/iptables/files/${PKG_NAME}-${PKG_VERSION}.tar.bz2"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/config/iptables/
    cp -PR ${PKG_DIR}/config/README ${INSTALL}/usr/config/iptables/

  mkdir -p ${INSTALL}/etc/iptables/
    cp -PR ${PKG_DIR}/config/* ${INSTALL}/etc/iptables/

  mkdir -p ${INSTALL}/usr/lib/coreelec
    cp ${PKG_DIR}/scripts/iptables_helper ${INSTALL}/usr/lib/coreelec
}

post_install() {
  enable_service iptables.service
}

