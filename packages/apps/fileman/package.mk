# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present 351ELEC (https://github.com/351elec)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="fileman"
PKG_VERSION="2c7d6ce"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/JustEnoughLinuxOS/fileman"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain SDL2 SDL2_image SDL2_gfx SDL2_ttf"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="A Single panel file Manager."
PKG_PATCH_DIRS="${DEVICE}"

pre_build_target() {
  cp -f ./distributions/JELOS/fonts/NanumSquareNeo-bRg.ttf ${PKG_BUILD}/res/
  sed -i "s/Noto.*Regular/NanumSquareNeo-bRg/g" ${PKG_BUILD}/src/def.h
}

make_target() {
  MAKEDEVICE=$(echo ${DEVICE^^} | sed "s#-#_##g")
  make DEVICE=${MAKEDEVICE^^} RES_PATH=/usr/share/fileman/res START_PATH=/storage/roms SDL2_CONFIG=${SYSROOT_PREFIX}/usr/bin/sdl2-config CC=${CXX}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/usr/share/fileman
  cp fileman ${INSTALL}/usr/bin/
  cp -rf res ${INSTALL}/usr/share/fileman/
  cp ${PKG_DIR}/sources/fileman.rg503 ${INSTALL}/usr/bin/
  chmod 0755 ${INSTALL}/usr/bin/fileman*
}
