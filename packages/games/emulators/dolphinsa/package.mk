# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="dolphinsa"
PKG_VERSION="0b160db48796f727311cea16072174d96b784f80"
PKG_GIT_CLONE_BRANCH="egldrm"
PKG_ARCH="aarch64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/rtissera/dolphin"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain libevdev libdrm ffmpeg zlib libpng lzo libusb"
PKG_LONGDESC="Dolphin is a GameCube / Wii emulator, allowing you to play games for these two platforms on PC with improvements. "

PKG_CMAKE_OPTS_TARGET=" -DENABLE_HEADLESS=ON \
                        -DENABLE_EGL=ON \
                        -DENABLE_EVDEV=ON \
                        -DLINUX_LOCAL_DEV=ON \
                        -DOpenGL_GL_PREFERENCE=GLVND \
                        -DENABLE_TESTS=OFF \
                        -DENABLE_LLVM=OFF \
                        -DENABLE_ANALYTICS=OFF \
                        -DENABLE_X11=OFF \
                        -DENABLE_LTO=ON \
                        -DENABLE_QT=OFF \
                        -DENCODE_FRAMEDUMPS=OFF"

makeinstall_target() {
mkdir -p $INSTALL/usr/bin
cp -rf $PKG_BUILD/.${TARGET_NAME}/Binaries/dolphin* $INSTALL/usr/bin
cp -rf $PKG_DIR/scripts/* $INSTALL/usr/bin

chmod +x ${INSTALL}/usr/bin/dolphin.sh

mkdir -p $INSTALL/usr/config/dolphin-emu
cp -rf $PKG_BUILD/Data/Sys/* $INSTALL/usr/config/dolphin-emu
cp -rf $PKG_DIR/config/* $INSTALL/usr/config/dolphin-emu
}
