# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="u-boot"
PKG_VERSION="v2023.10"
PKG_LICENSE="GPL"
PKG_SITE="https://www.denx.de/wiki/U-Boot"
PKG_URL="https://github.com/u-boot/u-boot/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain gcc-linaro-aarch64-elf:host gcc-linaro-arm-eabi:host amlogic-boot-fip"
PKG_DEPENDS_UNPACK="amlogic-boot-fip"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems."
PKG_TOOLCHAIN="manual"

PKG_NEED_UNPACK="$PROJECT_DIR/$PROJECT/bootloader"

if [ "${SUBDEVICE}" = "Odroid_GOU" ]; then
  PKG_VERSION="9235942906216dc529c1e96f67dd2364a94d0738"
  PKG_URL="https://github.com/hardkernel/u-boot/archive/${PKG_VERSION}.tar.gz"
  PKG_UBOOT_CONFIG="odroidgou_defconfig"
elif [ "${SUBDEVICE}" = "Odroid_N2" ]; then
  PKG_UBOOT_CONFIG="odroid-n2_defconfig"
  PKG_UBOOT_FIP="odroid-n2"
elif [ "${SUBDEVICE}" = "Odroid_N2L" ]; then
  PKG_UBOOT_CONFIG="odroid-n2l_defconfig"
  PKG_UBOOT_FIP="odroid-n2l"
fi

SUBDEVICE=${SUBDEVICE}

make_target() {
  [ "${BUILD_WITH_DEBUG}" = "yes" ] && PKG_DEBUG=1 || PKG_DEBUG=0
  if [ "${SUBDEVICE}" = "Odroid_GOU" ]; then
    export PATH="${TOOLCHAIN}/lib/gcc-linaro-aarch64-elf/bin/:${TOOLCHAIN}/lib/gcc-linaro-arm-eabi/bin/:${PATH}"
    DEBUG=${PKG_DEBUG} CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make mrproper
    DEBUG=${PKG_DEBUG} CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make ${PKG_UBOOT_CONFIG}
    DEBUG=${PKG_DEBUG} CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make HOSTCC="${HOST_CC}" HOSTSTRIP="true"

    # repack odroidbios.bin for jelos
    ${TOOLCHAIN}/sbin/fsck.cramfs --extract=jelos tools/odroid_resource/ODROIDBIOS.BIN
    sed -e "s/ODROIDGOU/JELOS/" -i jelos/boot.ini
    ${TOOLCHAIN}/sbin/mkfs.cramfs -N little jelos tools/odroid_resource/ODROIDBIOS.BIN
  elif [ -n "${SUBDEVICE}" ]; then
    setup_pkg_config_host
    DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm make mrproper
    DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm make HOSTCC="${HOST_CC}" HOSTCFLAGS="-I${TOOLCHAIN}/include" HOSTLDFLAGS="${HOST_LDFLAGS}" ${PKG_UBOOT_CONFIG}
    DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm _python_sysroot="${TOOLCHAIN}" _python_prefix=/ _python_exec_prefix=/ make HOSTCC="${HOST_CC}" HOSTCFLAGS="-I${TOOLCHAIN}/include" HOSTLDFLAGS="${HOST_LDFLAGS}" HOSTSTRIP="true" CONFIG_MKIMAGE_DTC_PATH="scripts/dtc/dtc"

    FIP_DIR="$(get_build_dir amlogic-boot-fip)"
    cp -av ${PKG_BUILD}/u-boot.bin ${FIP_DIR}/${PKG_UBOOT_FIP}
    cd ${FIP_DIR}
    ./build-fip.sh ${PKG_UBOOT_FIP} ${FIP_DIR}/${PKG_UBOOT_FIP}/u-boot.bin ${PKG_BUILD}
  else
    : # do nothing
  fi
}

makeinstall_target() {
  if [ -n "${SUBDEVICE}" ]; then
    mkdir -p $INSTALL/usr/share/bootloader

    # Always install the update script
    find_file_path bootloader/update.sh && cp -av ${FOUND_PATH} $INSTALL/usr/share/bootloader

    if find_file_path bootloader/boot.ini; then
      cp -av ${FOUND_PATH} $INSTALL/usr/share/bootloader
      sed -e "s/@EXTRA_CMDLINE@/${EXTRA_CMDLINE}/" \
          -i "${INSTALL}/usr/share/bootloader/boot.ini"
    fi

    if find_dir_path bootloader/extlinux; then
      cp -av ${FOUND_PATH} $INSTALL/usr/share/bootloader
      sed -e "s/@EXTRA_CMDLINE@/${EXTRA_CMDLINE}/" \
          -i "${INSTALL}/usr/share/bootloader/extlinux/extlinux.conf"
    fi

    if [ "${SUBDEVICE}" = "Odroid_GOU" ]; then
      PKG_UBOOTBIN="${PKG_BUILD}/sd_fuse/u-boot.bin"
      cp -av ${PKG_BUILD}/tools/odroid_resource/* ${INSTALL}/usr/share/bootloader
    else
      PKG_UBOOTBIN="${PKG_BUILD}/u-boot.bin"
    fi
    if [ "${PKG_UBOOTBIN}" ]; then
      cp -av ${PKG_UBOOTBIN} $INSTALL/usr/share/bootloader/${SUBDEVICE}_u-boot
    fi
  else
    : # do nothing
  fi
}
