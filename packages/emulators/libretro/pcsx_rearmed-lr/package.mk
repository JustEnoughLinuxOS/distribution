# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020 Trond Haugland (trondah@gmail.com)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="pcsx_rearmed-lr"
PKG_VERSION="4373e29de72c917dbcd04ec2a5fb685e69d9def3"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="ARM optimized PCSX fork"
PKG_TOOLCHAIN="manual"
PKG_PATCH_DIRS+="${TARGET_ARCH}/${DEVICE}"

make_target() {
  cd ${PKG_BUILD}
  make -f Makefile.libretro GIT_VERSION=${PKG_VERSION} platform=${DEVICE}
}

makeinstall_target32() {
  case ${ARCH} in
    aarch64)
      if [ "${ENABLE_32BIT}" == "true" ]
      then
        cp -vP ${ROOT}/build.${DISTRO}-${DEVICE}.arm/${PKG_NAME}-*/.install_pkg/usr/lib/libretro/${1}_libretro.so ${INSTALL}/usr/lib/libretro/${1}32_libretro.so
      fi
    ;;
  esac
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp pcsx_rearmed_libretro.so ${INSTALL}/usr/lib/libretro/
  makeinstall_target32 pcsx_rearmed
}
