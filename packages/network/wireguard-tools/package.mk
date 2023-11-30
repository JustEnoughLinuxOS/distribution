# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="wireguard-tools"
PKG_VERSION="v1.0.20210914"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.wireguard.com"
PKG_URL="https://git.zx2c4.com/wireguard-tools/snapshot/wireguard-tools-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux libmnl"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="WireGuard VPN userspace tools"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  kernel_make KERNELDIR=$(kernel_path) -C src/ wg
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp ${PKG_DIR}/scripts/wg-keygen ${INSTALL}/usr/bin
    cp ${PKG_DIR}/scripts/wg-genconfig ${INSTALL}/usr/bin
    cp ${PKG_BUILD}/src/wg ${INSTALL}/usr/bin
    cp ${PKG_BUILD}/src/wg-quick/linux.bash ${INSTALL}/usr/bin/wg-quick
    chmod 755 ${INSTALL}/usr/bin/*
}
