#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

#Check if yuzu exists in .config
if [ ! -d "/storage/.config/yuzu" ]; then
    mkdir -p "/storage/.config/yuzu"
        cp -r "/usr/config/yuzu" "/storage/.config/"
fi

#Check if qt-config.ini exists in .config/yuzu
if [ ! -f "/storage/.config/yuzu/qt-config.ini" ]; then
        cp -r "/usr/config/yuzu/qt-config.ini" "/storage/.config/yuzu/qt-config.ini"
fi

#Move Nand / Saves to switch roms folder
if [ ! -d "/storage/roms/bios/yuzu/nand" ]; then
    mkdir -p "/storage/roms/bios/yuzu/nand"
fi
rm -rf /storage/.config/yuzu/nand
ln -sf /storage/roms/bios/yuzu/nand /storage/.config/yuzu/nand

#Link yuzu keys to bios folder
if [ ! -d "/storage/roms/bios/yuzu/keys" ]; then
    mkdir -p "/storage/roms/bios/yuzu/keys"
fi
rm -rf /storage/.config/yuzu/keys
ln -sf /storage/roms/bios/yuzu/keys /storage/.config/yuzu/keys

  #Emulation Station Features
  GAME=$(echo "${1}"| sed "s#^/.*/##")
  AF=$(get_setting anisotropic_filtering switch "${GAME}")
  AA=$(get_setting anti_aliasing switch "${GAME}")
  ASPECT=$(get_setting aspect_ratio switch "${GAME}")
  GACCURACY=$(get_setting gpu_accuracy switch "${GAME}")
  GRENDERER=$(get_setting graphics_backend switch "${GAME}")
  IRES=$(get_setting internal_resolution switch "${GAME}")
  PFILTER=$(get_setting pixel_filter switch "${GAME}")
  RUMBLE=$(get_setting rumble switch "${GAME}")
  SDOCK=$(get_setting switch_mode switch "${GAME}")
  SUI=$(get_setting start_ui switch "${GAME}")
  VSYNC=$(get_setting vsync switch "${GAME}")

   #Anisotropic Filtering
	sed -i '/^max_anisotropy\\default=/c\max_anisotropy\\default=false' /storage/.config/yuzu/qt-config.ini
	if [ "$AF" = "0" ]
	then
  		sed -i '/^max_anisotropy=/c\max_anisotropy=0' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$AF" = "1" ]
	then
  		sed -i '/^max_anisotropy=/c\max_anisotropy=1' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$AF" = "2" ]
	then
  		sed -i '/^max_anisotropy=/c\max_anisotropy=2' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$AF" = "3" ]
	then
  		sed -i '/^max_anisotropy=/c\max_anisotropy=3' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$AF" = "4" ]
	then
  		sed -i '/^max_anisotropy=/c\max_anisotropy=4' /storage/.config/yuzu/qt-config.ini
	fi

   #Anti-Aliasing
	sed -i '/^anti_aliasing\\default=/c\anti_aliasing\\default=false' /storage/.config/yuzu/qt-config.ini
	if [ "$AA" = "0" ]
	then
  		sed -i '/^anti_aliasing=/c\anti_aliasing=0' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$AA" = "1" ]
	then
  		sed -i '/^anti_aliasing=/c\anti_aliasing=1' /storage/.config/yuzu/qt-config.ini
	fi

  #Aspect Ratio
    sed -i '/^aspect_ratio\\default=/c\aspect_ratio\\default=false' /storage/.config/yuzu/qt-config.ini
	if [ "$ASPECT" = "0" ]
	then
  		sed -i '/^aspect_ratio=/c\aspect_ratio=0' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$ASPECT" = "1" ]
	then
  		sed -i '/^aspect_ratio=/c\aspect_ratio=1' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$ASPECT" = "2" ]
	then
  		sed -i '/^aspect_ratio=/c\aspect_ratio=2' /storage/.config/yuzu/qt-config.ini
	fi

	if [ "$ASPECT" = "3" ]
	then
  		sed -i '/^aspect_ratio=/c\aspect_ratio=3' /storage/.config/yuzu/qt-config.ini
	fi

  #GPU Accuracy
	sed -i '/^gpu_accuracy\\default=/c\gpu_accuracy\\default=false' /storage/.config/yuzu/qt-config.ini
	if [ "$GACCURACY" = "0" ]
	then
		sed -i '/^gpu_accuracy=/c\gpu_accuracy=0' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$GACCURACY" = "1" ]
	then
		sed -i '/^gpu_accuracy=/c\gpu_accuracy=1' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$GACCURACY" = "2" ]
	then
		sed -i '/^gpu_accuracy=/c\gpu_accuracy=2' /storage/.config/yuzu/qt-config.ini
	fi

  #Graphics Backend
	sed -i '/^backend\\default=/c\backend\\default=false' /storage/.config/yuzu/qt-config.ini
	if [ "$GRENDERER" = "0" ]
	then
  		sed -i '/^backend=/c\backend=0' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$GRENDERER" = "1" ]
	then
  		sed -i '/^backend=/c\backend=1' /storage/.config/yuzu/qt-config.ini
	fi

  #Internal Resolution
	sed -i '/^resolution_setup\\default=/c\resolution_setup\\default=false' /storage/.config/yuzu/qt-config.ini
	if [ "$IRES" = "0" ]
	then
		sed -i '/^resolution_setup=/c\resolution_setup=0' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$IRES" = "1" ]
	then
 		sed -i '/^resolution_setup=/c\resolution_setup=1' /storage/.config/yuzu/qt-config.ini
 	fi
	if [ "$IRES" = "2" ]
	then
		sed -i '/^resolution_setup=/c\resolution_setup=2' /storage/.config/yuzu/qt-config.ini
	fi

  #Pixel Filter
	sed -i '/^scaling_filter\\default=/c\scaling_filter\\default=false' /storage/.config/yuzu/qt-config.ini
	if [ "$PFILTER" = "0" ]
	then
		sed -i '/^scaling_filter=/c\scaling_filter=0' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$PFILTER" = "1" ]
	then
		sed -i '/^scaling_filter=/c\scaling_filter=1' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$PFILTER" = "2" ]
	then
		sed -i '/^scaling_filter=/c\scaling_filter=2' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$PFILTER" = "3" ]
	then
		sed -i '/^scaling_filter=/c\scaling_filter=3' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$PFILTER" = "4" ]
	then
		sed -i '/^scaling_filter =/c\scaling_filter=4' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$PFILTER" = "5" ]
	then
		sed -i '/^scaling_filter =/c\scaling_filter=5' /storage/.config/yuzu/qt-config.ini
	fi

  #RUMBLE
	sed -i '/^vibration_enabled\\default=/c\vibration_enabled\\default=false' /storage/.config/yuzu/qt-config.ini
	if [ "$RUMBLE" = "0" ]
	then
		sed -i '/^vibration_enabled=/c\vibration_enabled=false' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$RUMBLE" = "1" ]
	then
		sed -i '/^vibration_enabled=/c\vibration_enabled=true' /storage/.config/yuzu/qt-config.ini
	fi

  #Switch Mode
	sed -i '/^use_docked_mode\\default=/c\use_docked_mode\\default=false' /storage/.config/yuzu/qt-config.ini
	if [ "$SDOCK" = "0" ]
	then
		sed -i '/^use_docked_mode=/c\use_docked_mode=false' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$SDOCK" = "1" ]
	then
		sed -i '/^use_docked_mode=/c\use_docked_mode=true' /storage/.config/yuzu/qt-config.ini
	fi

  #Vysnc
	sed -i '/^use_vsync\\default=/c\use_vsync\\default=false' /storage/.config/yuzu/qt-config.ini
	if [ "$VSYNC" = "0" ]
	then
		sed -i '/^use_vsync=/c\use_vsync=false' /storage/.config/yuzu/qt-config.ini
	fi
	if [ "$VSYNC" = "1" ]
	then
		sed -i '/^use_vsync=/c\use_vsync=true' /storage/.config/yuzu/qt-config.ini
	fi

#Link  .config/yuzu to .local
rm -rf /storage/.local/share/yuzu
ln -sf /storage/.config/yuzu /storage/.local/share/yuzu

#Set QT Platform to Wayland-EGL
export QT_QPA_PLATFORM=wayland-egl

#Run Yuzu emulator
	if [ "$SUI" = "1" ]
	then
		/usr/bin/yuzu
	else
		/usr/bin/yuzu -f -g "${1}"
	fi
