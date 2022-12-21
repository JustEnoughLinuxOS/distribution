# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="SDL2"
PKG_VERSION="2.26.1"
PKG_LICENSE="GPL"
PKG_SITE="https://www.libsdl.org/"
PKG_URL="https://www.libsdl.org/release/SDL2-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib systemd dbus pulseaudio libdrm"
PKG_LONGDESC="Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware."
PKG_DEPENDS_HOST="toolchain:host distutilscross:host"
PKG_PATCH_DIRS+="${DEVICE}"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu"
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_OPENGL=ON \
                           -DVIDEO_OPENGL=ON \
                           -DVIDEO_KMSDRM=OFF"
else
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_OPENGL=OFF \
                           -DVIDEO_OPENGL=OFF \
                           -DVIDEO_KMSDRM=OFF"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_OPENGLES=ON \
                           -DVIDEO_OPENGLES=ON \
                           -DVIDEO_KMSDRM=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_OPENGLES=OFF \
                           -DVIDEO_OPENGLES=OFF \
                           -DVIDEO_KMSDRM=OFF"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers"
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_VULKAN=ON \
                           -DVIDEO_OPENGL=OFF \
                           -DVIDEO_VULKAN=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_VULKAN=OFF \
                           -DVIDEO_VULKAN=OFF"
fi

if [ "${DISPLAYSERVER}" = "wl" ]
then
  PKG_DEPENDS_TARGET+=" wayland ${WINDOWMANAGER}"
  PKG_CMAKE_OPTS_TARGET+=" -DSDL_WAYLAND=ON \
                           -DVIDEO_WAYLAND=ON \
                           -DVIDEO_WAYLAND_QT_TOUCH=OFF \
                           -DWAYLAND_SHARED=ON \
                           -DVIDEO_X11=OFF \
                           -DSDL_X11=OFF \
			   -DSDL_HIDAPI_JOYSTICK=ON"
else
  PKG_CMAKE_OPTS_TARGET+=" -DVIDEO_WAYLAND=OFF \
                           -DVIDEO_WAYLAND_QT_TOUCH=ON \
                           -DWAYLAND_SHARED=OFF \
                           -DVIDEO_X11=OFF \
                           -DSDL_X11=OFF \
			   -DSDL_HIDAPI_JOYSTICK=OFF"
fi

case ${PROJECT} in
  Rockchip)
    PKG_DEPENDS_TARGET+=" librga"
    pre_make_host() {
      sed -i "s| -lrga||g" ${PKG_BUILD}/CMakeLists.txt
    }
    pre_make_target() {
      if ! `grep -rnw "${PKG_BUILD}/CMakeLists.txt" -e '-lrga'`; then
        sed -i "s|--no-undefined|--no-undefined -lrga|" ${PKG_BUILD}/CMakeLists.txt
      fi
    }
  ;;
esac

pre_configure_target(){
  export LDFLAGS="${LDFLAGS} -ludev"
  PKG_CMAKE_OPTS_TARGET+="-DSDL_STATIC=OFF \
                         -DLIBC=ON \
                         -DGCC_ATOMICS=ON \
                         -DALTIVEC=OFF \
                         -DOSS=OFF \
                         -DALSA=ON \
                         -DALSA_SHARED=ON \
                         -DJACK=OFF \
                         -DJACK_SHARED=OFF \
                         -DESD=OFF \
                         -DESD_SHARED=OFF \
                         -DARTS=OFF \
                         -DARTS_SHARED=OFF \
                         -DNAS=OFF \
                         -DNAS_SHARED=OFF \
                         -DLIBSAMPLERATE=OFF \
                         -DLIBSAMPLERATE_SHARED=OFF \
                         -DSNDIO=OFF \
                         -DDISKAUDIO=OFF \
                         -DDUMMYAUDIO=OFF \
                         -DVIDEO_X11=OFF \
                         -DVIDEO_MIR=OFF \
                         -DMIR_SHARED=OFF \
                         -DVIDEO_COCOA=OFF \
                         -DVIDEO_DIRECTFB=OFF \
                         -DVIDEO_VIVANTE=OFF \
                         -DDIRECTFB_SHARED=OFF \
                         -DFUSIONSOUND=OFF \
                         -DFUSIONSOUND_SHARED=OFF \
                         -DVIDEO_DUMMY=OFF \
                         -DINPUT_TSLIB=OFF \
                         -DPTHREADS=ON \
                         -DPTHREADS_SEM=ON \
                         -DDIRECTX=OFF \
                         -DSDL_DLOPEN=ON \
                         -DCLOCK_GETTIME=OFF \
                         -DRPATH=OFF \
                         -DRENDER_D3D=OFF \
                         -DPULSEAUDIO=ON"
}

post_makeinstall_target() {
  sed -e "s:\(['=LI]\)/usr:\\1${SYSROOT_PREFIX}/usr:g" -i ${SYSROOT_PREFIX}/usr/bin/sdl2-config
  rm -rf ${INSTALL}/usr/bin
}
