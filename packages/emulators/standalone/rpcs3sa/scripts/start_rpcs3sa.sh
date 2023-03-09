#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

#Check if rpcs3 exists in .config
if [ ! -d "/storage/.config/rpcs3" ]; then
    mkdir -p "/storage/.config/rpcs3"
        cp -r "/usr/config/rpcs3" "/storage/.config/"
fi

#Link rpcs3sa dev_flash to bios folder
if [ ! -d "/storage/roms/bios/rpcs3/dev_flash" ]; then
    mkdir -p "/storage/bios/rpcs3/dev_flash"
fi
rm -rf /storage/.config/rpcs3/dev_flash
ln -sf /storage/roms/bios/rpcs3/dev_flash /storage/.config/rpcs3/dev_flash

#Emulation Station Features
  GAME=$(echo "${1}"| sed "s#^/.*/##")
  SUI=$(get_setting start_ui ps3 "${GAME}")

#Run Rpcs3 emulator
  if [ "$SUI" = "1" ]
  then
	export QT_QPA_PLATFORM=wayland
	/usr/bin/rpcs3
  else
	export QT_QPA_PLATFORM=xcb
	rr_audio.sh pulseaudio
	export SDL_AUDIODRIVER=pulseaudio
	/usr/bin/rpcs3 --no-gui "${1}"
  fi
