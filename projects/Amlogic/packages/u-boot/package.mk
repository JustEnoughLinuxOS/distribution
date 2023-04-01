# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="u-boot"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/hardkernel/"
PKG_DEPENDS_TARGET="toolchain swig:host rkbin amlogic-boot-fip"
PKG_LONGDESC="U-Boot is a bootloader for embedded systems."
GET_HANDLER_SUPPORT="git"
PKG_PATCH_DIRS+="${DEVICE}"

case ${DEVICE} in
  OGU)
    PKG_URL="${PKG_SITE}/u-boot.git"
    PKG_VERSION="9235942906216dc529c1e96f67dd2364a94d0738"
    PKG_GIT_CLONE_BRANCH="odroidgoU-v2015.01"
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
  . ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/options
  if [ -z "${UBOOT_CONFIG}" ]; then
    echo "UBOOT_CONFIG must be set to build an image"
  else
    if [ -e "${PROJECT_DIR}/projects/${PROJECT}/devices/${DEVICE}/u-boot/${UBOOT_CONFIG}" ]
    then
      cp ${PROJECT_DIR}/projects/${PROJECT}/devices/${DEVICE}/u-boot/${UBOOT_CONFIG} configs
    fi
    [ "${BUILD_WITH_DEBUG}" = "yes" ] && PKG_DEBUG=1 || PKG_DEBUG=0
    cd ${PKG_BUILD}
    echo "Building for MBR (${UBOOT_DTB})..."
    [ -n "${ATF_PLATFORM}" ] &&  cp -av $(get_build_dir atf)/bl31.bin .
    DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm make mrproper
    DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm make ${UBOOT_CONFIG}
    DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm _python_sysroot="${TOOLCHAIN}" _python_prefix=/ _python_exec_prefix=/ make HOSTCC="$HOST_CC" HOSTLDFLAGS="-L${TOOLCHAIN}/lib" HOSTSTRIP="true" CONFIG_MKIMAGE_DTC_PATH="scripts/dtc/dtc"
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
