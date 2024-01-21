# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="u-boot"
PKG_ARCH="arm aarch64"
PKG_SITE="https://github.com/JustEnoughLinuxOS"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="toolchain swig:host rkbin glibc pyelftools:host"
PKG_LONGDESC="Rockchip U-Boot is a bootloader for embedded systems."
PKG_PATCH_DIRS+="${DEVICE}"

case ${DEVICE} in
 RK358*)
    PKG_URL="${PKG_SITE}/rk35xx-uboot.git"
    PKG_VERSION="d34ff0716"
    PKG_GIT_CLONE_BRANCH="v2017.09-rk3588"
  ;;
  RK356*)
    PKG_URL="${PKG_SITE}/rk356x-uboot.git"
    PKG_VERSION="97c658238f7ccd436fbdede451bfd7488514a5c8"
  ;;
  RK3399)
    PKG_DEPENDS_TARGET+=" atf openssl:host"
    PKG_VERSION="2024.01"
    PKG_URL="https://ftp.denx.de/pub/u-boot/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
  ;;
  RK3326)
    PKG_URL="https://github.com/hardkernel/u-boot.git"
    PKG_VERSION="0e26e35cb18a80005b7de45c95858c86a2f7f41e"
    PKG_GIT_CLONE_BRANCH="odroidgoA-v2017.09"
  ;;
esac

PKG_IS_KERNEL_PKG="yes"
PKG_STAMP="${UBOOT_CONFIG}"

[ -n "${ATF_PLATFORM}" ] && PKG_DEPENDS_TARGET+=" atf"

PKG_NEED_UNPACK="${PROJECT}_DIR/${PROJECT}/bootloader"
[ -n "${DEVICE}" ] && PKG_NEED_UNPACK+=" ${PROJECT}_DIR/${PROJECT}/devices/${DEVICE}/bootloader"

post_patch() {
  if [ -n "${UBOOT_CONFIG}" ] && find_file_path bootloader/config; then
    PKG_CONFIG_FILE="${UBOOT_CONFIG}"
    if [ -f "${PKG_CONFIG_FILE}" ]; then
      cat ${FOUND_PATH} >> "${PKG_CONFIG_FILE}"
    fi
  fi
}

make_target() {
setup_pkg_config_host
  . ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/options
  if [ -z "${UBOOT_CONFIG}" ]; then
    echo "UBOOT_CONFIG must be set to build an image"
  else
    if [ -e "${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/u-boot/${UBOOT_CONFIG}" ]
    then
      cp ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/u-boot/${UBOOT_CONFIG} configs
    fi
    [ "${BUILD_WITH_DEBUG}" = "yes" ] && PKG_DEBUG=1 || PKG_DEBUG=0
      if [[ "${PKG_BL31}" =~ ^/bin ]]
      then
        PKG_BL31="$(get_build_dir rkbin)/${PKG_BL31}"
      fi
      if [[ "${PKG_LOADER}" =~ ^/bin ]]
      then
        PKG_LOADER="$(get_build_dir rkbin)/${PKG_LOADER}"
      fi
    if [[ "${PKG_SOC}" =~ "rk35" ]]
    then
      DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm64 make mrproper
      DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm64 make ${UBOOT_CONFIG} BL31=${PKG_BL31} ${PKG_LOADER} u-boot.dtb u-boot.itb CONFIG_MKIMAGE_DTC_PATH="scripts/dtc/dtc"
      DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm64 _python_sysroot="${TOOLCHAIN}" _python_prefix=/ _python_exec_prefix=/ make HOSTCC="${HOST_CC}" HOSTLDFLAGS="-L${TOOLCHAIN}/lib" HOSTSTRIP="true" CONFIG_MKIMAGE_DTC_PATH="scripts/dtc/dtc"
    else
      echo "Building for MBR (${UBOOT_DTB})..."
      if [[ "${ATF_PLATFORM}" =~ "rk3399" ]]; then
        export BL31="$(get_build_dir atf)/.install_pkg/usr/share/bootloader/bl31.elf"
      fi
      DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm make mrproper
      DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm make ${UBOOT_CONFIG}
      if [[ "${PKG_SOC}" =~ "rk3399" ]]; then
        DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm _python_sysroot="${TOOLCHAIN}" _python_prefix=/ _python_exec_prefix=/ make HOSTCC="${HOST_CC}" HOSTCFLAGS="-I${TOOLCHAIN}/include" HOSTLDFLAGS="${HOST_LDFLAGS}" CONFIG_MKIMAGE_DTC_PATH="scripts/dtc/dtc"
      else
        DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm _python_sysroot="${TOOLCHAIN}" _python_prefix=/ _python_exec_prefix=/ make HOSTCC="$HOST_CC" HOSTLDFLAGS="-L${TOOLCHAIN}/lib" HOSTSTRIP="true" CONFIG_MKIMAGE_DTC_PATH="scripts/dtc/dtc"
      fi
    fi
  fi
}

makeinstall_target() {
    mkdir -p ${INSTALL}/usr/share/bootloader
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
