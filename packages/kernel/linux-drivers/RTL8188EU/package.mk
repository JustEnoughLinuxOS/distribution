# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="RTL8188EU"
PKG_VERSION="306f3e62cf7cddf8cee74f70f88a7a7b3af46f56"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lwfinger/rtl8188eu"
PKG_URL="https://github.com/lwfinger/rtl8188eu/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux linux kernel-firmware"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="Realtek RTL81xxEU Linux 3.x driver"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="make"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make modules \
       ARCH=${TARGET_KERNEL_ARCH} \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       CONFIG_POWER_SAVING=y
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp *.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
}
