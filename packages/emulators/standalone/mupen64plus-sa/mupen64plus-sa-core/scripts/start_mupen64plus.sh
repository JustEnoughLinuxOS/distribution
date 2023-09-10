#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

. /etc/profile

jslisten set "-9 mupen64plus"

# Emulation Station Features
GAME=$(echo "${1}"| sed "s#^/.*/##")
SCREENWIDTH=$(fbwidth)
SCREENHEIGHT=$(fbheight)
ASPECT=$(get_setting game_aspect_ratio n64 "${GAME}")
IRES=$(get_setting internal_resolution n64 "${GAME}")
RSP=$(get_setting rsp_plugin n64 "${GAME}")
SIMPLECORE=$(get_setting core_plugin n64 "${GAME}")
FPS=$(get_setting show_fps n64 "${GAME}")
PAK=$(get_setting controller_pak n64 "${GAME}")
CON=$(get_setting input_configuration n64 "${GAME}")
VPLUGIN=$(get_setting video_plugin n64 "${GAME}")

SHARE="/usr/local/share/mupen64plus"
GAMEDATA="/storage/.config/mupen64plus"
M64PCONF="${GAMEDATA}/mupen64plus.cfg"
CUSTOMINP="${GAMEDATA}/custominput.ini"
TMP="/tmp/mupen64plus"

rm -rf ${TMP}
mkdir -p ${TMP}
mkdir -p ${GAMEDATA}

if [[ ! -f "${M64PCONF}" ]]; then
    cp ${SHARE}/mupen64plus.cfg* ${M64PCONF}
fi

if [[ ! -f "${CUSTOMINP}" ]]; then
    cp ${SHARE}/default.ini ${CUSTOMINP}
fi

cp ${M64PCONF} ${TMP}

# Input Config
if [ "${CON}" = "custom" ]; then
    cp ${CUSTOMINP} ${TMP}/InputAutoCfg.ini
elif [ "${CON}" = "standard" ]; then
    cp ${SHARE}/default.ini ${TMP}/InputAutoCfg.ini
else
    cp ${SHARE}/default.ini ${TMP}/InputAutoCfg.ini
fi

# Unzip or copy the rom to the working directory
if [ $(echo $1 | grep -i .zip | wc -l) -eq 1 ]; then
    #unpack the zip file
    unzip -q -o "$1" -d ${TMP}
    ROM=$(unzip -Zl -1 "$1")
else
    cp "$1" ${TMP}
    ROM="${GAME}"
fi

# Set the cores to use
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

SET_PARAMS=""
SET_PARAMS+=" --set Core[SharedDataPath]=${TMP}"

# SIMPLECORE, decide which executable to use for simple64
if [ "${SIMPLECORE}" = "simple" ]; then
    SIMPLESUFFIX="-simple"
    SET_PARAMS+=" --set Core[R4300Emulator]=1"
else
    SIMPLESUFFIX=""
    SET_PARAMS+=" --set Core[R4300Emulator]=2"
fi

# Controller Pak
SET_PARAMS+=" --set Input-SDL-Control1[plugin]=${PAK}"
SET_PARAMS+=" --set Input-SDL-Control2[plugin]=${PAK}"
SET_PARAMS+=" --set Input-SDL-Control3[plugin]=${PAK}"
SET_PARAMS+=" --set Input-SDL-Control4[plugin]=${PAK}"

# Aspect Ratio
SET_PARAMS+=" --set Video-General[ScreenHeight]=${SCREENHEIGHT}"
SET_PARAMS+=" --set Video-Parallel[ScreenWidth]=${SCREENWIDTH}"
SET_PARAMS+=" --set Video-Parallel[ScreenHeight]=${SCREENHEIGHT}"
SET_PARAMS+=" --set Video-Rice[ResolutionWidth]=${SCREENWIDTH}"
if [ "${ASPECT}" = "fullscreen" ]; then
    # TODO: Set aspect ratio to fullscreen
    SET_PARAMS+=" --set Video-General[ScreenWidth]=${SCREENWIDTH}"
    SET_PARAMS+=" --set Video-Glide64mk2[aspect]=2"
    SET_PARAMS+=" --set Video-GLideN64[AspectRatio]=3"
    SET_PARAMS+=" --set Video-Parallel[WidescreenStretch]=False"
