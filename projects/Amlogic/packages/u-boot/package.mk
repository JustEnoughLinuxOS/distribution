# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="u-boot"
PKG_VERSION="95c5b7a80e"
PKG_LICENSE="GPL"
PKG_SITE="https://www.denx.de/wiki/U-Boot"
PKG_URL="https://github.com/JustEnoughLinuxOS/hardkernel-uboot/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain gcc-linaro-aarch64-elf:host gcc-linaro-arm-eabi:host"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems."
PKG_TOOLCHAIN="manual"
PKG_PATCH_DIRS+="${DEVICE}*"

make_target() {
  . ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/options
  if [ -z "${UBOOT_CONFIG}" ]; then
    echo "UBOOT_CONFIG must be set to build an image"
  else
    [ "${BUILD_WITH_DEBUG}" = "yes" ] && PKG_DEBUG=1 || PKG_DEBUG=0
    echo "Building for MBR (${UBOOT_DTB})..."
    export PATH=${TOOLCHAIN}/lib/gcc-linaro-aarch64-elf/bin/:${TOOLCHAIN}/lib/gcc-linaro-arm-eabi/bin/:${PATH}
    DEBUG=${PKG_DEBUG} CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make mrproper
    DEBUG=${PKG_DEBUG} CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make ${UBOOT_CONFIG}
    DEBUG=${PKG_DEBUG} CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make HOSTCC="${HOST_CC}" HOSTSTRIP="true"
  fi
}

makeinstall_target() {
    mkdir -p ${INSTALL}/usr/share/bootloader
    mkdir -p ${INSTALL}/usr/share/bootloader/fip
    # Only install u-boot.img et al when building a board specific image
    if [ -n "${UBOOT_CONFIG}" ]; then
      find_file_path bootloader/install && . ${FOUND_PATH}
    fi

    # Always install the update script
    find_file_path bootloader/update.sh && cp -av ${FOUND_PATH} ${INSTALL}/usr/share/bootloader

    # Always install the canupdate script
    if find_file_path bootloader/canupdate.sh; then
      cp -av ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
      sed -e "s/@PROJECT@/${DEVICE:-${PROJECT}}/g" \
          -i ${INSTALL}/usr/share/bootloader/canupdate.sh
    fi
}
