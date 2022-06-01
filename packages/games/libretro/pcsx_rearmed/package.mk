# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020 Trond Haugland (trondah@gmail.com)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="pcsx_rearmed"
PKG_VERSION="7dee1e8e9e0c5606f237e487efbd0c5fe6154b3f"
PKG_SHA256="5999f81dca882c49eaa76a2ee198f996b49cabbd40f1e927ea046697f2f95d21"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="ARM optimized PCSX fork"
PKG_TOOLCHAIN="manual"
PKG_PATCH_DIRS+="${TARGET_ARCH}/${DEVICE}"

make_target() {
  cd ${PKG_BUILD}
  if [[ "${DEVICE}" =~ RG351 ]]
  then
    make -f Makefile.libretro GIT_VERSION=${PKG_VERSION} platform=RG351x
  else
    make -f Makefile.libretro GIT_VERSION=${PKG_VERSION} platform=${DEVICE}
  fi
}

makeinstall_target() {
  ## Install the 64bit core.
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp pcsx_rearmed_libretro.so ${INSTALL}/usr/lib/libretro/
  ## Install the 32bit core.
  cp -vP ${PKG_BUILD}/../../build.${DISTRO}-${DEVICE}.arm/pcsx_rearmed-*/.install_pkg/usr/lib/libretro/pcsx_rearmed_libretro.so ${INSTALL}/usr/lib/libretro/pcsx_rearmed32_libretro.so
}
