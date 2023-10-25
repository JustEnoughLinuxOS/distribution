# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="ayn-platform"
PKG_VERSION="068cce29a7ef31f32b6aed3ca8ab9c1c91308e41"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/ShadowBlip/ayn-platform"
PKG_URL="${PKG_SITE}.git"
PKG_ARCH="x86_64 i686"
PKG_DEPENDS_TARGET="toolchain linux kernel-firmware"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="A hwmon interface for PWM control, as well as RGB control and access to temperature sensors provided by the system EC."
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="make"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make \
       ARCH=${TARGET_KERNEL_ARCH} \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       TARGET=$(kernel_version) \
       KERNEL_MODULES=$(get_build_dir linux)/.install_pkg/$(get_full_module_dir) \
       KERNEL_BUILD=$(get_build_dir linux) modules
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp *.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
}
