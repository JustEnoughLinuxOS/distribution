#!/bin/bash
. /etc/profile

case $1 in
  pre)
    # Store system brightness
    cat /sys/class/backlight/backlight/brightness > /storage/.brightness
    # Store sound state. Try to avoid having max volume after resume
    alsactl store -f /tmp/asound.state
    systemctl stop headphones

    # RG351x devices are notorious for losing USB when they sleep.
    if [[ "${HW_DEVICE}" =~ RG351 ]]
    then
      modprobe -r dwc2
    fi

    # stop hotkey service
    systemctl stop odroidgoa-headphones.service
 
    # This file is used by ES to determine if we just woke up from sleep
    touch /run/.last_sleep_time

  ;;
  post)
    # Restore pre-sleep sound state
    alsactl restore -f /tmp/asound.state
    VOL=$(get_setting "audio.volume" 2>/dev/null)
    MIXER="Master"
    amixer set "${MIXER}" ${VOL}% 2>&1 >/dev/null
    # Restore system brightness
    cat /storage/.brightness > /sys/class/backlight/backlight/brightness
    # re-detect and reapply sound, brightness and hp state
    systemctl start headphones

    if [[ "${HW_DEVICE}" =~ RG351 ]]
    then
      modprobe -i dwc2
      systemctl restart volume
    fi

  ;;
esac
