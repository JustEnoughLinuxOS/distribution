# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2020-present Fewtarius

PKG_NAME="emulationstation"
PKG_VERSION="f30a5ba"
PKG_GIT_CLONE_BRANCH="main"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/JustEnoughLinuxOS/emulationstation"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="boost toolchain SDL2 freetype curl freeimage bash rapidjson ${OPENGLES} SDL2_mixer fping p7zip vlc"
PKG_NEED_UNPACK="busybox"
PKG_SHORTDESC="Emulationstation emulator frontend"
PKG_BUILD_FLAGS="-gold"
GET_HANDLER_SUPPORT="git"

PKG_PATCH_DIRS+="${DEVICE}"

# themes for Emulationstation
PKG_DEPENDS_TARGET="${PKG_DEPENDS_TARGET} es-theme-art-book-next"

PKG_CMAKE_OPTS_TARGET=" -DENABLE_EMUELEC=1 -DGLES2=1 -DDISABLE_KODI=1 -DENABLE_FILEMANAGER=0 -DCEC=0"

pre_configure_target() {
  if [ -f ~/developer_settings.conf ]; then
    . ~/developer_settings.conf
  fi
}

makeinstall_target() {
	mkdir -p $INSTALL/usr/config/locale
	cp -rf $PKG_BUILD/locale/lang/* $INSTALL/usr/config/locale/

	mkdir -p $INSTALL/usr/lib
	ln -sf /storage/.config/emulationstation/locale $INSTALL/usr/lib/locale

	mkdir -p $INSTALL/usr/config/emulationstation/resources
	cp -rf $PKG_BUILD/resources/* $INSTALL/usr/config/emulationstation/resources/
	rm -rf $INSTALL/usr/config/emulationstation/resources/logo.png

	mkdir -p $INSTALL/usr/lib/${PKG_PYTHON_VERSION}
	cp -rf $PKG_DIR/bluez/* $INSTALL/usr/lib/${PKG_PYTHON_VERSION}

	mkdir -p $INSTALL/usr/bin
	ln -sf /storage/.config/emulationstation/resources $INSTALL/usr/bin/resources
	cp -rf $PKG_BUILD/emulationstation $INSTALL/usr/bin

	mkdir -p $INSTALL/etc/emulationstation/
	ln -sf /storage/.config/emulationstation/themes $INSTALL/etc/emulationstation/
	ln -sf /usr/config/emulationstation/es_systems.cfg $INSTALL/etc/emulationstation/es_systems.cfg

        cp -rf $PKG_DIR/config/*.cfg $INSTALL/usr/config/emulationstation
        cp -rf $PKG_DIR/config/scripts $INSTALL/usr/config/emulationstation

	if [ "${DEVICE}" == "RG552" ]
	then
	   sed -i 's#<string name="AudioDevice" value="Playback" />#<string name="AudioDevice" value="DAC" />#' $INSTALL/usr/config/emulationstation/es_settings.cfg
	fi

	chmod +x $INSTALL/usr/config/emulationstation/scripts/*
	find $INSTALL/usr/config/emulationstation/scripts/ -type f -exec chmod o+x {} \;
	ln -sf /storage/.cache/system_timezone ${INSTALL}/etc/timezone

}

post_install() {
	mkdir -p $INSTALL/usr/share
	ln -sf /storage/.config/emulationstation/locale $INSTALL/usr/share/locale
}
