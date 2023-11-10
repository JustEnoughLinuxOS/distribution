# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present - The JELOS Project (https://github.com/JustEnoughLinuxOS)

PKG_NAME="portmaster"
PKG_VERSION="8.5.2_0811"
PKG_SITE="https://github.com/PortsMaster/PortMaster-GUI"
PKG_URL="${PKG_SITE}/releases/download/${PKG_VERSION}/PortMaster.zip"
PKG_LICENSE="MIT"
PKG_ARCH="arm aarch64"
PKG_DEPENDS_TARGET="toolchain gptokeyb gamecontrollerdb wget oga_controls libegl"
PKG_TOOLCHAIN="manual"
PKG_LONGDESC="Portmaster - a simple tool that allows you to download various game ports"

makeinstall_target() {
  export STRIP=true
  mkdir -p ${INSTALL}/usr/config/PortMaster
  cp ${PKG_DIR}/sources/* ${INSTALL}/usr/config/PortMaster/

  mkdir -p ${INSTALL}/usr/bin
  cp -rf ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin
  chmod +x ${INSTALL}/usr/bin/start_portmaster.sh

  mkdir -p ${INSTALL}/usr/config/PortMaster/release
  curl -Lo ${INSTALL}/usr/config/PortMaster/release/PortMaster.zip ${PKG_URL}
}

post_install() {
    case ${DEVICE} in
      S922X)
        LIBEGL="export SDL_VIDEO_GL_DRIVER=\/usr\/lib\/egl\/libGL.so.1 SDL_VIDEO_EGL_DRIVER=\/usr\/lib\/egl\/libEGL.so.1"
      ;;
      *)
        LIBEGL=""
      ;;
    esac
    sed -e "s/@LIBEGL@/${LIBEGL}/g" \
        -i ${INSTALL}/usr/bin/start_portmaster.sh
}
