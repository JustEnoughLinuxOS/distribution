#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present JELOS (https://github.com/JustEnoughLinuxOS)

. /etc/profile

jslisten set "-9 melonDS"

if [ ! -d "/storage/.config/melonDS" ]; then
    mkdir -p "/storage/.config/melonDS"
        cp -r "/usr/config/melonDS" "/storage/.config/"
fi

if [ ! -d "/storage/roms/savestates/nds" ]; then
    mkdir -p "/storage/roms/savestates/nds"
fi

#Emulation Station Features
  GAME=$(echo "${1}"| sed "s#^/.*/##")
  GRENDERER=$(get_setting graphics_backend nds "${GAME}")
  SUI=$(get_setting start_ui nds "${GAME}")
  VSYNC=$(get_setting vsync nds "${GAME}")

  #Graphics Backend
	if [ "$GRENDERER" = "0" ]
	then
  		sed -i '/^ScreenUseGL=/c\ScreenUseGL=0' /storage/.config/melonDS/melonDS.ini
	fi
	if [ "$GRENDERER" = "1" ]
	then
  		sed -i '/^ScreenUseGL=/c\ScreenUseGL=1' /storage/.config/melonDS/melonDS.ini
	fi

  #Vsync
        if [ "$VSYNC" = "0" ]
        then
                sed -i '/^ScreenVSync=/c\ScreenVSync=0' /storage/.config/melonDS/melonDS.ini
        fi
        if [ "$VSYNC" = "1" ]
        then
                sed -i '/^ScreenVSync=/c\ScreenVSync=1' /storage/.config/melonDS/melonDS.ini
        fi

#Set QT Platform to Wayland
  export QT_QPA_PLATFORM=wayland

#Run MelonDS emulator
	if [ "$SUI" = "1" ]
	then
		/usr/bin/melonDS
	else
		/usr/bin/melonDS -f "${1}"
	fi
