# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="RTL8852xx"
PKG_VERSION="78a73b0ffa15111c3021fcc8c4b6d2605fc16d88"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lwfinger/rtw89"
PKG_URL="https://github.com/lwfinger/rtw89/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux linux-firmware"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="Realtek RTL8852xx Linux driver"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="make"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  kernel_make KSRC=$(kernel_path) KVER=$(kernel_version)
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp *.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
}
