#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Frank Hartung (supervisedthinking (@) gmail.com)
# Copyright (C) 2022-present Fewtarius

# Source environment variables
. /etc/profile

# Enable jslisten
jslisten set "cemu"

# Ensure we're using pulseaudio
rr_audio.sh pulseaudio
export SDL_AUDIODRIVER=pulseaudio

# Set up mime db
mkdir -p /storage/.local/share/mime/packages
cp -rf /usr/share/mime/packages/* /storage/.local/share/mime/packages
update-mime-database /storage/.local/share/mime

# Set common paths
CEMU_CACHE_LOG=/storage/.config/Cemu/share/log.txt
CEMU_VAR_LOG=/var/log/Cemu.log
CEMU_HOME_CONFIG=/storage/.config/Cemu/share
CEMU_HOME_LOCAL=/storage/.local/share/Cemu

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
if [ ! -f "/storage/.config/Cemu/settings.xml" ]
then
  cp -f /usr/config/Cemu/settings.xml /storage/.config/Cemu/settings.xml
fi

sed -i "s#<fullscreen>.*</fullscreen>#<fullscreen>true</fullscreen>#g" .config/Cemu/settings.xml
sed -i "s#<TVDevice>.*</TVDevice>#<TVDevice>$(pactl get-default-sink)</TVDevice>#g" .config/Cemu/settings.xml

# Run the emulator
cemu -f -g "$@"
rr_audio.sh alsa
