# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)
# Copyright (C) 2022-present Fewtarius
# Copyright (C) 2022-present Brooksytech

PKG_NAME="linux"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/JustEnoughLinuxOS"
PKG_DEPENDS_HOST="ccache:host rsync:host openssl:host"
PKG_DEPENDS_TARGET="toolchain linux:host cpio:host kmod:host xz:host wireless-regdb keyutils util-linux binutils ncurses openssl:host ${KERNEL_EXTRA_DEPENDS_TARGET}"
PKG_DEPENDS_INIT="toolchain"
PKG_NEED_UNPACK="${LINUX_DEPENDS} $(get_pkg_directory busybox)"
PKG_LONGDESC="This package builds the kernel for Rockchip devices"
PKG_IS_KERNEL_PKG="yes"
PKG_STAMP="${KERNEL_TARGET} ${KERNEL_MAKE_EXTRACMD}"
PKG_PATCH_DIRS+="${DEVICE}"

case ${DEVICE} in
  RG351P|RG351V|RG351MP|RGB20S)
    PKG_URL="${PKG_SITE}/rk3326-kernel.git"
    PKG_VERSION="0b4eef36a"
    GET_HANDLER_SUPPORT="git"
    PKG_GIT_CLONE_BRANCH="main"
  ;;
  RG552)
    PKG_VERSION="6.0.11"
    PKG_URL="https://www.kernel.org/pub/linux/kernel/v6.x/${PKG_NAME}-${PKG_VERSION}.tar.xz"
  ;;
  RG353P|RG503)
    PKG_URL="${PKG_SITE}/rk356x-kernel.git"
    PKG_VERSION="0ab76df23"
    GET_HANDLER_SUPPORT="git"
    PKG_GIT_CLONE_BRANCH="main"
  ;;
esac

PKG_KERNEL_CFG_FILE=$(kernel_config_path) || die

if [ -n "${KERNEL_TOOLCHAIN}" ]; then
  PKG_DEPENDS_HOST="${PKG_DEPENDS_HOST} gcc-${KERNEL_TOOLCHAIN}:host"
  PKG_DEPENDS_TARGET="${PKG_DEPENDS_TARGET} gcc-${KERNEL_TOOLCHAIN}:host"
  HEADERS_ARCH=${TARGET_ARCH}
fi

if [ "${PKG_BUILD_PERF}" != "no" ] && grep -q ^CONFIG_PERF_EVENTS= ${PKG_KERNEL_CFG_FILE} ; then
  PKG_BUILD_PERF="yes"
  PKG_DEPENDS_TARGET="${PKG_DEPENDS_TARGET} elfutils libunwind zlib openssl"
fi

if [ "${TARGET_ARCH}" = "x86_64" ]; then
  PKG_DEPENDS_TARGET="${PKG_DEPENDS_TARGET} intel-ucode:host kernel-firmware elfutils:host pciutils"
fi

if [[ "${KERNEL_TARGET}" = uImage* ]]; then
  PKG_DEPENDS_TARGET="${PKG_DEPENDS_TARGET} u-boot-tools:host"
fi

