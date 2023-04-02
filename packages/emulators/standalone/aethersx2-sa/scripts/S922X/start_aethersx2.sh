#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

#Check if aethersx2 exists in .config
if [ ! -d "/storage/.config/aethersx2" ]; then
    mkdir -p "/storage/.config/aethersx2"
        cp -r "/usr/config/aethersx2" "/storage/.config/"
fi

#Check for aethersx2.gptk
if [ ! -f "/storage/.config/aethersx2/aethersx2.gptk" ]; then
    mkdir -p "/storage/.config/aethersx2"
        cp -r "/usr/config/aethersx2/aethersx2.gptk" "/storage/.config/aethersx2/aethersx2.gptk"
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
	control-gen_init.sh
	source /storage/.config/gptokeyb/control.ini
	get_controls
	GAMEDIR=/storage/.config/aethersx2
	cd $GAMEDIR
	export PCKILLMODE="Y"

	$ESUDO chmod 666 /dev/uinput
	$GPTOKEYB "aethersx2" -c "aethersx2.gptk" &
	SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig" /usr/bin/aethersx2-sa -fullscreen "${1}" 2>&1 | tee ./log.txt
	$ESUDO kill -9 $(pidof gptokeyb)
fi
