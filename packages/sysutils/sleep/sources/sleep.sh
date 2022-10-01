#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Fewtarius (https://github.com/fewtarius)

. /etc/profile

case $1 in
  pre)

    if [ "${DEVICE_FAKE_JACKSENSE}" == "true" ]
    then
      nohup systemctl stop headphones & >/dev/null 2>&1
    fi

    if [ "${DEVICE_VOLUMECTL}" == "true" ]
    then
      nohup systemctl stop volume & >/dev/null 2>&1
    fi

    # RG351x devices are notorious for losing USB when they sleep.
    if [[ "${HW_DEVICE}" =~ RG351 ]]
    then
      modprobe -r dwc2
    fi

    nohup alsactl store -f /storage/.config/asound.state >/dev/null 2>&1

    wait
    touch /run/.last_sleep_time

  ;;
  post)
    alsactl restore -f /storage/.config/asound.state

    if [[ "${HW_DEVICE}" =~ RG351 ]]
    then
      modprobe -i dwc2
    fi

    if [ "${DEVICE_FAKE_JACKSENSE}" == "true" ]
    then
      nohup systemctl start headphones & >/dev/null 2>&1
    fi

    if [ "${DEVICE_VOLUMECTL}" == "true" ]
    then
      nohup systemctl start volume & >/dev/null 2>&1
    fi

    if [ "$(get_setting wifi.enabled)" == "1" ]
     then
       nohup wifictl reconnect & >/dev/null 2>&1
     fi

    DEVICE_VOLUME=$(get_setting "audio.volume" 2>/dev/null)
    nohup amixer -M set "${DEVICE_AUDIO_MIXER}" ${DEVICE_VOLUME}% & >/dev/null 2>&1

    BRIGHTNESS_DEV="$(ls /sys/class/backlight | head -n 1)"
    BRIGHTNESS=$(get_setting system.brightness)
    echo ${BRIGHTNESS} >/sys/class/backlight/${BRIGHTNESS_DEV}/brightness

    wait
  ;;
esac
