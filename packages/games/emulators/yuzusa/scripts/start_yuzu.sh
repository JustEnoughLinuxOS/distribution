#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

#Check if yuzu exists in .config
if [ ! -d "/storage/.config/yuzu" ]; then
    mkdir -p "/storage/.config/yuzu"
        cp -r "/usr/config/yuzu" "/storage/.config/"
fi

#Check if sdl2-config.ini exists in .config/yuzu
if [ ! -f "/storage/.config/yuzu/sdl2-config.ini" ]; then
        cp -r "/usr/config/yuzu/sdl2-config.ini" "/storage/.config/yuzu/sdl2-config.ini"
fi

#Move Nand / Saves to switch roms folder
if [ ! -d "/storage/roms/switch/yuzu/nand" ]; then
    mkdir -p "/storage/switch/yuzu/nand"
fi
rm -rf /storage/.config/yuzu/nand
ln -sf /storage/roms/switch/yuzu/nand /storage/.config/yuzu/nand

#Link yuzu keys to bios folder
if [ ! -d "/storage/roms/bios/yuzu" ]; then
    mkdir -p "/storage/.config/yuzu"
fi
rm -rf /storage/.config/yuzu/keys
ln -sf /storage/roms/bios/yuzu /storage/.config/yuzu/keys

  #Emulation Station Features
  GAME=$(echo "${1}"| sed "s#^/.*/##")
  AF=$(get_setting anisotropic_filtering switch "${GAME}")
  AA=$(get_setting anti_aliasing switch "${GAME}")
  ASPECT=$(get_setting aspect_ratio switch "${GAME}")
  GRENDERER=$(get_setting graphics_backend switch "${GAME}")
  IRES=$(get_setting internal_resolution switch "${GAME}")
  PFILTER=$(get_setting pixel_filter switch "${GAME}")
  SDOCK=$(get_setting switch_mode switch "${GAME}")
  VSYNC=$(get_setting vsync switch "${GAME}")

   #Anisotropic Filtering
	if [ "$AF" = "0" ]
	then
  		sed -i '/max_anisotropy =/c\max_anisotropy = 0' /storage/.config/yuzu/sdl2-config.ini
	fi
	if [ "$AF" = "1" ]
	then
  		sed -i '/max_anisotropy =/c\max_anisotropy = 1' /storage/.config/yuzu/sdl2-config.ini
	fi
		if [ "$AF" = "2" ]
	then
  		sed -i '/max_anisotropy =/c\max_anisotropy = 2' /storage/.config/yuzu/sdl2-config.ini
	fi
		if [ "$AF" = "3" ]
	then
  		sed -i '/max_anisotropy =/c\max_anisotropy = 3' /storage/.config/yuzu/sdl2-config.ini
	fi
		if [ "$AF" = "4" ]
	then
  		sed -i '/max_anisotropy =/c\max_anisotropy = 4' /storage/.config/yuzu/sdl2-config.ini
	fi

   #Anti-Aliasing
	if [ "$AA" = "0" ]
	then
  		sed -i '/anti_aliasing =/c\anti_aliasing = 0' /storage/.config/yuzu/sdl2-config.ini
	fi
	if [ "$AA" = "1" ]
	then
  		sed -i '/anti_aliasing =/c\anti_aliasing = 1' /storage/.config/yuzu/sdl2-config.ini
	fi

  #Aspect Ratio
	if [ "$ASPECT" = "0" ]
	then
  		sed -i '/aspect_ratio =/c\aspect_ratio = 0' /storage/.config/yuzu/sdl2-config.ini
	fi
	if [ "$ASPECT" = "1" ]
	then
  		sed -i '/aspect_ratio =/c\aspect_ratio = 1' /storage/.config/yuzu/sdl2-config.ini
	fi
		if [ "$ASPECT" = "2" ]
	then
  		sed -i '/aspect_ratio =/c\aspect_ratio = 2' /storage/.config/yuzu/sdl2-config.ini
	fi
		if [ "$ASPECT" = "3" ]
	then
  		sed -i '/aspect_ratio =/c\aspect_ratio = 3' /storage/.config/yuzu/sdl2-config.ini
	fi

  #Graphics Backend
	if [ "$GRENDERER" = "0" ]
	then
  		sed -i '/backend =/c\backend = 0' /storage/.config/yuzu/sdl2-config.ini
	fi

	if [ "$GRENDERER" = "1" ]
	then
  		sed -i '/backend =/c\backend = 1' /storage/.config/yuzu/sdl2-config.ini
	fi

  #Internal Resolution
	if [ "$IRES" = "0" ]
	then
		sed -i '/resolution_setup =/c\resolution_setup = 0' /storage/.config/yuzu/sdl2-config.ini
	fi

	if [ "$IRES" = "1" ]
	then
 		sed -i '/resolution_setup =/c\resolution_setup = 1' /storage/.config/yuzu/sdl2-config.ini
 	fi

	if [ "$IRES" = "2" ]
	then
		sed -i '/resolution_setup =/c\resolution_setup = 2' /storage/.config/yuzu/sdl2-config.ini
	fi

  #Pixel Filter
	if [ "$PFILTER" = "0" ]
 	then
		sed -i '/scaling_filter =/c\scaling_filter = 0' /storage/.config/yuzu/sdl2-config.ini
	fi

	if [ "$PFILTER" = "1" ]
	then
		sed -i '/scaling_filter =/c\scaling_filter = 1' /storage/.config/yuzu/sdl2-config.ini
    	fi

	if [ "$PFILTER" = "2" ]
    	then
        	sed -i '/scaling_filter =/c\scaling_filter = 2' /storage/.config/yuzu/sdl2-config.ini
    	fi

    	if [ "$PFILTER" = "3" ]
    	then
        	sed -i '/scaling_filter =/c\scaling_filter = 3' /storage/.config/yuzu/sdl2-config.ini
    	fi

	if [ "$PFILTER" = "4" ]
    	then
        	sed -i '/scaling_filter =/c\scaling_filter = 4' /storage/.config/yuzu/sdl2-config.ini
    	fi

    	if [ "$PFILTER" = "5" ]
    	then
        	sed -i '/scaling_filter =/c\scaling_filter = 5' /storage/.config/yuzu/sdl2-config.ini
    	fi

  #Switch Mode
	if [ "$SDOCK" = "0" ]
	then
		sed -i '/use_docked_mode =/c\use_docked_mode = 0' /storage/.config/yuzu/sdl2-config.ini
	fi

	if [ "$SDOCK" = "1" ]
	then
		sed -i '/use_docked_mode =/c\use_docked_mode = 1' /storage/.config/yuzu/sdl2-config.ini
	fi

  #Vysnc
	if [ "$VSYNC" = "0" ]
	then
		sed -i '/use_vsync =/c\use_vsync = 0' /storage/.config/yuzu/sdl2-config.ini
	fi

	if [ "$VSYNC" = "1" ]
	then
		sed -i '/use_vsync =/c\use_vsync = 1' /storage/.config/yuzu/sdl2-config.ini
	fi

#Link  .config/yuzu to .local
rm -rf /storage/.local/share/yuzu
ln -sf /storage/.config/yuzu /storage/.local/share/yuzu

#Run Yuzu emulator
/usr/bin/yuzu-cmd "${1}"
