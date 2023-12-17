#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present JELOS (https://github.com/JustEnoughLinuxOS)

. /etc/profile
jslisten set "-9 citra"

#load gptokeyb support files
control-gen_init.sh
source /storage/.config/gptokeyb/control.ini
get_controls

if [ ! -d "/storage/.config/citra-emu" ]; then
    mkdir -p "/storage/.config/citra-emu"
        cp -r "/usr/config/citra-emu" "/storage/.config/"
fi

#Make sure citra gptk config exists
if [ ! -f "/storage/.config/citra-emu/citra.gptk" ]; then
        cp -r "/usr/config/citra-emu/citra.gptk" "/storage/.config/citra-emu/citra.gptk"
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
   CPU=$(get_setting cpu_speed 3ds "${GAME}")
   EMOUSE=$(get_setting emulate_mouse 3ds "${GAME}")
   RENDERER=$(get_setting graphics_backend 3ds "${GAME}")
   RES=$(get_setting resolution_scale 3ds "${GAME}")
   ROTATE=$(get_setting rotate_screen 3ds "${GAME}")
   SLAYOUT=$(get_setting screen_layout 3ds "${GAME}")

   #CPU Underclock
        if [ "$CPU" = "0" ]
        then
                sed -i '/cpu_clock_percentage =/c\cpu_clock_percentage = 100' /storage/.config/citra-emu/sdl2-config.ini
        fi
        if [ "$CPU" = "1" ]
        then
                sed -i '/cpu_clock_percentage =/c\cpu_clock_percentage = 90' /storage/.config/citra-emu/sdl2-config.ini
        fi
	if [ "$CPU" = "2" ]
        then
                sed -i '/cpu_clock_percentage =/c\cpu_clock_percentage = 80' /storage/.config/citra-emu/sdl2-config.ini
        fi
        if [ "$CPU" = "3" ]
        then
                sed -i '/cpu_clock_percentage =/c\cpu_clock_percentage = 70' /storage/.config/citra-emu/sdl2-config.ini
        fi
        if [ "$CPU" = "4" ]
        then
                sed -i '/cpu_clock_percentage =/c\cpu_clock_percentage = 60' /storage/.config/citra-emu/sdl2-config.ini
        fi
        if [ "$CPU" = "5" ]
        then
                sed -i '/cpu_clock_percentage =/c\cpu_clock_percentage = 50' /storage/.config/citra-emu/sdl2-config.ini
        fi

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

  #Video Backend
        if [ "$RENDERER" = "1" ]
        then
		sed -i '/graphics_api =/c\graphics_api = 1' /storage/.config/citra-emu/sdl2-config.ini
	else
                sed -i '/graphics_api =/c\graphics_api = 2' /storage/.config/citra-emu/sdl2-config.ini
	fi

rm -rf /storage/.local/share/citra-emu
ln -sfv /storage/.config/citra-emu /storage/.local/share/citra-emu

#Run Citra Emulator
if [ "$EMOUSE" = "0" ]
then
  /usr/bin/citra "${1}"
else
  $GPTOKEYB "citra" -c "/storage/.config/citra-emu/citra.gptk" &
  /usr/bin/citra "${1}"
  kill -9 $(pidof gptokeyb)
fi
