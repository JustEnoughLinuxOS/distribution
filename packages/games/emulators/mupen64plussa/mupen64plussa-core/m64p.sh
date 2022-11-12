#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

echo 'starting mupen64plus stand alone emulator...'

CORE="$1"
ROM="${2##*/}"
PLATFORM="n64"
SHARE="/usr/local/share/mupen64plus"
INPUTCFGBASE="$SHARE/InputAutoCfg.ini"
CONF="/storage/.config/system/configs/system.cfg"
M64PCONF="/storage/.config/game/configs/mupen64plussa/mupen64plus.cfg"
TMP="/tmp/mupen64plussa"
GAMEDATA="/storage/.config/game/configs/mupen64plussa"

rm -rf $TMP
mkdir -p $TMP

function get_setting() {
	#We look for the setting on the ROM first, if not found we search for platform and lastly we search globally
	PAT="s|^${PLATFORM}\[\"${ROM}\"\].*${1}=\(.*\)|\1|p"
	EES=$(sed -n "${PAT}" "${CONF}" | head -1)

	if [ -z "${EES}" ]; then
		PAT="s|^${PLATFORM}[\.-]${1}=\(.*\)|\1|p"
		EES=$(sed -n "${PAT}" "${CONF}" | head -1)
	fi

	if [ -z "${EES}" ]; then
		PAT="s|^global[\.-].*${1}=\(.*\)|\1|p"
		EES=$(sed -n "${PAT}" "${CONF}" | head -1)
	fi

	[ -z "${EES}" ] && EES="false"
}

if [[ ! -f "$GAMEDATA/custominput.ini" ]]; then
	mkdir -p $GAMEDATA
	cp $SHARE/default.ini $GAMEDATA/custominput.ini
fi

if [[ ! -f "$M64PCONF" ]]; then
	mkdir -p /storage/.config/game/configs/mupen64plussa
	cp $SHARE/mupen64plus.cfg $M64PCONF
fi

cp $M64PCONF $TMP

RESOLUTION=$(batocera-resolution "currentResolution")
echo ${RESOLUTION}
RESA=${RESOLUTION%x*}
RESB=${RESOLUTION#*x}
SCREENWIDTH=$((RESA>=RESB ? RESA : RESB))
echo ${SCREENWIDTH}
SCREENHEIGHT=$((RESA<RESB ? RESA : RESB))
echo ${SCREENHEIGHT}

SET_PARAMS="--set Core[SharedDataPath]=$TMP --set Video-Rice[ResolutionWidth]=$SCREENWIDTH"

# Game Aspect Ratio
# Get configuration from system.cfg
get_setting "game_aspect_ratio"
echo ${EES}
if [ "${EES}" == "fullscreen" ]; then
	# TODO: Set aspect ratio to fullscreen
	SET_PARAMS="$SET_PARAMS --set Video-General[ScreenWidth]=$SCREENWIDTH --set Video-General[ScreenHeight]=$SCREENHEIGHT --set Video-Glide64mk2[aspect]=2 --set Video-GLideN64[AspectRatio]=3"
else
	# TODO: Set aspect ratio to 4:3
	if [ $1 = "m64p_rice" ]; then
		GAMEWIDTH=$(((SCREENHEIGHT * 4) / 3))
		SET_PARAMS="$SET_PARAMS --set Video-General[ScreenWidth]=$GAMEWIDTH --set Video-General[ScreenHeight]=$SCREENHEIGHT"
	else
	SET_PARAMS="$SET_PARAMS --set Video-General[ScreenWidth]=$SCREENWIDTH --set Video-General[ScreenHeight]=$SCREENHEIGHT --set Video-Glide64mk2[aspect]=0 --set Video-GLideN64[AspectRatio]=1"
	fi
fi

# Game Aspect Ratio
# Get configuration from system.cfg
get_setting "input_configuration"
echo ${EES}
if [ "${EES}" == "zlswap" ]; then
	#cat $INPUTCFGBASE <(echo) $SHARE/zlswap.ini > $TMP/InputAutoCfg.ini
	cp $SHARE/zlswap.ini $TMP/InputAutoCfg.ini
elif [ "${EES}" == "custom" ]; then
	cp $GAMEDATA/custominput.ini $TMP/InputAutoCfg.ini
else
	# Default
	cp $SHARE/default.ini $TMP/InputAutoCfg.ini
fi

# Show FPS
# Get configuration from system.cfg
get_setting "show_fps"
echo ${EES}
if [ "${EES}" == "auto" ] || [ "${EES}" == "disabled" ] || [ "${EES}" == "false" ] || [ "${EES}" == "none" ] || [ "${EES}" == "0" ]; then
	SET_PARAMS="$SET_PARAMS --set Video-Glide64mk2[show_fps]=0 --set Video-Rice[ShowFPS]=\"False\" --set Video-GLideN64[ShowFPS]=0"
else
	SET_PARAMS="$SET_PARAMS --set Video-Glide64mk2[show_fps]=1 --set Video-Rice[ShowFPS]=\"True\" --set Video-GLideN64[ShowFPS]=1"
fi

# RSP
get_setting "rsp_plugin"
echo ${EES}
if [ "${EES}" == "default" ] || [ "${EES}" == "hle" ]; then
	SET_PARAMS="$SET_PARAMS --set UI-Console[RspPlugin]=\"mupen64plus-rsp-hle.so\""
else
	SET_PARAMS="$SET_PARAMS --set UI-Console[RspPlugin]=\"mupen64plus-rsp-cxd4.so\""
fi

echo ${SET_PARAMS}

case $1 in
	"m64p_gliden64")
		/usr/local/bin/mupen64plus --configdir $TMP --gfx mupen64plus-video-GLideN64 $SET_PARAMS "$2"
	;;
	"m64p_gl64mk2")
		/usr/local/bin/mupen64plus --configdir $TMP --gfx mupen64plus-video-glide64mk2 $SET_PARAMS "$2"
	;;
	"m64p_rice")
		/usr/local/bin/mupen64plus --configdir $TMP --gfx mupen64plus-video-rice $SET_PARAMS "$2"
	;;
	*)
		/usr/local/bin/mupen64plus --configdir $TMP --gfx mupen64plus-video-rice $SET_PARAMS "$2"
	;;
esac
