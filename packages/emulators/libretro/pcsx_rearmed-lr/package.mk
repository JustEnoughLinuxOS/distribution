# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020 Trond Haugland (trondah@gmail.com)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="pcsx_rearmed-lr"
PKG_VERSION="06cdf83a3a30bfb8cafee768dbe83bbaef6c8ddd"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="ARM optimized PCSX fork"
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  sed -i 's/\-O[23]/-Ofast/' ${PKG_BUILD}/Makefile
}

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
  case ${TARGET_ARCH} in
    aarch64)
      makeinstall_target32 pcsx_rearmed
    ;;
  esac
}
