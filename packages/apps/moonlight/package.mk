# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Fewtarius

PKG_NAME="moonlight"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SHORTDESC="Moonlight is an open source implementation of NVIDIA's GameStream, as used by the NVIDIA Shield, but built for Linux."
PKG_DEPENDS_TARGET="toolchain opus SDL2 libevdev alsa curl enet avahi libvdpau libcec ffmpeg"

case ${DEVICE} in
  AMD64)
    PKG_DEPENDS_TARGET+=" qt5 SDL2_ttf"
    PKG_SITE="https://github.com/moonlight-stream/moonlight-qt"
    PKG_URL="${PKG_SITE}.git"
    PKG_VERSION="fee54a9d765d6121c831cdaac90aff490824231f"
    PKG_TOOLCHAIN="manual"

    pre_make_target() {
      git submodule update --init --recursive
      qmake "CONFIG+=embedded" moonlight-qt.pro
    }

    make_target() {
      make release
    }

    post_makeinstall_target() {
      mkdir -p ${INSTALL}/usr/bin
      cp ${PKG_BUILD}/app/moonlight ${INSTALL}/usr/bin/
    }
  ;;
  *)
    PKG_SITE="https://github.com/moonlight-stream/moonlight-embedded"
    PKG_URL="${PKG_SITE}.git"
    PKG_VERSION="36c1636f3c77345e6439f848def9a4f917e25834"
    PKG_TOOLCHAIN="cmake"
    
    post_makeinstall_target() {
      mkdir -p ${INSTALL}/usr/config/moonlight
      cp -R ${PKG_BUILD}/moonlight.conf ${INSTALL}/usr/config/moonlight
      rm ${INSTALL}/usr/etc/moonlight.conf 
      rm ${INSTALL}/usr/share/moonlight/gamecontrollerdb.txt 
    }
  ;;
esac

GET_HANDLER_SUPPORT="git"
PKG_PATCH_DIRS+="${DEVICE}"

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
