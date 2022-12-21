# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2020-present Fewtarius

PKG_NAME="jelos"
PKG_VERSION="$(date +%Y%m%d)"
PKG_ARCH="any"
PKG_LICENSE="apache2"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="JELOS Meta Package"
PKG_LONGDESC="JELOS Meta Package"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_TOOLCHAIN="make"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

PKG_BASEOS="plymouth-lite grep wget libjpeg-turbo util-linux xmlstarlet bluetool gnupg gzip patchelf \
            imagemagick terminus-font vim bash pyudev dialog six git dbus-python coreutils miniupnpc \
            nss-mdns avahi alsa-ucm-conf MC fbgrab modules system-utils autostart powerstate"

PKG_UI="emulationstation es-themes"

PKG_SOFTWARE=""

PKG_COMPAT=""

PKG_MULTIMEDIA="ffmpeg mpv vlc"

PKG_TOOLS="i2c-tools rclone jslisten evtest tailscale pygobject"

### Tools for mainline devices
case "${DEVICE}" in
  handheld|RG552)
    PKG_TOOLS+=" mesa-demos"
  ;;
esac

### Project specific variables
case "${PROJECT}" in
  Rockchip)
    PKG_EMUS+=" retropie-shaders"
    PKG_COMPAT+=" lib32"
  ;;
  PC)
    PKG_BASEOS+=" installer"
  ;;
esac

if [ ! -z "${BASE_ONLY}" ]
then
  PKG_DEPENDS_TARGET+=" ${PKG_BASEOS} ${PKG_TOOLS} ${PKG_UI}"
else
  PKG_DEPENDS_TARGET+=" ${PKG_BASEOS} ${PKG_TOOLS} ${PKG_UI} ${PKG_COMPAT} ${PKG_MULTIMEDIA} ${PKG_SOFTWARE}"
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

  ## Temporary - for compatibility
  if [ -n "${JELOS_SSH_KEYS_FILE}" ] || \
     [ -n "${JELOS_WIFI_SSID}" ] || \
     [ -n "${JELOS_WIFI_KEY}" ]
  then
    cat <<EOF
WARNING: JELOS_SSH_KEYS_FILE, JELOS_WIFI_SSID, and JELOS_WIFI_KEY are deprecated!  Switch to LOCAL_SSH_KEYS_FILE, LOCAL_WIFI_SSID, and LOCAL_WIFI_KEY.
EOF
    LOCAL_SSH_KEYS_FILE="${JELOS_SSH_KEYS_FILE}"
    LOCAL_WIFI_SSID="${JELOS_WIFI_SSID}"
    LOCAL_WIFI_KEY="${JELOS_WIFI_KEY}"
    sleep 5
  fi

  ### Add some quality of life customizations for hardworking devs.
  if [ -n "${LOCAL_SSH_KEYS_FILE}" ]; then
    mkdir -p ${INSTALL}/usr/config/ssh
    cp ${LOCAL_SSH_KEYS_FILE} ${INSTALL}/usr/config/ssh/authorized_keys
  fi

  if [ -n "${LOCAL_WIFI_SSID}" ]; then
    sed -i "s#wifi.enabled=0#wifi.enabled=1#g" ${INSTALL}/usr/config/system/configs/system.cfg
    cat <<EOF >> ${INSTALL}/usr/config/system/configs/system.cfg
wifi.ssid=${LOCAL_WIFI_SSID}
wifi.key=${LOCAL_WIFI_KEY}
EOF
  fi
}

post_install() {
  ln -sf jelos.target ${INSTALL}/usr/lib/systemd/system/default.target

  mkdir -p ${INSTALL}/etc/profile.d
  cp ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/device.config ${INSTALL}/etc/profile.d/01-deviceconfig

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

  cp ${PKG_DIR}/sources/scripts/* ${INSTALL}/usr/bin
  chmod 0755 ${INSTALL}/usr/bin/* ||:
  enable_service jelos-automount.service

  ### Fix and migrate to autostart package
  enable_service jelos-autostart.service

  if [ -d "${PKG_DIR}/sources/asound/${DEVICE}" ]
  then
    cp ${PKG_DIR}/sources/asound/${DEVICE}/* ${INSTALL}/usr/config/
  fi
  
  cp ${PKG_DIR}/sources/asound/asound.conf.bluealsa ${INSTALL}/usr/config/

  sed -i "s#@DEVICENAME@#${DEVICE}#g" ${INSTALL}/usr/config/system/configs/system.cfg

  if [[ "${DEVICE}" =~ RG351P ]] || [[ "${DEVICE}" =~ RGB20S ]]
  then
    sed -i "s#.integerscale=1#.integerscale=0#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#.rgascale=0#.rgascale=1#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#audio.volume=.*\$#audio.volume=100#g" ${INSTALL}/usr/config/system/configs/system.cfg
  fi

  if [[ "${DEVICE}" =~ RG503 ]] || [[ "${DEVICE}" =~ RG353P ]] || [[ "${DEVICE}" =~ handheld ]]
  then
    sed -i "s#.integerscale=1#.integerscale=0#g" ${INSTALL}/usr/config/system/configs/system.cfg
  fi

  if [[ "${DEVICE}" =~ handheld ]]
  then
    sed -i "s#system.automount=1#system.automount=0#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#fstrim.enabled=0#fstrim.enabled=1#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#3do.cpugovernor=performance#3do.cpugovernor=interactive#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#arcade.cpugovernor=performance#arcade.cpugovernor=interactive#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#atarijaguar.cpugovernor=performance#atarijaguar.cpugovernor=interactive#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#atomiswave.cpugovernor=performance#atomiswave.cpugovernor=interactive#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#dreamcast.cpugovernor=performance#dreamcast.cpugovernor=interactive#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#j2me.cpugovernor=performance#j2me.cpugovernor=interactive#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#mame.cpugovernor=performance#mame.cpugovernor=interactive#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#n64.cpugovernor=performance#n64.cpugovernor=interactive#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#naomi.cpugovernor=performance#naomi.cpugovernor=interactive#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#nds.cpugovernor=performance#nds.cpugovernor=interactive#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#pcfx.cpugovernor=performance#pcfx.cpugovernor=interactive#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#pc.cpugovernor=performance#pc.cpugovernor=interactive#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#psp.cpugovernor=performance#psp.cpugovernor=interactive#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#pspminis.cpugovernor=performance#pspminis.cpugovernor=interactive#g" ${INSTALL}/usr/config/system/configs/system.cfg
    sed -i "s#virtualboy.cpugovernor=performance#virtualboy.cpugovernor=interactive#g" ${INSTALL}/usr/config/system/configs/system.cfg
  fi

  ### Defaults for non-main builds.
  BUILD_BRANCH="$(git branch --show-current)"
  if [[ ! "${BUILD_BRANCH}" =~ main ]]
  then
    sed -i "s#ssh.enabled=0#ssh.enabled=1#g" ${INSTALL}/usr/config/system/configs/system.cfg
  fi

  enable_service bluetooth-agent.service
}
