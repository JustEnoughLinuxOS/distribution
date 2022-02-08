# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="jelos"
PKG_VERSION="${OS_VERSION}"
PKG_ARCH="any"
PKG_LICENSE="proprietary"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain ${OPENGLES}"
PKG_SHORTDESC="JELOS Meta Package"
PKG_LONGDESC="JELOS Meta Package"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_TOOLCHAIN="make"

PKG_UI="emulationstation"

BASE_PACKAGES="plymouth-lite grep wget ffmpeg libjpeg-turbo MC util-linux xmlstarlet jslisten git \
               gnupg gzip patchelf imagemagick system-utils terminus-font vim bash pyudev dialog  \
               dbus-python pygobject coreutils dialog six textviewer bluetool"

LIBRETRO_CORES="2048 81 atari800 beetle-gba beetle-lynx beetle-ngp beetle-pce beetle-pcfx          \
                beetle-supafaust beetle-supergrafx beetle-vb beetle-wswan bluemsx cannonball       \
                cap32 crocods daphne dinothawr dosbox-svn dosbox-pure easyrpg fbalpha2012          \
                fbalpha2019 fbneo fceumm fmsx flycast freechaf freeintv freej2me fuse-libretro     \
                gambatte gearboy gearcoleco gearsystem genesis-plus-gx genesis-plus-gx-wide gme    \
                gpsp gw-libretro handy hatari mame2000 mame2003-plus mame2010 mame2015 mame        \
                meowpc98 mgba mrboom mupen64plus mupen64plus-nx neocd_libretro nestopia np2kai     \
                nxengine o2em opera parallel-n64 parallel-n64_gln64 pcsx_rearmed picodrive         \
                pokemini potator ppsspp prboom prosystem puae px68k quasi88 quicknes race          \
                reminiscence sameboy sameduck scummvm smsplus-gx snes9x snes9x2002 snes9x2005_plus \
                snes9x2010 stella stella-2014 swanstation TIC-80 tgbdual tyrquake xrick uae4arm    \
                uzem vba-next vbam vecx vice yabasanshiro xmil"

PKG_EMUS="common-shaders glsl-shaders libretro-database retroarch ${LIBRETRO_CORES} advancemame \
          hatarisa openbor scummvmsa PPSSPPSDL"

PKG_COMPAT="lib32 gamecontrollerdb"

PKG_TOOLS="evtest mpv sixaxis rg351p-js2xbox gptokeyb 351files jstest-sdl"

PKG_EXPERIMENTAL=""

PKG_DEPENDS_TARGET+="${BASE_PACKAGES} ${PKG_UI} ${PKG_TOOLS} ${PKG_EMUS} ${LIBRETRO_CORES} ${PKG_COMPAT} ${PKG_EXPERIMENTAL}"

make_target() {
  :
}

makeinstall_target() {

  mkdir -p ${INSTALL}/usr/config/
  rsync -av ${PKG_DIR}/config/* ${INSTALL}/usr/config/
  ln -sf /storage/.config/distribution ${INSTALL}/distribution
  find ${INSTALL}/usr/config/distribution/ -type f -exec chmod o+x {} \;

  mkdir -p ${INSTALL}/usr/bin/

  ## Compatibility links for ports
  ln -s /storage/roms ${INSTALL}/roms
  ln -sf /storage/roms/opt ${INSTALL}/opt

}

post_install() {
  # Remove unnecesary Retroarch Assets and overlays
  for i in branding nuklear nxrgui pkg switch wallpapers zarch COPYING; do
    rm -rf "${INSTALL}/usr/share/retroarch-assets/$i"
  done

  for i in automatic dot-art flatui neoactive pixel retroactive retrosystem systematic convert.sh NPMApng2PMApng.py; do
    rm -rf "${INSTALL}/usr/share/retroarch-assets/xmb/$i"
  done

  mkdir -p ${INSTALL}/etc/retroarch-joypad-autoconfig
  cp -r ${PKG_DIR}/gamepads/* ${INSTALL}/etc/retroarch-joypad-autoconfig
  ln -sf jelos.target ${INSTALL}/usr/lib/systemd/system/default.target

  mkdir -p ${INSTALL}/etc/profile.d
  cp ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/device.config ${INSTALL}/etc/profile.d/01-deviceconfig

  # Split this up into other packages
  cp ${PKG_DIR}/sources/autostart/autostart ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/usr/lib/autostart/${DEVICE}
  mkdir -p ${INSTALL}/usr/lib/autostart/common
  mkdir -p ${INSTALL}/usr/lib/autostart/sounds
  mkdir -p ${INSTALL}/usr/lib/autostart/daemons
  cp ${PKG_DIR}/sources/autostart/sounds/* ${INSTALL}/usr/lib/autostart/sounds
  cp ${PKG_DIR}/sources/autostart/common/* ${INSTALL}/usr/lib/autostart/common
  cp ${PKG_DIR}/sources/autostart/daemons/* ${INSTALL}/usr/lib/autostart/daemons
  if [ -d "${PKG_DIR}/sources/autostart/${DEVICE}" ]
  then
    cp ${PKG_DIR}/sources/autostart/${DEVICE}/* ${INSTALL}/usr/lib/autostart/${DEVICE}
  fi
  chmod -R 0755 ${INSTALL}/usr/lib/autostart ${INSTALL}/usr/bin/autostart
  enable_service jelos-autostart.service

  # Issue banner
  cp ${PKG_DIR}/sources/issue ${INSTALL}/etc
  ln -s /etc/issue ${INSTALL}/etc/motd
  cat <<EOF >> ${INSTALL}/etc/issue
==> Build Date: ${BUILD_DATE}
==> Version: ${OS_VERSION}
EOF

  cp ${PKG_DIR}/sources/shutdown.sh ${INSTALL}/usr/bin
  cp ${PKG_DIR}/sources/pico-8.sh ${INSTALL}/usr/bin
  cp ${PKG_DIR}/sources/scripts/* ${INSTALL}/usr/bin

  if [[ ${DEVICE} =~ RG351 ]]; then
    cp ${PKG_DIR}/sources/asound/rg351/asound.conf ${INSTALL}/usr/config/
  elif [[ ${DEVICE} =~ RG552 ]]; then
    cp ${PKG_DIR}/sources/asound/rg552/asound.conf ${INSTALL}/usr/config/
    cp ${PKG_DIR}/sources/asound/rg552/asound.state ${INSTALL}/usr/config/
  fi

  rm -f ${INSTALL}/usr/bin/{sh,bash,busybox,sort}
  cp $(get_build_dir busybox)/.install_pkg/usr/bin/busybox ${INSTALL}/usr/bin
  cp $(get_build_dir bash)/.install_pkg/usr/bin/bash ${INSTALL}/usr/bin
  cp $(get_build_dir coreutils)/.install_pkg/usr/bin/sort ${INSTALL}/usr/bin

  ln -sf bash ${INSTALL}/usr/bin/sh
  mkdir -p ${INSTALL}/etc
  echo "/usr/bin/bash" >>${INSTALL}/etc/shells
  echo "/usr/bin/sh" >>${INSTALL}/etc/shells

  echo "chmod 4755 ${INSTALL}/usr/bin/bash" >> ${FAKEROOT_SCRIPT}
  echo "chmod 4755 ${INSTALL}/usr/bin/busybox" >> ${FAKEROOT_SCRIPT}
  find ${INSTALL}/usr/ -type f -iname "*.sh" -exec chmod +x {} \;

}
