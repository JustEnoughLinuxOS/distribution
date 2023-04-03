#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

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
  ASPECT=$(get_setting aspect_ratio ps2 "${GAME}")
  FPS=$(get_setting show_fps ps2 "${GAME}")
  GRENDERER=$(get_setting graphics_backend ps2 "${GAME}")
  VSYNC=$(get_setting vsync ps2 "${GAME}")


  #Aspect Ratio
	if [ "$ASPECT" = "0" ]
	then
  		sed -i '/^AspectRatio =/c\AspectRatio = 4:3' /storage/.config/aethersx2/inis/PCSX2.ini
	fi
	if [ "$ASPECT" = "1" ]
	then
  		sed -i '/^AspectRatio =/c\AspectRatio = 16:9' /storage/.config/aethersx2/inis/PCSX2.ini
	fi
	if [ "$ASPECT" = "2" ]
	then
  		sed -i '/^AspectRatio =/c\AspectRatio = Stretch' /storage/.config/aethersx2/inis/PCSX2.ini
	fi

  #Graphics Backend
	if [ "$GRENDERER" = "0" ]
	then
  		sed -i '/^Renderer =/c\Renderer = 12' /storage/.config/aethersx2/inis/PCSX2.ini
	fi
	if [ "$GRENDERER" = "1" ]
	then
  		sed -i '/^Renderer =/c\Renderer = 14' /storage/.config/aethersx2/inis/PCSX2.ini
	fi
	if [ "$GRENDERER" = "2" ]
	then
  		sed -i '/^Renderer =/c\Renderer = 13' /storage/.config/aethersx2/inis/PCSX2.ini
	fi

  #Show FPS
	if [ "$FPS" = "false" ]
	then
  		sed -i '/^OsdShowFPS =/c\OsdShowFPS = false' /storage/.config/aethersx2/inis/PCSX2.ini
	fi
	if [ "$FPS" = "true" ]
	then
  		sed -i '/^OsdShowFPS =/c\OsdShowFPS = true' /storage/.config/aethersx2/inis/PCSX2.ini
	fi

  #Vsync
	if [ "$VSYNC" = "0" ]
	then
  		sed -i '/^VsyncEnable =/c\VsyncEnable = 0' /storage/.config/aethersx2/inis/PCSX2.ini
	fi
	if [ "$VSYNC" = "1" ]
	then
  		sed -i '/^VsyncEnable =/c\VsyncEnable = 1' /storage/.config/aethersx2/inis/PCSX2.ini
	fi

#Set QT enviornment to wayland
  export QT_QPA_PLATFORM=wayland

#Run Aethersx2 emulator
  /usr/bin/@APPIMAGE@ -fullscreen "${1}"
