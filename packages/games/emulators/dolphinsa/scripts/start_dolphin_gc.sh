#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

#Check if dolphin-emu exists in .config
if [ ! -d "/storage/.config/dolphin-emu" ]; then
    mkdir -p "/storage/.config/dolphin-emu"
        cp -r "/usr/config/dolphin-emu" "/storage/.config/"
fi

#Check if GC custom controller profile exists in .config/dolphin-emu
if [ ! -f "/storage/.config/dolphin-emu/Custom_GCPadNew.ini" ]; then
        cp -r "/usr/config/dolphin-emu/GCPadNew.ini" "/storage/.config/dolphin-emu/Custom_GCPadNew.ini"
fi

#Link Save States to /roms/savestates
if [ ! -d "/storage/roms/savestates/gamecube/" ]; then
    mkdir -p "/storage/roms/savestates/gamecube/"
fi

rm -rf /storage/.config/dolphin-emu/StateSaves
ln -sf /storage/roms/savestates/gamecube /storage/.config/dolphin-emu/StateSaves

  #Emulation Station Features
  GAME=$(echo "${1}"| sed "s#^/.*/##")
  AA=$(get_setting anti_aliasing gamecube "${GAME}")
  ASPECT=$(get_setting aspect_ratio gamecube "${GAME}")
  RENDERER=$(get_setting graphics_backend gamecube "${GAME}")
  IRES=$(get_setting internal_resolution gamecube "${GAME}")
  FPS=$(get_setting show_fps gamecube "${GAME}")
  CON=$(get_setting gamecube_controller_profile gamecube "${GAME}")

  #Anti-Aliasing
	if [ "$AA" = "0" ]
	then
  		sed -i '/MSAA/c\MSAA = 0' /storage/.config/dolphin-emu/GFX.ini
		sed -i '/SSAA/c\SSAA = False' /storage/.config/dolphin-emu/GFX.ini
	fi
	if [ "$AA" = "2m" ]
	then
  		sed -i '/MSAA/c\MSAA = 2' /storage/.config/dolphin-emu/GFX.ini
		sed -i '/SSAA/c\SSAA = False' /storage/.config/dolphin-emu/GFX.ini
	fi
        if [ "$AA" = "2s" ]
        then
                sed -i '/MSAA/c\MSAA = 2' /storage/.config/dolphin-emu/GFX.ini
		sed -i '/SSAA/c\SSAA = True' /storage/.config/dolphin-emu/GFX.ini
        fi
	if [ "$AA" = "4m" ]
	then
  		sed -i '/MSAA/c\MSAA = 4' /storage/.config/dolphin-emu/GFX.ini
                sed -i '/SSAA/c\SSAA = False' /storage/.config/dolphin-emu/GFX.ini
	fi
        if [ "$AA" = "4s" ]
        then
                sed -i '/MSAA/c\MSAA = 4' /storage/.config/dolphin-emu/GFX.ini
		sed -i '/SSAA/c\SSAA = True' /storage/.config/dolphin-emu/GFX.ini
        fi
	if [ "$AA" = "8m" ]
	then
  		sed -i '/MSAA/c\MSAA = 8' /storage/.config/dolphin-emu/GFX.ini
		sed -i '/SSAA/c\SSAA = False' /storage/.config/dolphin-emu/GFX.ini
	fi
        if [ "$AA" = "8s" ]
        then
                sed -i '/MSAA/c\MSAA = 8' /storage/.config/dolphin-emu/GFX.ini
		sed -i '/SSAA/c\SSAA = True' /storage/.config/dolphin-emu/GFX.ini
        fi

  #Aspect Ratio
	if [ "$ASPECT" = "0" ]
	then
  		sed -i '/AspectRatio/c\AspectRatio = 0' /storage/.config/dolphin-emu/GFX.ini
	fi
	if [ "$ASPECT" = "1" ]
	then
  		sed -i '/AspectRatio/c\AspectRatio = 1' /storage/.config/dolphin-emu/GFX.ini
	fi
	if [ "$ASPECT" = "2" ]
	then
  		sed -i '/AspectRatio/c\AspectRatio = 2' /storage/.config/dolphin-emu/GFX.ini
	fi
	if [ "$ASPECT" = "3" ]
	then
  		sed -i '/AspectRatio/c\AspectRatio = 3' /storage/.config/dolphin-emu/GFX.ini
	fi

  #Video Backend
	if [ "$RENDERER" = "opengl" ]
	then
  		sed -i '/GFXBackend/c\GFXBackend = OGL' /storage/.config/dolphin-emu/Dolphin.ini
	fi

	if [ "$RENDERER" = "vulkan" ]
	then
  		sed -i '/GFXBackend/c\GFXBackend = Vulkan' /storage/.config/dolphin-emu/Dolphin.ini
	fi
        if [ "$RENDERER" = "software" ]
        then
                sed -i '/GFXBackend/c\GFXBackend = Software Renderer' /storage/.config/dolphin-emu/Dolphin.ini
        fi

  #Internal Resolution
        if [ "$IRES" = "1" ]
        then
                sed -i '/InternalResolution/c\InternalResolution = 1' /storage/.config/dolphin-emu/GFX.ini
        fi
        if [ "$IRES" = "2" ]
        then
                sed -i '/InternalResolution/c\InternalResolution = 2' /storage/.config/dolphin-emu/GFX.ini
        fi
        if [ "$IRES" = "3" ]
        then
                sed -i '/InternalResolution/c\InternalResolution = 3' /storage/.config/dolphin-emu/GFX.ini
        fi

  #Show FPS
	if [ "$FPS" = "false" ]
	then
  		sed -i '/ShowFPS/c\ShowFPS = False' /storage/.config/dolphin-emu/GFX.ini
	fi
	if [ "$FPS" = "true" ]
	then
  		sed -i '/ShowFPS/c\ShowFPS = true' /storage/.config/dolphin-emu/GFX.ini
	fi

  #GC Controller Profile
        if [ "$CON" = "gcpad" ]
        then
                cp -r /usr/config/dolphin-emu/GCPadNew.ini /storage/.config/dolphin-emu/GCPadNew.ini
        fi
        if [ "$CON" = "custom" ]
        then
                cp -r /storage/.config/dolphin-emu/Custom_GCPadNew.ini /storage/.config/dolphin-emu/GCPadNew.ini
        fi

#Link  .config/dolphin-emu to .local
rm -rf /storage/.local/share/dolphin-emu
ln -sf /storage/.config/dolphin-emu /storage/.local/share/dolphin-emu

#Run Dolphin emulator
/usr/bin/dolphin-emu-nogui -p @DOLPHIN_PLATFORM@ -a HLE -e "${1}"
