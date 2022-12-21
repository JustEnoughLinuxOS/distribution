# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2020-present Fewtarius

PKG_NAME="emulationstation"
PKG_VERSION="8124784"
PKG_GIT_CLONE_BRANCH="main"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/JustEnoughLinuxOS/emulationstation"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="boost toolchain SDL2 freetype curl freeimage bash rapidjson SDL2_mixer fping p7zip alsa vlc splash"
PKG_NEED_UNPACK="busybox"
PKG_SHORTDESC="Emulationstation emulator frontend"
PKG_BUILD_FLAGS="-gold"
GET_HANDLER_SUPPORT="git"
PKG_PATCH_DIRS+="${DEVICE}"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu"
  PKG_CMAKE_OPTS_TARGET+=" -DGL=1"
fi

if [ ! "${OPENGLES_SUPPORT}" = no ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_CMAKE_OPTS_TARGET+=" -DGLES2=1"
fi

if [ ! "${ENABLE_UPDATES}" = "no" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_UPDATES=1"
else
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_UPDATES=0"
fi

PKG_CMAKE_OPTS_TARGET+=" -DENABLE_EMUELEC=1 -DDISABLE_KODI=1 -DENABLE_FILEMANAGER=0 -DCEC=0"

##########################################################################################################
# The following allows building Emulation station from local copy by using EMULATIONSTATION_SRC.
# The built makes symlinks to a local repository.
#
# One time setup:
# ---------------
# cd ~
# git clone https://github.com/JustEnoughLinuxOS/emulationstation.git
# cd emulationstation
# git submodule update --init
#
# Cleanup old files:
# ------------------
# DEVICE=RG351V ARCH=aarch64 ./scripts/clean emulationstation
#
# Build from local copy:
# ----------------------
# EMULATIONSTATION_SRC=~/emulationstation DEVICE=RG351V ARCH=aarch64 ./scripts/build emulationstation
#
# Run from the device:
# --------------------
# Copy ./emulationstation binary found in build.JELOS-<device>.aarch64/emulationstation-*/.install_pkg/usr/bin/
# Via ssh, run emulationstation with
# systemctl stop emustation
# chmod +x ./emulationstation
# ./emulationstation
##########################################################################################################
if [ -n "${EMULATIONSTATION_SRC}" ]; then
unpack() {
  echo cp -PRf ${EMULATIONSTATION_SRC} ${PKG_BUILD}
  cp -PRf ${EMULATIONSTATION_SRC} ${PKG_BUILD}
}
# add some symbolic links to point to a code in local source folder
post_unpack() {
  rm -rf "${PKG_BUILD}/es-app"
  ln -sf "${EMULATIONSTATION_SRC}/es-app" "${PKG_BUILD}"

  rm -rf "${PKG_BUILD}/es-core"
  ln -sf "${EMULATIONSTATION_SRC}/es-core" "${PKG_BUILD}"
}
fi

pre_configure_target() {
  if [ -f ~/developer_settings.conf ]; then
    . ~/developer_settings.conf
  fi
}

makeinstall_target() {
	mkdir -p ${INSTALL}/usr/config/locale
	cp -rf ${PKG_BUILD}/locale/lang/* ${INSTALL}/usr/config/locale/

	mkdir -p ${INSTALL}/usr/lib
	ln -sf /storage/.config/emulationstation/locale ${INSTALL}/usr/lib/locale

	mkdir -p ${INSTALL}/usr/config/emulationstation/resources
	cp -rf ${PKG_BUILD}/resources/* ${INSTALL}/usr/config/emulationstation/resources/
	rm -rf ${INSTALL}/usr/config/emulationstation/resources/logo.png

        mkdir -p ${INSTALL}/usr/bin
	cp ${PKG_BUILD}/es_settings ${INSTALL}/usr/bin
	chmod 0755 ${INSTALL}/usr/bin/es_settings

	cp ${PKG_BUILD}/start_es.sh ${INSTALL}/usr/bin
	chmod 0755 ${INSTALL}/usr/bin/start_es.sh

	mkdir -p ${INSTALL}/usr/lib/${PKG_PYTHON_VERSION}
	cp -rf ${PKG_DIR}/bluez/* ${INSTALL}/usr/lib/${PKG_PYTHON_VERSION}

	mkdir -p ${INSTALL}/usr/bin
	#ln -sf /storage/.config/emulationstation/resources ${INSTALL}/usr/bin/resources
	cp -rf ${PKG_BUILD}/emulationstation ${INSTALL}/usr/bin

	mkdir -p ${INSTALL}/etc/emulationstation/
	ln -sf /storage/.config/emulationstation/themes ${INSTALL}/etc/emulationstation/
	ln -sf /usr/config/emulationstation/es_systems.cfg ${INSTALL}/etc/emulationstation/es_systems.cfg

        cp -rf ${PKG_DIR}/config/common/*.cfg ${INSTALL}/usr/config/emulationstation
	cp -rf ${PKG_DIR}/config/device/${DEVICE}/*.cfg ${INSTALL}/usr/config/emulationstation

	ln -sf /storage/.cache/system_timezone ${INSTALL}/etc/timezone

}

post_install() {
	mkdir -p ${INSTALL}/usr/share
	ln -sf /storage/.config/emulationstation/locale ${INSTALL}/usr/share/locale
}
