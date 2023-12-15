# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023-present JELOS (https://github.com/JustEnoughLinuxOS/distribution)

PKG_NAME="xwayland"
PKG_VERSION="7439e9c6c59219335fe35629a90f4fdd49912bcf"
PKG_LICENSE="OSS"
PKG_SITE="https://gitlab.freedesktop.org/xorg/xserver"
PKG_URL="${PKG_SITE}.git"
PKG_GIT_CLONE_BRANCH="xwayland-23.2"
PKG_DEPENDS_TARGET="toolchain util-macros font-util xorgproto libpciaccess libX11 libXfont2 libXinerama libxcvt libxshmfence libxkbfile libdrm openssl freetype pixman systemd xorg-launch-helper wayland libglvnd"
PKG_NEED_UNPACK="$(get_pkg_directory xf86-video-nvidia) $(get_pkg_directory xf86-video-nvidia-legacy)"
PKG_LONGDESC="X.Org Server is the free and open-source implementation of the X Window System display server."

get_graphicdrivers

PKG_MESON_OPTS_TARGET+=" -Dxvfb=false \
                       -Dbuilder_addr=${BUILDER_NAME} \
                       -Ddefault_font_path="/usr/share/fonts/misc,built-ins" \
                       -Dxdmcp=false \
                       -Dxdm-auth-1=false \
                       -Dsecure-rpc=false \
                       -Dipv6=false \
                       -Dinput_thread=true \
                       -Dxkb_dir=${XORG_PATH_XKB} \
                       -Dxkb_output_dir="/var/cache/xkb" \
                       -Dvendor_name="LibreELEC" \
                       -Dvendor_name_short="LE" \
                       -Dvendor_web="https://libreelec.tv/" \
                       -Dlisten_tcp=false \
                       -Dlisten_unix=true \
                       -Dlisten_local=false \
                       -Ddpms=true \
                       -Dxf86bigfont=false \
                       -Dscreensaver=false \
                       -Dxres=true \
                       -Dxace=false \
                       -Dxselinux=false \
                       -Dxinerama=true \
                       -Dxcsecurity=false \
                       -Dxv=true \
                       -Dmitshm=true \
                       -Dsha1="libcrypto" \
                       -Ddri3=true \
                       -Ddrm=true \
                       -Dlibunwind=false \
                       -Ddocs=false \
                       -Ddevel-docs=false"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} libepoxy"
  PKG_MESON_OPTS_TARGET+=" -Dglx=true \
                           -Dglamor=true"
else
  PKG_MESON_OPTS_TARGET+=" -Dglx=false \
                           -Ddri1=false \
                           -Dglamor=false"
fi

if [ "${COMPOSITE_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" libXcomposite"
fi

post_makeinstall_target() {
  rm -rf ${INSTALL}/var/cache/xkb

}
