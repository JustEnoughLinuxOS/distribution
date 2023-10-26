#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present asoderq (https://github.com/asoderq)

. /etc/profile

export MEDNAFEN_HOME=/storage/.config/mednafen
MEDNAFEN_CONFIG=/usr/config/mednafen.cfg

#Emulation Station Features
GAME=$(echo "${1}"| sed "s#^/.*/##")
CORE=$(echo "${2}"| sed "s#^/.*/##")
PLATFORM=$(echo "${3}"| sed "s#^/.*/##")
STRETCH=$(get_setting stretch "${PLATFORM}" "${GAME}")
SHADER=$(get_setting shader "${PLATFORM}" "${GAME}")

#Set the cores to use
CORES=$(get_setting "cores" "${PLATFORM}" "${GAME}")
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

# delete current config
rm $MEDNAFEN_HOME/mednafen.cfg
# Generate controller config
# Set controller sdl guid
GUID1="$(mednafen --list-joysticks | grep ID | awk 'NR==1 {print $2}')"
sed -e "s/@GUID1@/${GUID1}/g" ${MEDNAFEN_CONFIG} >> $MEDNAFEN_HOME/mednafen.cfg

# Buttons mapping
for CONTROL in DEVICE_BTN_SOUTH DEVICE_BTN_EAST DEVICE_BTN_NORTH         \
               DEVICE_BTN_WEST DEVICE_BTN_TL DEVICE_BTN_TR               \
               DEVICE_BTN_TL2 DEVICE_BTN_TR2 DEVICE_BTN_SELECT           \
               DEVICE_BTN_START DEVICE_BTN_MODE DEVICE_BTN_THUMBL        \
               DEVICE_BTN_THUMBR DEVICE_BTN_DPAD_UP DEVICE_BTN_DPAD_DOWN \
               DEVICE_BTN_DPAD_LEFT DEVICE_BTN_DPAD_RIGHT
do
  sed -i -e "s/@${CONTROL}@/button_${!CONTROL}/g" $MEDNAFEN_HOME/mednafen.cfg
done

#Set Save folder
  sed -i -e "s/@PLATFORM@/${PLATFORM}/g" $MEDNAFEN_HOME/mednafen.cfg

# Get command line switches
FEATURES_CMDLINE=""
if [[ "${CORE}" =~ pce[_fast] ]]
then
    if [ "$(get_setting nospritelimit ${PLATFORM} "${GAME}")" = "1" ]
    then
        FEATURES_CMDLINE+=" -${CORE}.nospritelimit 1"
    else
        FEATURES_CMDLINE+=" -${CORE}.nospritelimit 0"
    fi
    if [ "$(get_setting forcesgx ${PLATFORM} "${GAME}")" = "1" ]
    then
        FEATURES_CMDLINE+=" -${CORE}.forcesgx 1"
    else
        FEATURES_CMDLINE+=" -${CORE}.forcesgx 0"
    fi
    if [ "${CORE}" = pce_fast ]
    then
        OCM=$(get_setting ocmultiplier ${PLATFORM} "${GAME}")
        if [ ${OCM} > 1 ]
        then
            FEATURES_CMDLINE+=" -${CORE}.ocmultiplier ${OCM}"
        else
            FEATURES_CMDLINE+=" -${CORE}.ocmultiplier 1"
        fi
        CDS=$(get_setting cdspeed ${PLATFORM} "${GAME}")
        if [ ${CDS} > 1 ]
        then
            FEATURES_CMDLINE+=" -${CORE}.cdspeed ${CDS}"
        else
            FEATURES_CMDLINE+=" -${CORE}.cdspeed 1"
        fi
    fi
elif [ "${CORE}" = "gb" ]
then
    ST=$(get_setting system_type "${PLATFORM}" "${GAME}")
    if [[ "${ST}" =~ auto|dmg|cgb|agb  ]]
    then
        FEATURES_CMDLINE+=" -${CORE}.system_type ${ST}"
    else
        FEATURES_CMDLINE+=" -${CORE}.system_type auto"
    fi
