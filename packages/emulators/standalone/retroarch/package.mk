# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)
# Copyright (C) 2023-present Fewtarius

PKG_NAME="retroarch"
PKG_VERSION="8844c991e104eff909dfebf9c013f6a97afa0325"
PKG_SITE="https://github.com/libretro/RetroArch"
PKG_URL="${PKG_SITE}.git"
PKG_LICENSE="GPLv3"
PKG_DEPENDS_TARGET="toolchain SDL2 alsa-lib libass openssl freetype zlib retroarch-assets core-info ffmpeg libass joyutils empty nss-mdns openal-soft libogg libvorbisidec libvorbis libvpx libpng libdrm pulseaudio miniupnpc flac"
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
				--disable-opengles \
				--disable-opengles3 \
				--disable-opengles3_2 \
				--disable-wayland \
				--disable-x11 \
				--enable-zlib \
				--enable-freetype \
				--disable-discord \
				--disable-vg \
				--disable-sdl \
				--enable-sdl2 \
				--enable-ffmpeg"

  case ${DEVICE} in
    RK3566-X55)
      PKG_DEPENDS_TARGET+=" librga libgo2"
      PKG_CONFIGURE_OPTS_TARGET+=" --enable-odroidgo2"
    ;;
    *)
      PKG_CONFIGURE_OPTS_TARGET+=" --disable-odroidgo2"
    ;;
  esac

  case ${ARCH} in
    arm)
      PKG_CONFIGURE_OPTS_TARGET+=" --enable-neon"
    ;;
    aarch64)
      PKG_CONFIGURE_OPTS_TARGET+=" --disable-neon"
    ;;
    *)
  esac

  if [ "${DISPLAYSERVER}" = "wl" ]; then
    PKG_DEPENDS_TARGET+=" wayland ${WINDOWMANAGER}"
    PKG_CONFIGURE_OPTS_TARGET+=" --enable-wayland"
  fi

  if [ ! "${OPENGL}" = "no" ]; then
      PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
      PKG_CONFIGURE_OPTS_TARGET+=" --enable-opengl"
  else
      PKG_CONFIGURE_OPTS_TARGET+=" --disable-opengl"
  fi

  if [ "${OPENGLES_SUPPORT}" = yes ] && \
     [[ ! "${ARCH}" =~ i*86|x86_64 ]]; then
      PKG_DEPENDS_TARGET+=" ${OPENGLES}"
      PKG_CONFIGURE_OPTS_TARGET+=" --enable-opengles --enable-opengles3 --enable-opengles3_2 --enable-kms"
  else
      PKG_CONFIGURE_OPTS_TARGET+=" --disable-opengles --disable-opengles3 --disable-opengles3_2"
  fi

  if [ "${VULKAN_SUPPORT}" = "yes" ]
  then
      PKG_DEPENDS_TARGET+=" vulkan-loader vulkan-headers"
      PKG_CONFIGURE_OPTS_TARGET+=" --enable-vulkan --enable-vulkan_display"
  fi

  cd ${PKG_BUILD}
}

pre_build_target() {
    sed -e 's/RETRO_LANGUAGE_KOREAN/RETRO_LANGUAGE_GREEK/g' \
        -i ${PKG_BUILD}/menu/drivers/ozone.c
    sed -e 's/RETRO_LANGUAGE_KOREAN/RETRO_LANGUAGE_GREEK/g' \
        -i ${PKG_BUILD}/menu/drivers/materialui.c
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
  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_BUILD}/retroarch ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/usr/share/retroarch/filters

  cp ${PKG_DIR}/scripts/mkcontroller ${INSTALL}/usr/bin

  case ${ARCH} in
    aarch64)
      if [ -f ${ROOT}/build.${DISTRO}-${DEVICE}.arm/retroarch-*/.install_pkg/usr/bin/retroarch ]; then
        cp -vP ${ROOT}/build.${DISTRO}-${DEVICE}.arm/retroarch-*/.install_pkg/usr/bin/retroarch ${INSTALL}/usr/bin/retroarch32
        mkdir -p ${INSTALL}/usr/share/retroarch/filters/32bit/
        cp -rvP ${ROOT}/build.${DISTRO}-${DEVICE}.arm/retroarch-*/.install_pkg/usr/share/retroarch/filters/64bit/* ${INSTALL}/usr/share/retroarch/filters/32bit/
      fi
    ;;
  esac

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
    sed -i \
        -e 's/menu_driver.*/menu_driver = "ozone"/g' \
        -e 's/ozone_collapse_sidebar.*/ozone_collapse_sidebar = "true"/g' \
        -e 's/user_language.*/user_language = "10"/g' \
        ${INSTALL}/usr/config/retroarch/retroarch.cfg
  else
    echo "Configure retroarch for ${DEVICE}"
    exit 1
  fi

  # Make sure the shader directories exist for overlayfs.
  for dir in common-shaders glsl-shaders slang-shaders
  do
    mkdir -p ${INSTALL}/usr/share/${dir}
    touch ${INSTALL}/usr/share/${dir}/.overlay
  done
}

post_install() {
  enable_service tmp-cores.mount
  enable_service tmp-database.mount
  enable_service tmp-assets.mount
  enable_service tmp-shaders.mount
  enable_service tmp-overlays.mount
}
