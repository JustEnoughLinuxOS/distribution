#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

#Check if primehack exists in .config
if [ ! -d "/storage/.config/primehack" ]; then
    mkdir -p "/storage/.config/primehack"
        cp -r "/usr/config/prime" "/storage/.config/"
fi

#Check if Wii custom controller profile exists in .config/dolphin-emu
if [ ! -f "/storage/.config/primehack/Custom_WiimoteNew.ini" ]; then
        cp -r "/usr/config/primehack/WiiControllerProfiles/remote.ini" "/storage/.config/primehack/Custom_WiimoteNew.ini"
fi

#Gamecube controller profile needed for hotkeys to work
cp -r "/usr/config/primehack/GCPadNew.ini" "/storage/.config/primehack/GCPadNew.ini"

#Link Save States to /roms/savestates/wii
if [ ! -d "/storage/roms/savestates/wii/" ]; then
    mkdir -p "/storage/roms/savestates/wii/"
fi

rm -rf /storage/.config/primehack/StateSaves
ln -sf /storage/roms/savestates/wii /storage/.config/primehack/StateSaves

  #Emulation Station options
  GAME=$(echo "${1}"| sed "s#^/.*/##")
  AA=$(get_setting anti_aliasing wii "${GAME}")
  ASPECT=$(get_setting aspect_ratio wii "${GAME}")
  RENDERER=$(get_setting graphics_backend wii "${GAME}")
  IRES=$(get_setting internal_resolution wii "${GAME}")
  FPS=$(get_setting show_fps wii "${GAME}")
  CON=$(get_setting wii_controller_profile wii "${GAME}")

  #Anti-Aliasing
	if [ "$AA" = "0" ]
	then
  		sed -i '/MSAA/c\MSAA = 0' /storage/.config/primehack/GFX.ini
		sed -i '/SSAA/c\SSAA = False' /storage/.config/primehack/GFX.ini
	fi
	if [ "$AA" = "2m" ]
	then
  		sed -i '/MSAA/c\MSAA = 2' /storage/.config/primehack/GFX.ini
		sed -i '/SSAA/c\SSAA = False' /storage/.config/primehack/GFX.ini
	fi
        if [ "$AA" = "2s" ]
        then
                sed -i '/MSAA/c\MSAA = 2' /storage/.config/primehack/GFX.ini
		sed -i '/SSAA/c\SSAA = True' /storage/.config/primehack/GFX.ini
        fi
	if [ "$AA" = "4m" ]
	then
  		sed -i '/MSAA/c\MSAA = 4' /storage/.config/primehack/GFX.ini
                sed -i '/SSAA/c\SSAA = False' /storage/.config/primehack/GFX.ini
	fi
        if [ "$AA" = "4s" ]
        then
                sed -i '/MSAA/c\MSAA = 4' /storage/.config/primehack/GFX.ini
		sed -i '/SSAA/c\SSAA = True' /storage/.config/primehack/GFX.ini
        fi
	if [ "$AA" = "8m" ]
	then
  		sed -i '/MSAA/c\MSAA = 8' /storage/.config/primehack/GFX.ini
		sed -i '/SSAA/c\SSAA = False' /storage/.config/primehack/GFX.ini
	fi
        if [ "$AA" = "8s" ]
        then
                sed -i '/MSAA/c\MSAA = 8' /storage/.config/primehack/GFX.ini
		sed -i '/SSAA/c\SSAA = True' /storage/.config/primehack/GFX.ini
        fi

  #Aspect Ratio
	if [ "$ASPECT" = "0" ]
	then
  		sed -i '/AspectRatio/c\AspectRatio = 0' /storage/.config/primehack/GFX.ini
	fi
	if [ "$ASPECT" = "1" ]
	then
  		sed -i '/AspectRatio/c\AspectRatio = 1' /storage/.config/primehack/GFX.ini
	fi
	if [ "$ASPECT" = "2" ]
	then
  		sed -i '/AspectRatio/c\AspectRatio = 2' /storage/.config/primehack/GFX.ini
	fi
	if [ "$ASPECT" = "3" ]
	then
  		sed -i '/AspectRatio/c\AspectRatio = 3' /storage/.config/primehack/GFX.ini
	fi

  #Video Backend
	if [ "$RENDERER" = "opengl" ]
	then
  		sed -i '/GFXBackend/c\GFXBackend = OGL' /storage/.config/primehack/Dolphin.ini
	fi

	if [ "$RENDERER" = "vulkan" ]
	then
  		sed -i '/GFXBackend/c\GFXBackend = Vulkan' /storage/.config/primehack/Dolphin.ini
	fi
        if [ "$RENDERER" = "software" ]
        then
                sed -i '/GFXBackend/c\GFXBackend = Software Renderer' /storage/.config/primehack/Dolphin.ini
        fi

  #Internal Resolution
        if [ "$IRES" = "1" ]
        then
                sed -i '/InternalResolution/c\InternalResolution = 1' /storage/.config/primehack/GFX.ini
        fi
        if [ "$IRES" = "2" ]
        then
                sed -i '/InternalResolution/c\InternalResolution = 2' /storage/.config/primehack/GFX.ini
        fi
        if [ "$IRES" = "3" ]
        then
                sed -i '/InternalResolution/c\InternalResolution = 3' /storage/.config/primehack/GFX.ini
        fi

  #Show FPS
	if [ "$FPS" = "true" ]
	then
  		sed -i '/ShowFPS/c\ShowFPS = True' /storage/.config/primehack/GFX.ini
	fi
	if [ "$FPS" = "false" ]
	then
  		sed -i '/ShowFPS/c\ShowFPS = False' /storage/.config/primehack/GFX.ini
	fi

  #Wii Controller Profile
        if [ "$CON" = "remote" ]
        then
		cp -r /usr/config/primehack/WiiControllerProfiles/remote.ini /storage/.config/primehack/WiimoteNew.ini
        fi
        if [ "$CON" = "nunchuck" ]
        then
                cp -r /usr/config/primehack/WiiControllerProfiles/nunchuck.ini /storage/.config/primehack/WiimoteNew.ini
        fi
        if [ "$CON" = "classic" ]
        then
                cp -r /usr/config/primehack/WiiControllerProfiles/classic.ini /storage/.config/primehack/WiimoteNew.ini
        fi
        if [ "$CON" = "custom" ]
        then
                cp -r /storage/.config/primehack/Custom_WiimoteNew.ini /storage/.config/primehack/WiimoteNew.ini
        fi

#Link  .config/dolphin-emu to .local
rm -rf /storage/.local/share/primehack
ln -sf /storage/.config/primehack /storage/.local/share/primehack

#Run Dolphin emulator
/usr/bin/primehack-nogui -p wayland -a HLE -e "${1}"