post_patch() {
  cp ${PKG_KERNEL_CFG_FILE} ${PKG_BUILD}/.config

  sed -i -e "s|^CONFIG_INITRAMFS_SOURCE=.*$|CONFIG_INITRAMFS_SOURCE=\"${BUILD}/image/initramfs.cpio\"|" ${PKG_BUILD}/.config
  sed -i -e '/^CONFIG_INITRAMFS_SOURCE=*./ a CONFIG_INITRAMFS_ROOT_UID=0\nCONFIG_INITRAMFS_ROOT_GID=0' ${PKG_BUILD}/.config

  # set default hostname based on ${DEVICE}
    sed -i -e "s|@DEVICENAME@|${DEVICE}|g" ${PKG_BUILD}/.config

  # disable swap support if not enabled
  if [ ! "${SWAP_SUPPORT}" = yes ]; then
    sed -i -e "s|^CONFIG_SWAP=.*$|# CONFIG_SWAP is not set|" ${PKG_BUILD}/.config
  fi

  # disable nfs support if not enabled
  if [ ! "${NFS_SUPPORT}" = yes ]; then
    sed -i -e "s|^CONFIG_NFS_FS=.*$|# CONFIG_NFS_FS is not set|" ${PKG_BUILD}/.config
  fi

  # disable cifs support if not enabled
  if [ ! "${SAMBA_SUPPORT}" = yes ]; then
    sed -i -e "s|^CONFIG_CIFS=.*$|# CONFIG_CIFS is not set|" ${PKG_BUILD}/.config
  fi

  # disable iscsi support if not enabled
  if [ ! "${ISCSI_SUPPORT}" = yes ]; then
    sed -i -e "s|^CONFIG_SCSI_ISCSI_ATTRS=.*$|# CONFIG_SCSI_ISCSI_ATTRS is not set|" ${PKG_BUILD}/.config
    sed -i -e "s|^CONFIG_ISCSI_TCP=.*$|# CONFIG_ISCSI_TCP is not set|" ${PKG_BUILD}/.config
    sed -i -e "s|^CONFIG_ISCSI_BOOT_SYSFS=.*$|# CONFIG_ISCSI_BOOT_SYSFS is not set|" ${PKG_BUILD}/.config
    sed -i -e "s|^CONFIG_ISCSI_IBFT_FIND=.*$|# CONFIG_ISCSI_IBFT_FIND is not set|" ${PKG_BUILD}/.config
    sed -i -e "s|^CONFIG_ISCSI_IBFT=.*$|# CONFIG_ISCSI_IBFT is not set|" ${PKG_BUILD}/.config
  fi

  # install extra dts files
  for f in ${PROJECT_DIR}/${PROJECT}/config/*-overlay.dts; do
    [ -f "${f}" ] && cp -v ${f} ${PKG_BUILD}/arch/${TARGET_KERNEL_ARCH}/boot/dts/overlays || true
  done
  if [ -n "${DEVICE}" ]; then
    for f in ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/config/*-overlay.dts; do
      [ -f "${f}" ] && cp -v ${f} ${PKG_BUILD}/arch/${TARGET_KERNEL_ARCH}/boot/dts/overlays || true
    done
  fi
}

make_host() {
  :
}

makeinstall_host() {
  make \
    ARCH=${HEADERS_ARCH:-${TARGET_KERNEL_ARCH}} \
    HOSTCC="${TOOLCHAIN}/bin/host-gcc" \
    HOSTCXX="${TOOLCHAIN}/bin/host-g++" \
    HOSTCFLAGS="${HOST_CFLAGS}" \
    HOSTCXXFLAGS="${HOST_CXXFLAGS}" \
    HOSTLDFLAGS="${HOST_LDFLAGS}" \
    INSTALL_HDR_PATH=dest \
    headers_install
  mkdir -p ${SYSROOT_PREFIX}/usr/include
    cp -R dest/include/* ${SYSROOT_PREFIX}/usr/include
}

pre_make_target() {
  if [ "${TARGET_ARCH}" = "x86_64" ]; then
    # copy some extra firmware to linux tree
    mkdir -p ${PKG_BUILD}/external-firmware
      cp -a $(get_build_dir kernel-firmware)/{amdgpu,amd-ucode,i915,radeon,e100,rtl_nic} ${PKG_BUILD}/external-firmware

    cp -a $(get_build_dir intel-ucode)/intel-ucode ${PKG_BUILD}/external-firmware

    FW_LIST="$(find ${PKG_BUILD}/external-firmware \( -type f -o -type l \) \( -iname '*.bin' -o -iname '*.fw' -o -path '*/intel-ucode/*' \) | sed 's|.*external-firmware/||' | sort | xargs)"
    sed -i "s|CONFIG_EXTRA_FIRMWARE=.*|CONFIG_EXTRA_FIRMWARE=\"${FW_LIST}\"|" ${PKG_BUILD}/.config
  fi

  yes "" | kernel_make oldconfig

  # regdb (backward compatability with pre-4.15 kernels)
  if grep -q ^CONFIG_CFG80211_INTERNAL_REGDB= ${PKG_BUILD}/.config ; then
    cp $(get_build_dir wireless-regdb)/db.txt ${PKG_BUILD}/net/wireless/db.txt
  fi
  makeinstall_host
}

make_target() {

  if [ "${PKG_BUILD_PERF}" = "yes" ] ; then
    ( cd tools/perf

      # arch specific perf build args
      case "${TARGET_ARCH}" in
        x86_64)
          PERF_BUILD_ARGS="ARCH=x86"
          ;;
        aarch64)
          PERF_BUILD_ARGS="ARCH=arm64"
          ;;
        *)
          PERF_BUILD_ARGS="ARCH=${TARGET_ARCH}"
          ;;
      esac

      WERROR=0 \
      NO_LIBPERL=1 \
      NO_LIBPYTHON=1 \
      NO_SLANG=1 \
      NO_GTK2=1 \
      NO_LIBNUMA=1 \
      NO_LIBAUDIT=1 \
      NO_LZMA=1 \
      NO_SDT=1 \
      CROSS_COMPILE="${TARGET_PREFIX}" \
      JOBS="${CONCURRENCY_MAKE_LEVEL}" \
        make ${PERF_BUILD_ARGS}
      mkdir -p ${INSTALL}/usr/bin
        cp perf ${INSTALL}/usr/bin
    )
  fi

  ( cd ${ROOT}
    rm -rf ${BUILD}/initramfs
    ${SCRIPTS}/install initramfs
  )
  pkg_lock_status "ACTIVE" "linux:target" "build"

  # arm64 target does not support creating uImage.
  # Build Image first, then wrap it using u-boot's mkimage.
  if [[ "${TARGET_KERNEL_ARCH}" == "arm64" && "${KERNEL_TARGET}" == uImage* ]]; then
    if [ -z "${KERNEL_UIMAGE_LOADADDR}" -o -z "${KERNEL_UIMAGE_ENTRYADDR}" ]; then
      die "ERROR: KERNEL_UIMAGE_LOADADDR and KERNEL_UIMAGE_ENTRYADDR have to be set to build uImage - aborting"
    fi
    KERNEL_UIMAGE_TARGET="${KERNEL_TARGET}"
    KERNEL_TARGET="${KERNEL_TARGET/uImage/Image}"
  fi

  if [ -d "${INSTALL}/$(get_kernel_overlay_dir)" ]
  then
    rm -rf ${INSTALL}/$(get_kernel_overlay_dir)
  fi

  # the modules target is required to get a proper Module.symvers
  # file with symbols from built-in and external modules.
  # Without that it'll contain only the symbols from the kernel
  kernel_make ${KERNEL_TARGET} ${KERNEL_MAKE_EXTRACMD} modules
  kernel_make INSTALL_MOD_PATH=${INSTALL}/$(get_kernel_overlay_dir) modules_install
  rm -f ${INSTALL}/$(get_kernel_overlay_dir)/lib/modules/*/build
  rm -f ${INSTALL}/$(get_kernel_overlay_dir)/lib/modules/*/source

  if [ -n "${KERNEL_UIMAGE_TARGET}" ] ; then

    # determine compression used for kernel image
    KERNEL_UIMAGE_COMP=${KERNEL_UIMAGE_TARGET:7}
    KERNEL_UIMAGE_COMP=${KERNEL_UIMAGE_COMP:-none}

    # calculate new load address to make kernel Image unpack to memory area after compressed image
    if [ "${KERNEL_UIMAGE_COMP}" != "none" ] ; then
      COMPRESSED_SIZE=$(stat -t "arch/${TARGET_KERNEL_ARCH}/boot/${KERNEL_TARGET}" | awk '{print $2}')
      # align to 1 MiB
      COMPRESSED_SIZE=$(( ((${COMPRESSED_SIZE} - 1 >> 20) + 1) << 20 ))
      PKG_KERNEL_UIMAGE_LOADADDR=$(printf '%X' "$(( ${KERNEL_UIMAGE_LOADADDR} + ${COMPRESSED_SIZE} ))")
      PKG_KERNEL_UIMAGE_ENTRYADDR=$(printf '%X' "$(( ${KERNEL_UIMAGE_ENTRYADDR} + ${COMPRESSED_SIZE} ))")
    else
      PKG_KERNEL_UIMAGE_LOADADDR=${KERNEL_UIMAGE_LOADADDR}
      PKG_KERNEL_UIMAGE_ENTRYADDR=${KERNEL_UIMAGE_ENTRYADDR}
    fi

    mkimage -A ${TARGET_KERNEL_ARCH} \
            -O linux \
            -T kernel \
            -C ${KERNEL_UIMAGE_COMP} \
            -a ${PKG_KERNEL_UIMAGE_LOADADDR} \
            -e ${PKG_KERNEL_UIMAGE_ENTRYADDR} \
            -d arch/${TARGET_KERNEL_ARCH}/boot/${KERNEL_TARGET} \
               arch/${TARGET_KERNEL_ARCH}/boot/${KERNEL_UIMAGE_TARGET}

    KERNEL_TARGET="${KERNEL_UIMAGE_TARGET}"
  fi
  if [ "${PKG_SOC}" = "rk356x" ]; then
      kernel_make ${KERNEL_TARGET} ${KERNEL_MAKE_EXTRACMD} ARCH=arm64 ${DEVICE_DTB[0]}.img
  fi
}

makeinstall_target() {
  . ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/options
  if [ "${BOOTLOADER}" = "u-boot" ]; then
    mkdir -p ${INSTALL}/usr/share/bootloader
    for dtb in arch/${TARGET_KERNEL_ARCH}/boot/dts/*.dtb arch/${TARGET_KERNEL_ARCH}/boot/dts/*/*.dtb; do
      if [ -f ${dtb} ]; then
        cp -v ${dtb} ${INSTALL}/usr/share/bootloader
      fi
    done
    if [ "${PKG_SOC}" = "rk356x" ]; then
      ARCH=arm64 scripts/mkimg --dtb ${DEVICE_DTB[0]}.dtb
      cp -v resource.img ${INSTALL}/usr/share/bootloader
      ARCH=${TARGET_ARCH}
    fi
  elif [ "${BOOTLOADER}" = "bcm2835-bootloader" ]; then
    mkdir -p ${INSTALL}/usr/share/bootloader/overlays

    # install platform dtbs, but remove upstream kernel dtbs (i.e. without downstream
    # drivers and decent USB support) as these are not required by LibreELEC
    cp -p arch/${TARGET_KERNEL_ARCH}/boot/dts/*.dtb ${INSTALL}/usr/share/bootloader
    rm -f ${INSTALL}/usr/share/bootloader/bcm283*.dtb

    # install overlay dtbs
    for dtb in arch/${TARGET_KERNEL_ARCH}/boot/dts/overlays/*.dtbo; do
      cp ${dtb} ${INSTALL}/usr/share/bootloader/overlays 2>/dev/null || :
    done
    cp -p arch/${TARGET_KERNEL_ARCH}/boot/dts/overlays/README ${INSTALL}/usr/share/bootloader/overlays
  fi
}

make_init() {
 : # reuse make_target()
}

makeinstall_init() {
  if [ -n "${INITRAMFS_MODULES}" ]; then
    mkdir -p ${INSTALL}/etc
    mkdir -p ${INSTALL}/usr/lib/modules

    for i in ${INITRAMFS_MODULES}; do
      module=`find .install_pkg/$(get_full_module_dir)/kernel -name ${i}.ko`
      if [ -n "${module}" ]; then
        echo ${i} >> ${INSTALL}/etc/modules
        cp ${module} ${INSTALL}/usr/lib/modules/`basename ${module}`
      fi
    done
  fi

  if [ "${UVESAFB_SUPPORT}" = yes ]; then
    mkdir -p ${INSTALL}/usr/lib/modules
      uvesafb=`find .install_pkg/$(get_full_module_dir)/kernel -name uvesafb.ko`
      cp ${uvesafb} ${INSTALL}/usr/lib/modules/`basename ${uvesafb}`
  fi
}

post_install() {
  if [ ! -d ${INSTALL}/$(get_full_firmware_dir) ]
  then
    mkdir -p ${INSTALL}/$(get_full_firmware_dir)/
  fi

  # regdb and signature is now loaded as firmware by 4.15+
    if grep -q ^CONFIG_CFG80211_REQUIRE_SIGNED_REGDB= ${PKG_BUILD}/.config; then
      cp $(get_build_dir wireless-regdb)/regulatory.db{,.p7s} ${INSTALL}/$(get_full_firmware_dir)
    fi
}
