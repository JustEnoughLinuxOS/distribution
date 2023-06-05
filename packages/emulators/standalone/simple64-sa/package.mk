# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present RiShooty (https://github.com/rishooty)

PKG_NAME="simple64-sa"
PKG_VERSION="23107ed09a091b890c008fa71a69fc0a0ccc54cc"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/simple64/simple64"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain qt5 mupen64plus-sa-core mupen64plus-sa-input-sdl"
PKG_LONGDESC="Simple64, a N64 Emulator"
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  case ${ARCH} in
    aarch64|arm)
      export HOST_CPU=aarch64
      find . -type f -name CMakeLists.txt -exec sed -i 's/x86-64-v3/armv8-a/g' {} \;
    ;;
    x86_64)
      export HOST_CPU=x86_64
    ;;
  esac
}

make_target() {
  cd ${PKG_BUILD}
  ./build.sh
}

makeinstall_target() {
  # Install the main library with a slightly different name from base mupen
  mkdir -p ${INSTALL}/usr/local/lib
  cp ${PKG_BUILD}/simple64/libmupen64plus.so ${INSTALL}/usr/local/lib/libsimple64.so
  chmod 644 ${INSTALL}/usr/local/lib/libsimple64.so

  # Install the rest of the libraries
  mkdir -p ${INSTALL}/usr/local/lib/mupen64plus
  #${STRIP} ${PKG_BUILD}/simple64/simple64-audio-sdl2.so
  cp ${PKG_BUILD}/simple64/simple64-audio-sdl2.so ${INSTALL}/usr/local/lib/mupen64plus
  #${STRIP} ${PKG_BUILD}/simple64/simple64-rsp-parallel.so
  cp ${PKG_BUILD}/simple64/simple64-rsp-parallel.so ${INSTALL}/usr/local/lib/mupen64plus
  #${STRIP} ${PKG_BUILD}/simple64/simple64-video-parallel.so
  cp ${PKG_BUILD}/simple64/simple64-video-parallel.so ${INSTALL}/usr/local/lib/mupen64plus
  chmod 0644 ${INSTALL}/usr/local/lib/mupen64plus/*

  # Install additional files it needs to the share
  mkdir -p ${INSTALL}/usr/local/share/mupen64plus
  cp ${PKG_DIR}/config/simple64-gui.ini ${INSTALL}/usr/local/share/mupen64plus
  cp ${PKG_BUILD}/simple64/pif.ntsc.rom ${INSTALL}/usr/local/share/mupen64plus
  cp ${PKG_BUILD}/simple64/pif.pal.rom ${INSTALL}/usr/local/share/mupen64plus
  chmod 0644 ${INSTALL}/usr/local/share/mupen64plus/*


  # Install the main executable
  mkdir -p ${INSTALL}/usr/local/bin
  cp ${PKG_BUILD}/simple64/simple64-gui ${INSTALL}/usr/local/bin
  chmod 0755 ${INSTALL}/usr/local/bin/simple64-gui
}