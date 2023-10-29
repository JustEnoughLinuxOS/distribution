# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="esp8089"
PKG_VERSION="1.9.20230804"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/al177/esp8089"
PKG_URL="https://github.com/al177/esp8089/archive/refs/tags/1.9.20230804.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="ESP8089 Wifi Driver"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="make"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make V=1 \
       ARCH=${TARGET_KERNEL_ARCH} \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       TARGET=$(kernel_version) \
       KERNEL_MODULES=$(get_build_dir linux)/.install_pkg/$(get_full_module_dir) \
       KBUILD=$(get_build_dir linux)
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp *.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
}