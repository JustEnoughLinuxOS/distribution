#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023-present - The JELOS Project (https://github.com/JustEnoughLinuxOS) (https://github.com/fewtarius)

###
### Normally this would be a udev rule, but some devices like the AyaNeo Air
### do not properly report the applied power state to udev, and we can't use
### inotifyd to watch the status in /sys.
###

. /etc/profile

BATCNT=0
while true
do
  if [ "$(get_setting system.powersave)" = 1 ]
  then
    STATUS="$(cat /sys/class/power_supply/{BAT*,bat*}/status 2>/dev/null)"
    if [ ! "${STATUS}" = "${CURRENT_MODE}" ]
    then
      case ${STATUS} in
        Disch*)
          log $0 "Switching to battery mode."
          if [ -e "/tmp/.gpu_performance_level" ]
          then
            GPUPROFILE=$(cat /tmp/.gpu_performance_level)
          else
            GPUPROFILE=$(get_setting system.gpuperf)
          fi
          if [ -z "${GPUPROFILE}" ]
          then
            GPUPROFILE="auto"
          fi
          ledcontrol $(get_setting led.color)
          audio_powersave 1
          cpu_perftune battery
          gpu_performance_level ${GPUPROFILE}
          pcie_aspm_policy powersave
          wake_events enabled
          runtime_power_management auto 5
          scsi_link_power_management med_power_with_dipm
          /usr/bin/wifictl setpowersave

        ;;
        *)
          log $0 "Switching to performance mode."
          ledcontrol $(get_setting led.color)
          audio_powersave 0
          cpu_perftune performance
          gpu_performance_level auto
          pcie_aspm_policy default
          wake_events disabled
          runtime_power_management on 0
          scsi_link_power_management ""
          /usr/bin/wifictl setpowersave
        ;;
      esac
    fi
    CURRENT_MODE="${STATUS}"
  fi
  ### Until we have an overlay. :rofl:
  if (( "${BATCNT}" >= "90" )) &&
     [[ "${STATUS}" =~ Disch ]]
  then
    BATLEFT=$(battery_percent)
    AUDIBLEALERT=$(get_setting system.battery.warning)
    if (( "${BATLEFT}" < "25" ))
    then
      if [ "${DEVICE_LED_CONTROL}" = "true" ]
      then
        led_flash red
        BATCNT=0
      elif [ "${AUDIBLEALERT}" = "1" ]
      then
        say "BATTERY AT ${BATLEFT}%"
        BATCNT=0
      fi
    fi
  fi
  BATCNT=$(( ${BATCNT} + 1 ))
  sleep 2
done
