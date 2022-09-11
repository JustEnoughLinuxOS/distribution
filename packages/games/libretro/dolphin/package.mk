# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="dolphin"
PKG_VERSION="016a5926aeda89087a073b1e6d245396da4b2256"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_DEPENDS_TARGET="toolchain libevdev libdrm ffmpeg zlib libpng lzo libusb"
PKG_SITE="https://github.com/libretro/dolphin"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="libretro"
PKG_SHORTDESC="Dolphin Libretro, a Gamecube & Wii emulator core for Retroarch"
PKG_TOOLCHAIN="cmake"

pre_configure_target() {
        PKG_CMAKE_OPTS_TARGET+="        -DENABLE_EGL=ON \
                                        -DUSE_SHARED_ENET=OFF \
                                        -DUSE_UPNP=ON \
                                        -DENABLE_NOGUI=ON \
                                        -DENABLE_QT=OFF \
                                        -DENABLE_LTO=ON \
                                        -DENABLE_GENERIC=OFF \
                                        -DENABLE_HEADLESS=ON \
                                        -DENABLE_ALSA=ALSA \
                                        -DENABLE_PULSEAUDIO=ON \
                                        -DENABLE_LLVM=OFF \
                                        -DENABLE_TESTS=OFF \
                                        -DUSE_DISCORD_PRESENCE=OFF \
                                        -DLIBRETRO=ON"
                                        }

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp $PKG_BUILD/.$TARGET_NAME/dolphin_libretro.so $INSTALL/usr/lib/libretro/
}
