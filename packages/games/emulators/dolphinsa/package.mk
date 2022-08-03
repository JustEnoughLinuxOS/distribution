# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Brooksytech (https://github.com/brooksytech)

PKG_NAME="dolphinsa"
PKG_VERSION="7d2d5d914bf3cacbecbb0bf8a642b616744aad54"
PKG_ARCH="aarch64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/dolphin-emu/dolphin"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain libevdev libdrm"
PKG_LONGDESC="Dolphin is a GameCube / Wii emulator, allowing you to play games for these two platforms on PC with improvements. "

PKG_CMAKE_OPTS_TARGET=" -DENABLE_HEADLESS=ON -DENABLE_EGL=ON -DENABLE_EVDEV=ON -DLINUX_LOCAL_DEV=ON -DOpenGL_GL_PREFERENCE=GLVND \
                        -DENABLE_TESTS=OFF -DENABLE_LLVM=OFF -DENABLE_ANALYTICS=OFF -DENABLE_X11=OFF -DENCODE_FRAMEDUMPS=OFF -DENABLE_QT=OFF"

makeinstall_target() {
mkdir -p $INSTALL/usr/bin
cp -rf $PKG_BUILD/.${TARGET_NAME}/Binaries/dolphin* $INSTALL/usr/bin
#cp -rf $PKG_DIR/scripts/* $INSTALL/usr/bin

mkdir -p $INSTALL/storage/.config/dolphin-emu
cp -rf $PKG_BUILD/Data/Sys/* $INSTALL/storage/.config/dolphin-emu
#cp -rf $PKG_DIR/config/* $INSTALL/usr/config/emuelec/configs/dolphin-emu
}