elif [ "${CORE}" = "gba" ]
then
    if [ $(get_setting tblur "${PLATFORM}" "${GAME}") = "1" ]
    then
        FEATURES_CMDLINE+=" -${CORE}.tblur 1"
    else
        FEATURES_CMDLINE+=" -${CORE}.tblur 0"
    fi
elif [ "${CORE}" = "nes" ]
then
    if [ $(get_setting clipsides "${PLATFORM}" "${GAME}") = "1" ]
    then
        FEATURES_CMDLINE+=" -${CORE}.clipsides 1"
    else
        FEATURES_CMDLINE+=" -${CORE}.clipsides 0"
    fi
    if [ $(get_setting no8lim "${PLATFORM}" "${GAME}") = "1" ]
    then
        FEATURES_CMDLINE+=" -${CORE}.no8lim 1"
    else
        FEATURES_CMDLINE+=" -${CORE}.no8lim 0"
    fi
elif [ "${CORE}" = "vb" ]
then
    CE=$(get_setting cpu_emulation "${PLATFORM}" "${GAME}")
    if [[ "${CE}" =~ fast|accurate  ]]
    then
        FEATURES_CMDLINE+=" -${CORE}.cpu_emulation ${CE}"
    else
        FEATURES_CMDLINE+=" -${CORE}.cpu_emulation fast"
    fi
    DM=$(get_setting 3dmode "${PLATFORM}" "${GAME}")
    if [[ "${DM}" =~ anaglyph|cscope|sidebyside|vli|hli|left|right]  ]]
    then
        FEATURES_CMDLINE+=" -${CORE}.3dmode ${CE}"
    fi
elif [ "${CORE}" = "pcfx" ]
then
    CE=$(get_setting cpu_emulation "${PLATFORM}" "${GAME}")
    if [[ "${CE}" =~ auto|fast|accurate  ]]
    then
        FEATURES_CMDLINE+=" -${CORE}.cpu_emulation ${CE}"
    else
        FEATURES_CMDLINE+=" -${CORE}.cpu_emulation auto"
    fi
    CS=$(get_setting cdspeed "${PLATFORM}" "${GAME}")
    if [ CS > 2]
    then
        FEATURES_CMDLINE+=" -${CORE}.cdspeed ${CS}"
    else
        FEATURES_CMDLINE+=" -${CORE}.cdspeed 2"
    fi
elif [ "${CORE}" = "ss" ]
then
    IP1=$(get_setting input.port1 "${PLATFORM}" "${GAME}")
    if [[ "${IP1}" =~ gamepad|3dpad|gun  ]]
    then
        FEATURES_CMDLINE+=" -${CORE}.input.port1 ${IP1}"
    else
        FEATURES_CMDLINE+=" -${CORE}.input.port1 gamepad"
    fi
    IP13DMODE=$(get_setting input.port1.3dpad.mode.defpos "${PLATFORM}" "${GAME}")
    if [[ "${IP13DMODE}" =~ digital|analog  ]]
    then
        FEATURES_CMDLINE+=" -${CORE}.input.port1.3dpad.mode.defpos ${IP13DMODE}"
    else
        FEATURES_CMDLINE+=" -${CORE}.input.port1.3dpad.mode.defpos analog"
    fi
    CART=$(get_setting cart "${PLATFORM}" "${GAME}")
    if [[ "${CART}" =~ auto|none|backup|extram1|extram4|cs1ram16  ]]
    then
        FEATURES_CMDLINE+=" -${CORE}.cart ${CART}"
    else
        FEATURES_CMDLINE+=" -${CORE}.cart auto"
    fi
    CARTAD=$(get_setting cart.auto_default "${PLATFORM}" "${GAME}")
    if [[ "${CARTAD}" =~ none|backup|extram1|extram4|cs1ram16  ]]
    then
        FEATURES_CMDLINE+=" -${CORE}.cart.auto_default ${CARTAD}"
    else
        FEATURES_CMDLINE+=" -${CORE}.cart.auto_default none"
    fi
fi

#Run mednafen
${EMUPERF} /usr/bin/mednafen -force_module ${CORE} -${CORE}.stretch ${STRETCH:="aspect"} -${CORE}.shader ${SHADER:="ipsharper"} ${FEATURES_CMDLINE} "${1}"
