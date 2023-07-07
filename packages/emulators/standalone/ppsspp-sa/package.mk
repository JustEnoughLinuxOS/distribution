# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="ppsspp-sa"
PKG_REV="1"
PKG_ARCH="any"
PKG_SITE="https://github.com/hrydgard/ppsspp"
PKG_URL="${PKG_SITE}.git"
PKG_VERSION="3c1723947c6afd14c6a276af906d48518dfcd4ed"
PKG_LICENSE="GPLv2"
PKG_DEPENDS_TARGET="toolchain ffmpeg libzip SDL2 zlib zip"
PKG_SHORTDESC="PPSSPPDL"
PKG_LONGDESC="PPSSPP Standalone"
GET_HANDLER_SUPPORT="git"

PKG_PATCH_DIRS+="${DEVICE}"

PKG_CMAKE_OPTS_TARGET=" -DUSE_SYSTEM_FFMPEG=OFF \
                        -DCMAKE_BUILD_TYPE=Release \
                        -DCMAKE_SYSTEM_NAME=Linux \
                        -DBUILD_SHARED_LIBS=OFF \
                        -DUSE_SYSTEM_LIBPNG=OFF \
                        -DANDROID=OFF \
                        -DWIN32=OFF \
                        -DAPPLE=OFF \
                        -DCMAKE_CROSSCOMPILING=ON \
                        -DUSING_QT_UI=OFF \
                        -DUNITTEST=OFF \
                        -DSIMULATOR=OFF \
                        -DHEADLESS=OFF \
                        -DUSE_DISCORD=OFF"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd glew"
  PKG_CMAKE_OPTS_TARGET+=" -DUSING_FBDEV=OFF \
			   -DUSING_GLES2=OFF"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" -DUSING_FBDEV=ON \
                           -DUSING_EGL=OFF \
                           -DUSING_GLES2=ON \
			   -DVULKAN=OFF \
			   -DUSE_VULKAN_DISPLAY_KHR=OFF\
			   -DUSING_X11_VULKAN=OFF"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]
then
  PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_VULKAN_DISPLAY_KHR=ON \
                           -DVULKAN=ON \
                           -DEGL_NO_X11=1
                           -DMESA_EGL_NO_X11_HEADERS=1"
else
  PKG_CMAKE_OPTS_TARGET+=" -DVULKAN=OFF"
fi

if [ "${DISPLAYSERVER}" = "wl" ]; then
  PKG_DEPENDS_TARGET+=" wayland ${WINDOWMANAGER}"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_WAYLAND_WSI=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_WAYLAND_WSI=OFF"
fi

pre_configure_target() {
  sed -i 's/\-O[23]//g' ${PKG_BUILD}/CMakeLists.txt
  sed -i "s|include_directories(/usr/include/drm)|include_directories(${SYSROOT_PREFIX}/usr/include/drm)|" ${PKG_BUILD}/CMakeLists.txt
}

pre_make_target() {
  export CPPFLAGS="${CPPFLAGS} -Wno-error"
  export CFLAGS="${CFLAGS} -Wno-error"

  # fix cross compiling
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_DIR}/scripts/start_ppsspp.sh ${INSTALL}/usr/bin
  cp PPSSPPSDL ${INSTALL}/usr/bin/ppsspp
  chmod 0755 ${INSTALL}/usr/bin/*
  ln -sf /storage/.config/ppsspp/assets ${INSTALL}/usr/bin/assets
  mkdir -p ${INSTALL}/usr/config/ppsspp/PSP/SYSTEM
  cp -r `find . -name "assets" | xargs echo` ${INSTALL}/usr/config/ppsspp/
  cp -rf ${PKG_DIR}/config/* ${INSTALL}/usr/config/ppsspp/
  if [ -d "${PKG_DIR}/sources/${DEVICE}" ]
  then
    cp ${PKG_DIR}/sources/${DEVICE}/* ${INSTALL}/usr/config/ppsspp/PSP/SYSTEM
  fi
  rm ${INSTALL}/usr/config/ppsspp/assets/gamecontrollerdb.txt

  cp -f ${PKG_DIR}/fonts/* ${INSTALL}/usr/config/ppsspp/assets/
  cp -f ${PKG_DIR}/fonts/patch.jpn0.pgf ${INSTALL}/usr/config/ppsspp/assets/flash0/font/jpn0.pgf
  cp -f ${PKG_DIR}/fonts/patch.kr0.pgf ${INSTALL}/usr/config/ppsspp/assets/flash0/font/kr0.pgf
}
