# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="kmscube"
PKG_VERSION="96d63eb59e34c647cda1cbb489265f8c536ae055"
PKG_LICENSE="GPL"
PKG_SITE="https://cgit.freedesktop.org/mesa/kmscube"
PKG_URL="https://cgit.freedesktop.org/mesa/kmscube/snapshot/${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Example KMS/GBM/EGL application"
PKG_TOOLCHAIN="autotools"

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
elif [ "${OPENGL_SUPPORT}" = "yes" ]; then
  echo "kmscube only supports OpenGLESv2"
  exit 0
fi
