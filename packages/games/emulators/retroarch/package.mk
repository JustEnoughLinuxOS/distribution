# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)

PKG_NAME="retroarch"
PKG_VERSION="3aa1811ca911d39ef8eac3a37dff12291a119a99"
PKG_SITE="https://github.com/libretro/RetroArch"
PKG_URL="${PKG_SITE}.git"
PKG_LICENSE="GPLv3"
PKG_DEPENDS_TARGET="toolchain SDL2 alsa-lib openssl freetype zlib retroarch-assets core-info ffmpeg libass joyutils empty nss-mdns openal-soft libogg libvorbisidec libvorbis libvpx libpng libdrm pulseaudio miniupnpc flac"
PKG_LONGDESC="Reference frontend for the libretro API."
GET_HANDLER_SUPPORT="git"

PKG_PATCH_DIRS+=" ${DEVICE}"

pre_configure_target() {
  TARGET_CONFIGURE_OPTS=""
  PKG_CONFIGURE_OPTS_TARGET="	--disable-qt \
				--enable-alsa \
				--enable-udev \
				--disable-opengl1 \
				--disable-opengl \
				--disable-wayland \
				--disable-x11 \
				--enable-zlib \
				--enable-freetype \
				--disable-discord \
				--disable-vg \
				--disable-sdl \
				--enable-sdl2 \
				--enable-ffmpeg"

  case ${ARCH} in
    arm)
      PKG_DEPENDS_TARGET+=" ${OPENGLES}"
      PKG_CONFIGURE_OPTS_TARGET+=" --enable-neon --enable-opengles --enable-opengles3 --enable-opengles3_2 --enable-kms --disable-mali_fbdev"
    ;;
    aarch64)
      PKG_DEPENDS_TARGET+=" ${OPENGLES}"
      PKG_CONFIGURE_OPTS_TARGET+=" --disable-neon --enable-opengles --enable-opengles3 --enable-opengles3_2 --enable-kms --disable-mali_fbdev"
    ;;
    *)
      PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd vulkan-loader vulkan-headers"
      PKG_CONFIGURE_OPTS_TARGET+=" --enable-opengl --enable-vulkan --enable-vulkan_display"
  esac

  case ${PROJECT} in
    Rockchip)
      PKG_DEPENDS_TARGET+=" librga libgo2"
      PKG_CONFIGURE_OPTS_TARGET+=" --enable-odroidgo2"
    ;;
  esac

  cd ${PKG_BUILD}
}

make_target() {
  make HAVE_UPDATE_ASSETS=0 HAVE_LIBRETRODB=1 HAVE_BLUETOOTH=0 HAVE_NETWORKING=1 HAVE_ZARCH=1 HAVE_QT=0 HAVE_LANGEXTRA=1
  [ $? -eq 0 ] && echo "(retroarch ok)" || { echo "(retroarch failed)" ; exit 1 ; }
  make -C gfx/video_filters compiler=$CC extra_flags="$CFLAGS"
  [ $? -eq 0 ] && echo "(video filters ok)" || { echo "(video filters failed)" ; exit 1 ; }
  make -C libretro-common/audio/dsp_filters compiler=$CC extra_flags="$CFLAGS"
  [ $? -eq 0 ] && echo "(audio filters ok)" || { echo "(audio filters failed)" ; exit 1 ; }
}

makeinstall_target() {
  if [ "${ARCH}" == "aarch64" ]; then
    mkdir -p ${INSTALL}/usr/bin
    cp ${PKG_BUILD}/retroarch ${INSTALL}/usr/bin
    cp -vP ${ROOT}/build.${DISTRO}-${DEVICE}.arm/retroarch-*/.install_pkg/usr/bin/retroarch ${INSTALL}/usr/bin/retroarch32

    mkdir -p ${INSTALL}/usr/share/retroarch/filters
    cp -rvP ${ROOT}/build.${DISTRO}-${DEVICE}.arm/retroarch-*/.install_pkg/usr/share/retroarch/filters/* ${INSTALL}/usr/share/retroarch/filters

    mkdir -p ${INSTALL}/etc
    cp ${PKG_BUILD}/retroarch.cfg ${INSTALL}/etc

    mkdir -p ${INSTALL}/usr/share/retroarch/filters/64bit/video
    cp ${PKG_BUILD}/gfx/video_filters/*.so ${INSTALL}/usr/share/retroarch/filters/64bit/video
    cp ${PKG_BUILD}/gfx/video_filters/*.filt ${INSTALL}/usr/share/retroarch/filters/64bit/video

    mkdir -p ${INSTALL}/usr/share/retroarch/filters/64bit/audio
    cp ${PKG_BUILD}/libretro-common/audio/dsp_filters/*.so ${INSTALL}/usr/share/retroarch/filters/64bit/audio
    cp ${PKG_BUILD}/libretro-common/audio/dsp_filters/*.dsp ${INSTALL}/usr/share/retroarch/filters/64bit/audio

    # General configuration
    mkdir -p ${INSTALL}/usr/config/retroarch/
    if [ -d "${PKG_DIR}/sources/${DEVICE}" ]; then
		cp -rf ${PKG_DIR}/sources/${DEVICE}/* ${INSTALL}/usr/config/retroarch/
	else
		cp -rf ${PKG_DIR}/sources/* ${INSTALL}/usr/config/retroarch/
	fi
  else
    mkdir -p ${INSTALL}/usr/bin
    cp ${PKG_BUILD}/retroarch ${INSTALL}/usr/bin

    mkdir -p ${INSTALL}/usr/share/retroarch/filters/32bit/video
    cp ${PKG_BUILD}/gfx/video_filters/*.so ${INSTALL}/usr/share/retroarch/filters/32bit/video
    cp ${PKG_BUILD}/gfx/video_filters/*.filt ${INSTALL}/usr/share/retroarch/filters/32bit/video

    mkdir -p ${INSTALL}/usr/share/retroarch/filters/32bit/audio
    cp ${PKG_BUILD}/libretro-common/audio/dsp_filters/*.so ${INSTALL}/usr/share/retroarch/filters/32bit/audio
    cp ${PKG_BUILD}/libretro-common/audio/dsp_filters/*.dsp ${INSTALL}/usr/share/retroarch/filters/32bit/audio
  fi
}

post_install() {
  mkdir -p ${INSTALL}/etc/retroarch-joypad-autoconfig
  cp -r ${PKG_DIR}/gamepads/device/${DEVICE}/* ${INSTALL}/etc/retroarch-joypad-autoconfig

  enable_service tmp-cores.mount
  enable_service tmp-joypads.mount
  enable_service tmp-database.mount
  enable_service tmp-assets.mount
  enable_service tmp-shaders.mount
  enable_service tmp-overlays.mount
}
