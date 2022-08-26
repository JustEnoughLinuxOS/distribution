#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Fewtarius (https://github.com/fewtarius)

. /etc/profile

case $1 in
  pre)

    if [ "${DEVICE_FAKE_JACKSENSE}" == "true" ]
    then
      nohup systemctl stop headphones &
    fi

    if [ "${DEVICE_VOLUMECTL}" == "true" ]
    then
      nohup systemctl stop volume &
    fi

    # RG351x devices are notorious for losing USB when they sleep.
    if [[ "${HW_DEVICE}" =~ RG351 ]]
    then
      nohup modprobe -r dwc2 &
    fi

    alsactl store -f /storage/.config/asound.state

    touch /run/.last_sleep_time

  ;;
  post)
    alsactl restore -f /storage/.config/asound.state

    if [[ "${HW_DEVICE}" =~ RG351 ]]
    then
      nohup modprobe -i dwc2 &
    fi

    if [ "${DEVICE_FAKE_JACKSENSE}" == "true" ]
    then
      nohup systemctl start headphones &
    fi

    if [ "${DEVICE_VOLUMECTL}" == "true" ]
    then
      nohup systemctl start volume &
    fi

    DEVICE_VOLUME=$(get_setting "audio.volume" 2>/dev/null)
    amixer set "${DEVICE_AUDIO_MIXER}" ${DEVICE_VOLUME}% 2>&1 >/dev/null

    ### Call the brightness script to set to the last saved value.
    /usr/lib/autostart/common/006-brightness
  ;;
esac
