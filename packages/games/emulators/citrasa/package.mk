# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="citrasa"
PKG_VERSION="8f2a5374c326eb75491eb2ac28add6a71b5b9b69"
PKG_LICENSE="MPLv2"
PKG_SITE="https://github.com/citra-emu/citra"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain ffmpeg mesa SDL2 boost zlib libusb boost zstd"
PKG_LONGDESC="Citra 3DS emulator"
PKG_TOOLCHAIN="cmake"
GET_HANDLER_SUPPORT="git"
PKG_PATCH_DIRS+="${DEVICE}"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]
then
  PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers citrasa-vulkan"
fi

pre_configure_target() {
PKG_CMAKE_OPTS_TARGET+="        -DENABLE_QT=OFF \
                                -DENABLE_QT_TRANSLATION=OFF \
                                -DENABLE_SDL2=ON \
                                -DUSE_DISCORD_PRESENCE=OFF"

}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_BUILD}/.${TARGET_NAME}/bin/MinSizeRel/citra ${INSTALL}/usr/bin/citra-gl
  cp ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin

  chmod +x ${INSTALL}/usr/bin/start_citra.sh

  mkdir -p ${INSTALL}/usr/config/citra-emu
  cp -rf ${PKG_DIR}/config/${DEVICE}/* ${INSTALL}/usr/config/citra-emu
}
