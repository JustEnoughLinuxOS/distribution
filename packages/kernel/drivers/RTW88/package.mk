# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2024 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="RTW88"
PKG_VERSION="ca9f4e199efbf8c377e8a1769ba5b05b23f92c82"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lwfinger/rtw88"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain linux kernel-firmware"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="Realtek RTW WIFI drivers."
PKG_IS_KERNEL_PKG="yes"
#PKG_TOOLCHAIN="make"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make V=1 \
       ARCH=${TARGET_KERNEL_ARCH} \
       KSRC=$(kernel_path) \
       KVER=$(kernel_version) \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       all
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/kernel/net/wireless/rtw88/
    cp *.ko ${INSTALL}/$(get_full_module_dir)/kernel/net/wireless/rtw88/
}
