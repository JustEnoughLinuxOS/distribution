# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="moonlight"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/moonlight-stream/moonlight-"
PKG_DEPENDS_TARGET="toolchain opus SDL2 libevdev alsa curl enet avahi libvdpau libcec ffmpeg"
PKG_SHORTDESC="Moonlight is an open source implementation of NVIDIA's GameStream, as used by the NVIDIA Shield, but built for Linux."
GET_HANDLER_SUPPORT="git"
PKG_PATCH_DIRS+="${DEVICE}"

if [ "${TARGET_ARCH}" = "x86_64" ] 
then
  PKG_SITE+="qt"
  PKG_URL="${PKG_SITE}.git"
  PKG_VERSION="3d8de56f251ad8ec4a237c1b59091697e8973c3a"
  PKG_DEPENDS_TARGET+=" qt5"
  PKG_TOOLCHAIN="manual"
  make_target() {
    qmake "CONFIG+=embedded" moonlight-qt.pro
    make release
  }
  post_makeinstall_target() {
    mkdir -p ${INSTALL}/usr/bin
    mkdir -p ${INSTALL}/usr/config/modules
    cp ${PKG_BUILD}/app/moonlight ${INSTALL}/usr/bin/
    cp ${PKG_BUILD}/start_moonlight.sh ${INSTALL}/usr/bin/
    chmod +x ${INSTALL}/usr/bin/*
    mv ${INSTALL}/usr/bin/start_moonlight.sh ${INSTALL}/usr/config/modules/Start\ Moonlight.sh
  }
else
  PKG_SITE+="embedded"
  PKG_URL="${PKG_SITE}.git"
  PKG_VERSION="3b72f5195b6843be772a2eb6846ac10ceed39bf4"
  PKG_TOOLCHAIN="cmake"
  post_makeinstall_target() {
    mkdir -p ${INSTALL}/usr/config/moonlight
    cp -R ${PKG_BUILD}/moonlight.conf ${INSTALL}/usr/config/moonlight
    rm ${INSTALL}/usr/etc/moonlight.conf 
    rm ${INSTALL}/usr/share/moonlight/gamecontrollerdb.txt 
  }
fi

if [ "${PROJECT}" = "Rockchip" ]
then
  PKG_DEPENDS_TARGET+=" librga rkmpp"
fi

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]
  then
  PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers"
fi
