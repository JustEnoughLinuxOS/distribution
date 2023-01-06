#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

if [ ! -d "/storage/.config/citra-emu" ]; then
    mkdir -p "/storage/.config/citra-emu"
        cp -r "/usr/config/citra-emu" "/storage/.config/"
fi

#Move sdmc & nand to 3ds roms folder
if [ ! -d "/storage/roms/3ds/citrasa/sdmc" ]; then
    mkdir -p "/storage/roms/3ds/citrasa/sdmc"
fi

rm -rf /storage/.config/citra-emu/sdmc
ln -sf /storage/roms/3ds/citrasa/sdmc /storage/.config/citra-emu/sdmc

if [ ! -d "/storage/roms/3ds/citrasa/nand" ]; then
    mkdir -p "/storage/roms/3ds/citrasa/nand"
fi

rm -rf /storage/.config/citra-emu/nand
ln -sf /storage/roms/3ds/citrasa/nand /storage/.config/citra-emu/nand


   #Emulation Station Features
   GAME=$(echo "${1}"| sed "s#^/.*/##")
   RES=$(get_setting resolution_scale 3ds "${GAME}")
   ROTATE=$(get_setting rotate_screen 3ds "${GAME}")
   SLAYOUT=$(get_setting screen_layout 3ds "${GAME}")

   #Resolution Scale
	if [ "$RES" = "0" ]
	then
  		sed -i '/resolution_factor =/c\resolution_factor = 0' /storage/.config/citra-emu/sdl2-config.ini
	fi
	if [ "$RES" = "1" ]
	then
  		sed -i '/resolution_factor =/c\resolution_factor = 1' /storage/.config/citra-emu/sdl2-config.ini
	fi
        if [ "$RES" = "2" ]
        then
                sed -i '/resolution_factor =/c\resolution_factor = 2' /storage/.config/citra-emu/sdl2-config.ini
        fi

   #Rotate Screen
        if [ "$ROTATE" = "0" ]
        then
                sed -i '/upright_screen =/c\upright_screen = 0' /storage/.config/citra-emu/sdl2-config.ini
        fi
        if [ "$ROTATE" = "1" ]
        then
                sed -i '/upright_screen =/c\upright_screen = 1' /storage/.config/citra-emu/sdl2-config.ini
        fi

   #Screen Layout
        if [ "$SLAYOUT" = "0" ]
        then
                sed -i '/layout_option =/c\layout_option = 0' /storage/.config/citra-emu/sdl2-config.ini
                sed -i '/swap_screen =/c\swap_screen = 0' /storage/.config/citra-emu/sdl2-config.ini
                sed -i '/custom_layout =/c\custom_layout = 0' /storage/.config/citra-emu/sdl2-config.ini
        fi
        if [ "$SLAYOUT" = "1a" ]
        then
                sed -i '/layout_option =/c\layout_option = 1' /storage/.config/citra-emu/sdl2-config.ini
                sed -i '/swap_screen =/c\swap_screen = 0' /storage/.config/citra-emu/sdl2-config.ini
                sed -i '/custom_layout =/c\custom_layout = 0' /storage/.config/citra-emu/sdl2-config.ini
        fi
        if [ "$SLAYOUT" = "1b" ]
        then
                sed -i '/layout_option =/c\layout_option = 1' /storage/.config/citra-emu/sdl2-config.ini
                sed -i '/swap_screen =/c\swap_screen = 1' /storage/.config/citra-emu/sdl2-config.ini
                sed -i '/custom_layout =/c\custom_layout = 0' /storage/.config/citra-emu/sdl2-config.ini
        fi
        if [ "$SLAYOUT" = "2" ]
        then
                sed -i '/layout_option =/c\layout_option = 2' /storage/.config/citra-emu/sdl2-config.ini
                sed -i '/swap_screen =/c\swap_screen = 0' /storage/.config/citra-emu/sdl2-config.ini
                sed -i '/custom_layout =/c\custom_layout = 0' /storage/.config/citra-emu/sdl2-config.ini
        fi
        if [ "$SLAYOUT" = "3" ]
        then
                sed -i '/layout_option =/c\layout_option = 3' /storage/.config/citra-emu/sdl2-config.ini
                sed -i '/swap_screen =/c\swap_screen = 0' /storage/.config/citra-emu/sdl2-config.ini
                sed -i '/custom_layout =/c\custom_layout = 0' /storage/.config/citra-emu/sdl2-config.ini
	fi
        if [ "$SLAYOUT" = "4" ]
        then
                sed -i '/layout_option =/c\layout_option = 0' /storage/.config/citra-emu/sdl2-config.ini
                sed -i '/swap_screen =/c\swap_screen = 0' /storage/.config/citra-emu/sdl2-config.ini
                sed -i '/custom_layout =/c\custom_layout = 1' /storage/.config/citra-emu/sdl2-config.ini
        fi


rm -rf /storage/.local/share/citra-emu

ln -sfv /storage/.config/citra-emu /storage/.local/share/citra-emu

/usr/bin/citra "${1}"
