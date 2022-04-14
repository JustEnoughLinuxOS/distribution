# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="jelos"
PKG_VERSION="$(date +%Y%m%d)"
PKG_ARCH="any"
PKG_LICENSE="apache2"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain ${OPENGLES}"
PKG_SHORTDESC="JELOS Meta Package"
PKG_LONGDESC="JELOS Meta Package"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_TOOLCHAIN="make"

PKG_BASEOS="plymouth-lite grep wget libjpeg-turbo util-linux xmlstarlet bluetool gnupg gzip patchelf     \
            imagemagick terminus-font vim bash pyudev dialog six git dbus-python coreutils miniupnpc \
            nss-mdns avahi MC fbgrab modules"

PKG_UI="emulationstation"

PKG_EMUS="common-shaders glsl-shaders libretro-database retroarch hatarisa openbor  \
          scummvmsa PPSSPPSDL yabasanshiroSA vicesa mupen64plussa-audio-sdl         \
          mupen64plussa-input-sdl mupen64plussa-ui-console mupen64plussa-video-rice \
          mupen64plussa-core mupen64plussa-rsp-hle mupen64plussa-video-glide64mk2   \
          lzdoom gzdoom ecwolf amiberry raze pico-8 drastic flycastsa"

LIBRETRO_CORES="2048 81 a5200 atari800 beetle-gba beetle-lynx beetle-ngp beetle-pce beetle-pcfx      \
                beetle-supafaust beetle-supergrafx beetle-vb beetle-wswan bluemsx cannonball cap32   \
                crocods daphne dinothawr dosbox-svn dosbox-pure duckstation easyrpg fbalpha2012      \
                fbalpha2019 fbneo fceumm fmsx flycast flycast_libretro freechaf freeintv  \
                freej2me fuse-libretro gambatte gearboy gearcoleco gearsystem genesis-plus-gx        \
                genesis-plus-gx-wide gme gpsp gw-libretro handy hatari mame2000 mame2003-plus        \
                mame2010 mame2015 mame meowpc98 mgba mrboom mupen64plus mupen64plus-nx               \
                neocd_libretro nestopia np2kai nxengine o2em opera parallel-n64_rice                 \
                parallel-n64_gln64 parallel-n64_glide64 pcsx_rearmed picodrive pokemini potator      \
                ppsspp prboom prosystem puae px68k quasi88 quicknes race reminiscence sameboy        \
                sameduck scummvm smsplus-gx snes9x snes9x2002 snes9x2005_plus snes9x2010 stella      \
                stella-2014 swanstation TIC-80 tgbdual tyrquake xrick uae4arm uzem vba-next vbam     \
                vecx vice yabasanshiro xmil"

PKG_COMPAT="lib32"

PKG_MULTIMEDIA="ffmpeg mpv vlc"

PKG_GAMESUPPORT="sixaxis jslisten evtest rg351p-js2xbox gptokeyb textviewer 351files jstest-sdl \
                 gamecontrollerdb jelosaddons libgo2 rclone"

PKG_EXPERIMENTAL=""

### Project/Device specific items
if [ "${PROJECT}" == "Rockchip" ]
then
  PKG_BASEOS+=" system-utils"
  PKG_EMUS+=" retropie-shaders"
fi

if [ ! -z "${BASE_ONLY}" ]
then
  PKG_DEPENDS_TARGET+=" ${PKG_BASEOS} ${PKG_UI} ${PKG_GAMESUPPORT}"
else
  PKG_DEPENDS_TARGET+=" ${PKG_BASEOS} ${PKG_UI} ${PKG_EMUS} ${LIBRETRO_CORES} ${PKG_COMPAT} ${PKG_MULTIMEDIA} ${PKG_GAMESUPPORT} ${PKG_EXPERIMENTAL}"
fi

make_target() {
  :
}

makeinstall_target() {

  mkdir -p ${INSTALL}/usr/config/
  rsync -av ${PKG_DIR}/config/* ${INSTALL}/usr/config/
  ln -sf /storage/.config/system ${INSTALL}/system
  find ${INSTALL}/usr/config/system/ -type f -exec chmod o+x {} \;

  mkdir -p ${INSTALL}/usr/bin/

  ## Compatibility links for ports
  ln -s /storage/roms ${INSTALL}/roms
  ln -sf /storage/roms/opt ${INSTALL}/opt

}

post_install() {
  ln -sf jelos.target ${INSTALL}/usr/lib/systemd/system/default.target

  mkdir -p ${INSTALL}/etc/profile.d
  cp ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/device.config ${INSTALL}/etc/profile.d/01-deviceconfig

  # Split this up into other packages
  cp ${PKG_DIR}/sources/autostart/autostart ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/usr/lib/autostart/common
  mkdir -p ${INSTALL}/usr/lib/autostart/daemons
  cp ${PKG_DIR}/sources/autostart/common/* ${INSTALL}/usr/lib/autostart/common
  cp ${PKG_DIR}/sources/autostart/daemons/* ${INSTALL}/usr/lib/autostart/daemons
  if [ -d "${PKG_DIR}/sources/autostart/${DEVICE}" ]
  then
    mkdir -p ${INSTALL}/usr/lib/autostart/${DEVICE}
    cp ${PKG_DIR}/sources/autostart/${DEVICE}/* ${INSTALL}/usr/lib/autostart/${DEVICE}
  fi
  chmod -R 0755 ${INSTALL}/usr/lib/autostart ${INSTALL}/usr/bin/autostart
  enable_service jelos-autostart.service

  if [ ! -d "${INSTALL}/usr/share" ]
  then
    mkdir "${INSTALL}/usr/share"
  fi
  cp ${PKG_DIR}/sources/post-update ${INSTALL}/usr/share
  chmod 755 ${INSTALL}/usr/share/post-update

  # Issue banner
  cp ${PKG_DIR}/sources/issue ${INSTALL}/etc
  ln -s /etc/issue ${INSTALL}/etc/motd
  cat <<EOF >> ${INSTALL}/etc/issue
==> Build Date: ${BUILD_DATE}
==> Version: ${OS_VERSION}

EOF

  cp ${PKG_DIR}/sources/shutdown.sh ${INSTALL}/usr/bin
  cp ${PKG_DIR}/sources/scripts/* ${INSTALL}/usr/bin

  if [ -d "${PKG_DIR}/sources/asound/${DEVICE}" ]
  then
    cp ${PKG_DIR}/sources/asound/${DEVICE}/* ${INSTALL}/usr/config/
  fi

  sed -i "s#@DEVICENAME@#${DEVICE}#g" ${INSTALL}/usr/config/system/configs/system.cfg

  if [[ "${DEVICE}" =~ RG351P ]]
  then
    sed -i "s#.integerscale=1#.integerscale=0#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#.rgascale=0#.rgascale=1#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#audio.volume=.*\$#audio.volume=100#g" ${INSTALL}/usr/config/system/configs/system.cfg
  fi
}
