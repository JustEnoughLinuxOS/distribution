#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2021-present - Fewtarius

. /etc/profile

#Set the cores to use
CORES=$(get_setting "cores" "${PLATFORM}" "${ROMNAME##*/}")
if [ "${CORES}" = "little" ]
then
  EMUPERF="${SLOW_CORES}"
elif [ "${CORES}" = "big" ]
then
  EMUPERF="${FAST_CORES}"
else
/storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini  ### All..
  unset EMUPERF
fi

  #Emulation Station Features
  GAME=$(echo "${1}"| sed "s#^/.*/##")
  FSKIP=$(get_setting frame_skip psp "${GAME}")
  FPS=$(get_setting show_fps psp "${GAME}")
  IRES=$(get_setting internal_resolution psp "${GAME}")
  SKIPB=$(get_setting skip_buffer_effects psp "${GAME}")
  VSYNC=$(get_setting vsync psp "${GAME}")

  #Frame Skip
        if [ "$FSKIP" = "0" ]
        then
                sed -i '/^FrameSkip =/c\FrameSkip = 0' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
                sed -i '/^FrameSkipType =/c\FrameSkipType = 0' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
                sed -i '/^AutoFrameSkip =/c\AutoFrameSkip = False' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
        fi
        if [ "$FSKIP" = "1" ]
        then
                sed -i '/^FrameSkip =/c\FrameSkip = 1' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
                sed -i '/^FrameSkipType =/c\FrameSkipType = 0' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
                sed -i '/^AutoFrameSkip =/c\AutoFrameSkip = False' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
        fi
        if [ "$FSKIP" = "2" ]
        then
                sed -i '/^FrameSkip =/c\FrameSkip = 2' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
                sed -i '/^FrameSkipType =/c\FrameSkipType = 0' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
                sed -i '/^AutoFrameSkip =/c\AutoFrameSkip = False' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
        fi
        if [ "$FSKIP" = "3" ]
        then
                sed -i '/^FrameSkip =/c\FrameSkip = 3' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
                sed -i '/^FrameSkipType =/c\FrameSkipType = 0' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
                sed -i '/^AutoFrameSkip =/c\AutoFrameSkip = False' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
        fi
        if [ "$FSKIP" = "auto" ]
        then
                sed -i '/AutoFrameSkip =/c\AutoFrameSkip = True' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
        fi


  #Internal Resolution
        if [ "$IRES" = "1" ]
        then
                sed -i '/^InternalResolution/c\InternalResolution = 1' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
        fi
        if [ "$IRES" = "2" ]
        then
                sed -i '/^InternalResolution/c\InternalResolution = 2' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
        fi
        if [ "$IRES" = "3" ]
        then
                sed -i '/^InternalResolution/c\InternalResolution = 3' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
        fi
        if [ "$IRES" = "4" ]
        then
                sed -i '/^InternalResolution/c\InternalResolution = 4' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
        fi

  #Show FPS
	if [ "$FPS" = "0" ]
	then
  		sed -i '/^iShowStatusFlags =/c\iShowStatusFlags = 0' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
	fi
	if [ "$FPS" = "1" ]
	then
  		sed -i '/^iShowStatusFlags =/c\iShowStatusFlags = 2' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
	fi

  #Skip Buffer Effects
        if [ "$SKIPB" = "0" ]
        then
                sed -i '/^SkipBufferEffects =/c\SkipBufferEffects = False' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
        fi
        if [ "$SKIPB" = "1" ]
        then
                sed -i '/^SkipBufferEffects =/c\SkipBufferEffects = True' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
        fi

  #VSYNC
        if [ "$VSYNC" = "0" ]
        then
                sed -i '/^VSyncInterval =/c\VSyncInterval = False' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
        fi
        if [ "$VSYNC" = "1" ]
        then
                sed -i '/^VSyncInterval =/c\VSyncInterval = True' /storage/.config/ppsspp/PSP/SYSTEM/ppsspp.ini
        fi

ARG=${1//[\\]/}
jslisten set "-9 ppsspp"
${EMUPERF} ppsspp --pause-menu-exit "${ARG}"
