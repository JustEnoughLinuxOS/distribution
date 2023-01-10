#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Frank Hartung (supervisedthinking (@) gmail.com)
# Copyright (C) 2022-present Fewtarius

# Source environment variables
. /etc/profile

# Ensure we're using pulseaudio
rr_audio.sh pulseaudio
export SDL_AUDIODRIVER=pulseaudio

# Set up mime db
mkdir -p /storage/.local/share/mime/packages
cp -rf /usr/share/mime/packages/* /storage/.local/share/mime/packages
update-mime-database /storage/.local/share/mime

# Set common paths
CEMU_CONFIG_ROOT="/storage/.config/Cemu"
CEMU_CACHE_LOG="${CEMU_CONFIG_ROOT}/share/log.txt"
CEMU_VAR_LOG="/var/log/Cemu.log"
CEMU_HOME_CONFIG="${CEMU_CONFIG_ROOT}/share"
CEMU_HOME_LOCAL="/storage/.local/share/Cemu"

# create link to config directory
if [ ! -d ${CEMU_HOME_CONFIG} ]; then
  mkdir -p ${CEMU_HOME_CONFIG}
  echo created ${CEMU_HOME_CONFIG}
fi

if [ -d ${CEMU_HOME_LOCAL} ] && [ ! -L ${CEMU_HOME_LOCAL} ]; then
    cp -rf ${CEMU_HOME_LOCAL}/* ${CEMU_HOME_CONFIG}
    rm -rf ${CEMU_HOME_LOCAL}
    echo moved ${CEMU_HOME_LOCAL} to ${CEMU_HOME_CONFIG}
fi

if [ ! -L ${CEMU_HOME_LOCAL} ]; then
  ln -sf ${CEMU_HOME_CONFIG} ${CEMU_HOME_LOCAL}
  echo created symlink from ${CEMU_HOME_CONFIG} to ${CEMU_HOME_LOCAL}
fi

# Create symlink to logfile
if [ ! -L ${CEMU_VAR_LOG} ]; then
  ln -sf ${CEMU_CACHE_LOG} ${CEMU_VAR_LOG}
fi

# Make sure CEMU settings exist, and set the audio output.
if [ ! -f "${CEMU_CONFIG_ROOT}/settings.xml" ]
then
  cp -f /usr/config/Cemu/settings.xml ${CEMU_CONFIG_ROOT}/settings.xml
fi

# Make sure the basic controller profiles exist.
if [ ! -f "${CEMU_CONFIG_ROOT}/controllerProfiles/controller0.xml" ]
then
  if [ ! -d "${CEMU_CONFIG_ROOT}/controllerProfiles" ]
  then
    mkdir -p ${CEMU_CONFIG_ROOT}
  di
  cp /usr/config/Cemu/controllerProfiles/controller0.xml ${CEMU_CONFIG_ROOT}/controllerProfiles/
fi

FILE=$(echo $@ | sed "s#^/.*/##g")
FPS=$(get_setting show_fps wiiu "${FILE}")
CON=$(get_setting wiiu_controller_profile wiiu "${FILE}")

if [ -z "${FPS}" ]
then
  FPS="0"
fi
if [ -z "${CON}" ]
then
  CON="Wii U GamePad"
fi

xmlstarlet ed --inplace -u "//Overlay/Position" -v "${FPS}" ${CEMU_CONFIG_ROOT}/settings.xml
xmlstarlet ed --inplace -u "//fullscreen" -v "true" ${CEMU_CONFIG_ROOT}/settings.xml
xmlstarlet ed --inplace -u "//Audio/TVDevice" -v "$(pactl get-default-sink)" ${CEMU_CONFIG_ROOT}/settings.xml
xmlstarlet ed --inplace -u "//emulated_controller/type" -v "${CON}" ${CEMU_CONFIG_ROOT}/controllerProfiles/controller0.xml

# Run the emulator
cemu -g "$@"
rr_audio.sh alsa
