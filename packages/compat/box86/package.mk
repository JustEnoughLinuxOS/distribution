# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2023-present Fewtarius

PKG_NAME="box86"
PKG_VERSION="a320c37681043854e56c55fb652c04f2e3f35ecc"
PKG_ARCH="arm aarch64"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/ptitSeb/box86"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain gl4es ncurses SDL_sound"
PKG_LONGDESC="Box86 lets you run x86 Linux programs (such as games) on non-x86 Linux systems, like ARM."
PKG_TOOLCHAIN="cmake"


PKG_CMAKE_OPTS_TARGET+=" -DCMAKE_BUILD_TYPE=Release"

case ${TARGET_ARCH} in
  aarch64)
    make_target() {
      true
    }
  ;;
esac

makeinstall_target() {
  case ${TARGET_ARCH} in
    arm)
      mkdir -p ${INSTALL}/usr/share/box86/lib
      cp ${PKG_BUILD}/x86lib/* ${INSTALL}/usr/share/box86/lib

      mkdir -p ${INSTALL}/usr/bin
      cp ${PKG_BUILD}/.${TARGET_NAME}/box86 ${INSTALL}/usr/bin/
      cp ${PKG_BUILD}/tests/bash ${INSTALL}/usr/bin/bash-x86
    ;;
    aarch64)
      mkdir -p ${INSTALL}/usr/share/box86/lib
      cp -vP ${ROOT}/build.${DISTRO}-${DEVICE}.arm/${PKG_NAME}-*/.install_pkg/usr/share/box86/lib/* ${INSTALL}/usr/share/box86/lib

      mkdir -p ${INSTALL}/usr/bin
      cp -vP ${ROOT}/build.${DISTRO}-${DEVICE}.arm/${PKG_NAME}-*/.install_pkg/usr/bin/* ${INSTALL}/usr/bin
      cp -vP ${ROOT}/build.${DISTRO}-${DEVICE}.arm/${PKG_NAME}-*/tests/bash ${INSTALL}/usr/bin/bash-x86
    ;;
  esac

  mkdir -p ${INSTALL}/usr/config
  cp ${PKG_DIR}/config/box86.box86rc ${INSTALL}/usr/config/box86.box86rc

  mkdir -p ${INSTALL}/etc
  ln -sf /storage/.config/box86.box86rc ${INSTALL}/etc/box86.box86rc

  mkdir -p ${INSTALL}/etc/binfmt.d
  cp -f ${PKG_DIR}/config/box86.conf ${INSTALL}/etc/binfmt.d/box86.conf
}