else
    # TODO: Set aspect ratio to 4:3
    if [ "${VPLUGIN}" = "rice" ]; then
        GAMEWIDTH=$(((SCREENHEIGHT * 4) / 3))
        SET_PARAMS+=" --set Video-General[ScreenWidth]=${GAMEWIDTH}"
    else
        SET_PARAMS+=" --set Video-General[ScreenWidth]=${SCREENWIDTH}"
    fi
    SET_PARAMS+=" --set Video-Parallel[WidescreenStretch]=False"
    SET_PARAMS+=" --set Video-Glide64mk2[aspect]=0"
    SET_PARAMS+=" --set Video-GLideN64[AspectRatio]=1"
fi

# Native Res Factor (Upscaling)
SET_PARAMS+=" --set Video-GLideN64[UseNativeResolutionFactor]=${IRES}"
SET_PARAMS+=" --set Video-Parallel[Upscaling]=${IRES}"

# Show FPS
# Get configuration from system.cfg
if [ "${FPS}" = "true" ]; then
    export LIBGL_SHOW_FPS="1"
    export GALLIUM_HUD="cpu+GPU-load+fps"
    SET_PARAMS+=" --set Video-GLideN64[ShowFPS]=True"
    #SET_PARAMS+=" --set Video-Glide64mk2[show_fps]=1"
    #SET_PARAMS+=" --set Video-Rice[ShowFPS]=True"
else
    export LIBGL_SHOW_FPS="0"
    export GALLIUM_HUD="off"
    SET_PARAMS+=" --set Video-GLideN64[ShowFPS]=False"
    #SET_PARAMS+=" --set Video-Glide64mk2[show_fps]=0"
    #SET_PARAMS+=" --set Video-Rice[ShowFPS]=False"
fi

# Set the video plugin
case ${VPLUGIN} in
    "rmg_parallel")
        SET_PARAMS+=" --gfx mupen64plus-video-parallel${SIMPLESUFFIX}.so"
        RSP="parallel"
    ;;
    "gliden64")
        SET_PARAMS+=" --gfx mupen64plus-video-GLideN64${SIMPLESUFFIX}.so"
    ;;
    "gl64mk2")
        SET_PARAMS+=" --gfx mupen64plus-video-glide64mk2${SIMPLESUFFIX}.so"
    ;;
    "rice")
        SET_PARAMS+=" --gfx mupen64plus-video-rice${SIMPLESUFFIX}.so"
    ;;
    *)
        SET_PARAMS+=" --gfx mupen64plus-video-rice${SIMPLESUFFIX}.so"
    ;;
esac

# Set the RSP plugin
case "${RSP}" in
    "parallel")
        SET_PARAMS+=" --rsp mupen64plus-rsp-parallel${SIMPLESUFFIX}.so"
    ;;
    "hle")
        SET_PARAMS+=" --rsp mupen64plus-rsp-hle${SIMPLESUFFIX}.so"
    ;;
    *)
        SET_PARAMS+=" --rsp mupen64plus-rsp-cxd4${SIMPLESUFFIX}.so"
    ;;
esac

# Set the remaining plugins
SET_PARAMS+=" --input mupen64plus-input-sdl${SIMPLESUFFIX}.so"
SET_PARAMS+=" --audio mupen64plus-audio-sdl${SIMPLESUFFIX}.so"

echo ${SET_PARAMS}

${EMUPERF} /usr/local/bin/mupen64plus${SIMPLESUFFIX} --configdir ${TMP} ${SET_PARAMS} "${TMP}/${ROM}"
