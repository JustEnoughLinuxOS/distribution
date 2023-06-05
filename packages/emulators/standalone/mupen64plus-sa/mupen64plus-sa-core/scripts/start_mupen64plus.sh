#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

#Emulation Station Features
CORE="$1"
GAME=$(echo "${2}"| sed "s#^/.*/##")
ASPECT=$(get_setting game_aspect_ratio n64 "${GAME}")
IRES=$(get_setting internal_resolution n64 "${GAME}")
RSP=$(get_setting rsp_plugin n64 "${GAME}")
FPS=$(get_setting show_fps n64 "${GAME}")
PAK=$(get_setting controller_pak n64 "${GAME}")
CON=$(get_setting input_configuration n64 "${GAME}")
SHARE="/usr/local/share/mupen64plus"
LIB="/usr/local/lib/mupen64plus"
M64PCONF="/storage/.config/mupen64plus/mupen64plus.cfg"
S64INI="/storage/.config/mupen64plus/simple64-gui.ini"
TMP="/tmp/mupen64plus"
GAMEDATA="/storage/.config/mupen64plus"

RESOLUTION=$(batocera-resolution "currentResolution")
RESA=${RESOLUTION%x*}
RESB=${RESOLUTION#*x}
SCREENWIDTH=$((RESA>=RESB ? RESA : RESB))
SCREENHEIGHT=$((RESA<RESB ? RESA : RESB))

if [[ ! -f "$GAMEDATA/custominput.ini" ]]; then
	mkdir -p $GAMEDATA
	cp $SHARE/default.ini $GAMEDATA/custominput.ini
fi

if [[ ! -f "$M64PCONF" ]]; then
	mkdir -p /storage/.config/mupen64plus
	cp $SHARE/mupen64plus.cfg* $M64PCONF
fi

if [[ ! -f "$S64INI" ]]; then
	mkdir -p /storage/.config/mupen64plus
	cp $SHARE/simple64-gui.ini $S64INI
fi

rm -rf $TMP
mkdir -p $TMP

# Unzip or copy the rom to the working directory
if [ $(echo $2 | grep -i .zip | wc -l) -eq 1 ]; then
	#unpack the zip file
  	unzip -q -o "$2" -d $TMP
	ROM=$(unzip -Zl -1 "$2")
else
	cp "$2" $TMP
	ROM="$GAME"
fi

cp $M64PCONF $TMP
cp $S64INI $TMP
SET_PARAMS="--set Core[SharedDataPath]=$TMP --set Video-Rice[ResolutionWidth]=$SCREENWIDTH"

#Set the cores to use
CORES=$(get_setting "cores" "${PLATFORM}" "${ROMNAME##*/}")
if [ "${CORES}" = "little" ]
then
  EMUPERF="${SLOW_CORES}"
elif [ "${CORES}" = "big" ]
then
  EMUPERF="${FAST_CORES}"
else
  ### All..
  unset EMUPERF
fi

#Aspect Ratio
	if [ "${ASPECT}" = "fullscreen" ]; then
		# TODO: Set aspect ratio to fullscreen
		SET_PARAMS="$SET_PARAMS --set Video-General[ScreenWidth]=$SCREENWIDTH --set Video-General[ScreenHeight]=$SCREENHEIGHT --set Video-Glide64mk2[aspect]=2 --set Video-GLideN64[AspectRatio]=3"
	else
		# TODO: Set aspect ratio to 4:3
		if [ "{$CORE}" = "m64p_rice" ]; then
			GAMEWIDTH=$(((SCREENHEIGHT * 4) / 3))
			SET_PARAMS="$SET_PARAMS --set Video-General[ScreenWidth]=$GAMEWIDTH --set Video-General[ScreenHeight]=$SCREENHEIGHT"
		else
			SET_PARAMS="$SET_PARAMS --set Video-General[ScreenWidth]=$SCREENWIDTH --set Video-General[ScreenHeight]=$SCREENHEIGHT --set Video-Glide64mk2[aspect]=0 --set Video-GLideN64[AspectRatio]=1"
		fi
	fi

# Native Res Factor (Upscaling)
	if [ "{$CORE}" = "m64p_gliden64" ]; then
		sed -i "/UseNativeResolutionFactor/c\UseNativeResolutionFactor = $IRES" $TMP/mupen64plus.cfg
	elif [ "{$CORE}" = "simple64" ]; then
		sed -i "/Upscaling/c\Upscaling = $IRES" $TMP/mupen64plus.cfg
	fi


# Input Config
	if [ "${CON}" = "custom" ]; then
		cp $GAMEDATA/custominput.ini $TMP/InputAutoCfg.ini
	elif [ "${CON}" = "standard" ]; then
                cp $SHARE/default.ini $TMP/InputAutoCfg.ini
	else
		cp $SHARE/default.ini $TMP/InputAutoCfg.ini
	fi

# Controller Pak
	sed -i "0,/plugin =/c\plugin = $PAK" $TMP/mupen64plus.cfg

# Show FPS
# Get configuration from system.cfg
	if [ "${FPS}" = "true" ]; then
		sed -i '/ShowFPS = (False|True)/c\ShowFPS = True' $TMP/mupen64plus.cfg
		sed -i '/ShowFPS = [0,1]/c\ShowFPS = 1' $TMP/mupen64plus.cfg
		sed -i '/show_fps/c\show_fps = 1' $TMP/mupen64plus.cfg
	else
		sed -i '/ShowFPS = (False|True)/c\ShowFPS = False' $TMP/mupen64plus.cfg
		sed -i '/ShowFPS = [0,1]/c\ShowFPS = 0' $TMP/mupen64plus.cfg
		sed -i '/show_fps/c\show_fps = 0' $TMP/mupen64plus.cfg
	fi

# RSP
if [ "${RSP}" = "hle" ]; then
	SET_PARAMS="$SET_PARAMS --rsp mupen64plus-rsp-hle.so"
else
	SET_PARAMS="$SET_PARAMS --rsp mupen64plus-rsp-cxd4.so"
fi

echo ${SET_PARAMS}

case $1 in
	"m64p_gliden64")
		${EMUPERF} /usr/local/bin/mupen64plus --configdir $TMP --gfx mupen64plus-video-GLideN64 $SET_PARAMS "$TMP/$ROM"
	;;
	"m64p_gl64mk2")
		${EMUPERF} /usr/local/bin/mupen64plus --configdir $TMP --gfx mupen64plus-video-glide64mk2 $SET_PARAMS "$TMP/$ROM"
	;;
	"m64p_rice")
		${EMUPERF} /usr/local/bin/mupen64plus --configdir $TMP --gfx mupen64plus-video-rice $SET_PARAMS "$TMP/$ROM"
	;;
	"simple64")
		${EMUPERF} /usr/local/bin/simple64-gui --nogui --configdir $TMP $SET_PARAMS "$TMP/$ROM"
	;;
	*)
		${EMUPERF} /usr/local/bin/mupen64plus --configdir $TMP --gfx mupen64plus-video-rice $SET_PARAMS "$TMP/$ROM"
	;;
esac
