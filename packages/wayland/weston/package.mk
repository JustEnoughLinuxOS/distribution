# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="weston"
PKG_VERSION="10.0.3"
PKG_LICENSE="MIT"
PKG_SITE="https://wayland.freedesktop.org/"
PKG_URL="https://gitlab.freedesktop.org/wayland/weston/-/archive/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain wayland wayland-protocols libdrm libxkbcommon libinput cairo pango libjpeg-turbo dbus seatd glu ${OPENGL} libX11 xorg-server libXcursor xkbcomp setxkbmap cairo xterm splash"
PKG_LONGDESC="Reference implementation of a Wayland compositor"

PKG_MESON_OPTS_TARGET="-Dbackend-drm=true \
                       -Dbackend-drm-screencast-vaapi=false \
                       -Dbackend-headless=false \
                       -Dbackend-rdp=false \
                       -Dscreenshare=false \
                       -Dbackend-wayland=true \
                       -Dbackend-x11=false \
                       -Ddeprecated-backend-fbdev=false \
                       -Dbackend-default=drm \
                       -Drenderer-gl=true \
                       -Ddeprecated-weston-launch=false \
                       -Dxwayland=true \
                       -Dsystemd=true \
                       -Dremoting=false \
                       -Dpipewire=false \
                       -Dshell-desktop=true \
                       -Dshell-fullscreen=true \
                       -Dshell-ivi=false \
                       -Dshell-kiosk=true \
                       -Ddesktop-shell-client-default="weston-desktop-shell" \
                       -Ddeprecated-wl-shell=false \
                       -Dcolor-management-lcms=false \
                       -Dcolor-management-colord=false \
                       -Dlauncher-logind=false \
                       -Dlauncher-libseat=true \
                       -Dimage-jpeg=true \
                       -Dimage-webp=false \
                       -Dtools=['terminal']
                       -Ddemo-clients=false \
                       -Dsimple-clients=[] \
                       -Dresize-pool=false \
                       -Dwcap-decode=false \
                       -Dtest-junit-xml=false \
                       -Dtest-skip-is-failure=false \
                       -Dtest-gl-renderer=false \
                       -Ddoc=false"

pre_configure_target() {
  # weston does not build with NDEBUG (requires assert for tests)
  export TARGET_CFLAGS=$(echo ${TARGET_CFLAGS} | sed -e "s|-DNDEBUG||g")
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/weston
    cp ${PKG_DIR}/scripts/weston-config ${INSTALL}/usr/lib/weston

  mkdir -p ${INSTALL}/usr/share/weston
    cp ${PKG_DIR}/config/*ini ${INSTALL}/usr/share/weston

  safe_remove ${INSTALL}/usr/share/wayland-sessions

  for configfile in weston.ini kiosk.ini
  do
    sed -i -e "s|@WESTONFONTSIZE@|${WESTONFONTSIZE}|g" ${INSTALL}/usr/share/weston/${configfile}
  done

  if [ "${EMULATION_DEVICE}" = "yes" ] && \
     [ ! "${BASE_ONLY}" == true ]
  then
    cat <<EOF >>${INSTALL}/usr/share/weston/weston.ini

[launcher]
path=/usr/bin/start_es.sh
icon=/usr/config/emulationstation/resources/window_icon_24.png
EOF
  fi

}
