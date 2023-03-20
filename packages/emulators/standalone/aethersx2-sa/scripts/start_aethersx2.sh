#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

export PAN_MESA_DEBUG=gl3,gofaster

#Check if aethersx2 exists in .config
if [ ! -d "/storage/.config/aethersx2" ]; then
    mkdir -p "/storage/.config/aethersx2"
        cp -r "/usr/config/aethersx2" "/storage/.config/"
fi

#Make Aethersx2 bios folder
if [ ! -d "/storage/roms/bios/aethersx2" ]; then
    mkdir -p "/storage/roms/bios/aethersx2"
fi

#Create PS2 savestates folder
if [ ! -d "/storage/roms/savestates/ps2" ]; then
    mkdir -p "/storage/roms/savestastes/ps2"
fi

  #Emulation Station Features
  GAME=$(echo "${1}"| sed "s#^/.*/##")
  SUI=$(get_setting start_ui switch "${GAME}")

#Set QT enviornment to wayland
export QT_QPA_PLATFORM=wayland

#Run Aethersx2 emulator
	if [ "$SUI" = "1" ]
	then
		/usr/bin/@APPIMAGE@ -fullscreen
	else
		/usr/bin/@APPIMAGE@ -fullscreen "${1}"
	fi
