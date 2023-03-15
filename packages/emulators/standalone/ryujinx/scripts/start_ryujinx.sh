#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

if [ ! -d "/storage/.config/Ryujinx" ]; then
    mkdir -p "/storage/.config/Ryujinx"
        cp -r "/usr/config/Ryujinx" "/storage/.config/"
fi

#Move ryujinx nand to bios folder
if [ ! -d "/storage/roms/bios/ryujinx/nand" ]; then
    mkdir -p "/storage/roms/bios/ryujinx/nand"
fi
rm -rf /storage/.config/Ryujinx/bis/system/Contents/registered
ln -sf /storage/roms/bios/ryujinx/nand /storage/.config/Ryujinx/bis/system/Contents/registered

#Link ryujinx keys to bios folder
if [ ! -d "/storage/roms/bios/ryujinx/keys" ]; then
    mkdir -p "/storage/roms/bios/ryujinx/keys"
fi
rm -rf /storage/.config/ryujinx/system
ln -sf /storage/roms/bios/ryujinx/keys /storage/.config/Ryujinx/system

  #Emulation Station Features
  GAME=$(echo "${1}"| sed "s#^/.*/##")
  GRENDERER=$(get_setting graphics_backend switch "${GAME}")
  SUI=$(get_setting start_ui switch "${GAME}")

  #Graphics Backend
	if [ "$GRENDERER" = "0" ]
	then
  		sed -i '/^  "graphics_backend": /c\  "graphics_backend": "OpenGL",' /storage/.config/Ryujinx/Config.json
	fi
	if [ "$GRENDERER" = "1" ]
	then
                sed -i '/^  "graphics_backend": /c\  "graphics_backend": "Vulkan",' /storage/.config/Ryujinx/Config.json
	fi

#Always grab the latest ryujinx bin
shasum1=$(sha1sum /usr/config/Ryujinx/Ryujinx | awk '{print $1}')
shasum2=$(sha1sum /storage/.config/Ryujinx/Ryujinx | awk '{print $1}')

if [ "$shasum1" <> "$shasum2" ]; then
  cp -r "/usr/config/Ryujinx/Ryujinx" "/storage/.config/Ryujinx/Ryujinx"
fi

#Run Yuzu emulator
	if [ "$SUI" = "1" ]
	then
		/storage/.config/Ryujinx/Ryujinx
	else
		/storage/.config/Ryujinx/Ryujinx "${1}"
	fi
