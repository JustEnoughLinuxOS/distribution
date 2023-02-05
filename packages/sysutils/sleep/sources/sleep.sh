#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Fewtarius (https://github.com/fewtarius)

. /etc/profile

headphones() {
  if [ "${DEVICE_FAKE_JACKSENSE}" == "true" ]
  then
    log $0 "Headphone sense: ${1}"
    systemctl ${1} headphones >/dev/null 2>&1
  fi
}

volumectl() {
  if [ "${DEVICE_VOLUMECTL}" == "true" ]
  then
    log $0 "Volume control: ${1}"
    systemctl ${1} volume >/dev/null 2>&1
  fi
}

alsastate() {
  alsactl ${1} -f /storage/.config/asound.state >/dev/null 2>&1
}

powerstate() {
  if [ "$(get_setting system.powersave)" = 1 ]
  then
    systemctl ${1} powerstate >/dev/null 2>&1
  fi
}

bluetooth() {
  if [ "$(get_setting bluetooth.enabled)" == "1" ]
  then
    log $0 "Bluetooth: ${1}"
    systemctl ${1} bluetooth >/dev/null 2>&1
  fi
}

modules() {
  log $0 "Modules: ${1}"
  case ${1} in
    stop)
      if [ -e "/usr/config/modules.bad" ]
      then
        for module in $(cat /usr/config/modules.bad)
        do
          EXISTS=$(lsmod | grep ${module})
          if [ $? = 0 ]
          then
            echo ${module} >>/tmp/modules.load
            modprobe -r ${module}
          fi
        done
      fi
    ;;
    start)
      if [ -e "/tmp/modules.load" ]
      then
        for module in $(cat /tmp/modules.load)
        do
          MODCNT=0
          MODATTEMPTS=10
          while true
          do
            if (( "${MODCNT}" < "${MODATTEMPTS}" ))
            then
              modprobe ${module%% *}
              if [ $? = 0 ]
              then
                break
              fi
            else
              break
            fi
            MODCNT=$((${MODCNT} + 1))
            sleep .5
          done
        done
        rm -f /tmp/modules.load
      fi
    ;;
  esac
}

case $1 in
  pre)
    alsastate store
    headphones stop
    volumectl stop
    bluetooth stop
    powerstate stop
    device_powersave stop 
    modules stop 
    touch /run/.last_sleep_time
  ;;
  post)
    led_mgr
    alsastate restore
    modules start
    powerstate start
    headphones start
    volumectl start
    bluetooth start

    if [ "$(get_setting wifi.enabled)" == "1" ]
    then
      log $0 "Connecting WIFI."
      nohup wifictl enable >/dev/null 2>&1
    fi

    DEVICE_VOLUME=$(get_setting "audio.volume" 2>/dev/null)
    log $0 "Restoring volume to ${DEVICE_VOLUME}%."
    amixer -M set "${DEVICE_AUDIO_MIXER}" ${DEVICE_VOLUME}%

    BRIGHTNESS=$(get_setting system.brightness)
    log $0 "Restoring brightness to ${BRIGHTNESS}."
    echo ${BRIGHTNESS} >/sys/class/backlight/$(brightness device)/brightness
  ;;
esac
