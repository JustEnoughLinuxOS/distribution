# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="glfw"
PKG_VERSION="6b57e08bb0078c9834889eab871bac2368198c15"
PKG_ARCH="any"
PKG_LICENSE="zlib"
PKG_DEPENDS_TARGET="toolchain expat libdrm libxkbcommon libXrandr libXinerama libXcursor libXi Mako:host "
PKG_SITE="https://github.com/glfw/glfw"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_SHORTDESC="GLFW graphics library for wayland & x11"
PKG_TOOLCHAIN="cmake"

pre_configure_target() {
        PKG_CMAKE_OPTS_TARGET+="        -DBUILD_SHARED_LIBS=ON \
                                        -DGLFW_BUILD_DOCS=OFF \
                                        -DGLFW_BUILD_EXAMPLES=OFF \
                                        -DGLFW_BUILD_TESTS=OFF \
                                        -DGLFW_INSTALL=OFF"
                                        }

if [ "${DISPLAYSERVER}" = "x11" ]; then
	PKG_DEPENDS_TARGET+=" xorgproto libXext libXdamage libXfixes libXxf86vm libxcb libX11 libxshmfence libXrandr libglvnd"
	PKG_CMAKE_OPTS_TARGET+=" -DGLFW_BUILD_X11=ON"
fi

if [ "${DISPLAYSERVER}" = "wl" ]; then
	PKG_DEPENDS_TARGET+=" wayland wayland-protocols libglvnd"
	PKG_CMAKE_OPTS_TARGET+=" -DGLFW_BUILD_WAYLAND=ON"
fi

case ${ARCH} in
	arm)
		PKG_CMAKE_OPTS_TARGET+=" -DGLFW_BUILD_X11=OFF"
	;;
esac

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/
  cp $PKG_BUILD/.$TARGET_NAME/src/libglfw* $INSTALL/usr/lib/
}
