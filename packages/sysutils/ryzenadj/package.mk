# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="ryzenadj"
PKG_VERSION="dac383e1cd23aa9b631e20dba6d26f1fdf223164"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/FlyGoat/RyzenAdj"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain pciutils systemd"
PKG_LONGDESC="Adjust power management settings for Ryzen Mobile Processors."
PKG_BUILD_FLAGS="+pic"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib
  cp libryzenadj.so ${INSTALL}/usr/lib
  mkdir -p ${INSTALL}/usr/bin 
  cp ryzenadj ${INSTALL}/usr/bin
}
