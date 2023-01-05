# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2022-present Fewtarius
PKG_NAME="PPSSPPSDL"
PKG_VERSION="5f10cabe5a0a4442e642d473f360e309288dd5f4"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/hrydgard/ppsspp"
PKG_URL="https://github.com/hrydgard/ppsspp.git"
PKG_DEPENDS_TARGET="toolchain ffmpeg libzip SDL2 zlib zip"
PKG_SHORTDESC="PPSSPPDL"
PKG_LONGDESC="PPSSPP Standalone"
GET_HANDLER_SUPPORT="git"
PKG_BUILD_FLAGS="+lto"

PKG_PATCH_DIRS+="${DEVICE}"

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

PKG_CMAKE_OPTS_TARGET+="${PKG_CMAKE_OPTS_TARGET} \
			-DUSE_SYSTEM_FFMPEG=OFF \
			-DCMAKE_BUILD_TYPE=Release \
			-DCMAKE_SYSTEM_NAME=Linux \
			-DBUILD_SHARED_LIBS=OFF \
			-DANDROID=OFF \
			-DWIN32=OFF \
			-DAPPLE=OFF \
			-DCMAKE_CROSSCOMPILING=ON \
			-DUSING_QT_UI=OFF \
			-DUNITTEST=OFF \
			-DSIMULATOR=OFF \
			-DHEADLESS=OFF \
			-DUSE_DISCORD=OFF"

pre_configure_target() {
  sed -i "s|include_directories(/usr/include/drm)|include_directories(${SYSROOT_PREFIX}/usr/include/drm)|" $PKG_BUILD/CMakeLists.txt
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
  cp ${PKG_DIR}/sources/start_PPSSPPSDL.sh ${INSTALL}/usr/bin
  cp `find . -name "PPSSPPSDL" | xargs echo` ${INSTALL}/usr/bin/PPSSPPSDL
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
}
