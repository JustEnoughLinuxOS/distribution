#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Fewtarius (https://github.com/fewtarius)

###
### Normally this would be a udev rule, but some devices like the AyaNeo Air
### do not properly report the applied power state to udev, and we can't use
### inotifyd to watch the status in /sys.
###

. /etc/profile

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
          if [ -e "/tmp/.gpuperf" ]
          then
            GPUMODE=$(cat /tmp/.gpuperf)
          else
            GPUMODE=$(get_setting system.gpuperf)
            if [ -z "${GPUMODE}" ]
            then
              GPUMODE=auto
              set_setting system.gpuperf auto
            fi
          fi
          led_mgr
          audio_powersave 1
          cpu_perftune battery
          gpu_performance_level ${GPUMODE}
          gpu_power_profile 1
          pcie_aspm_policy powersave
          device_powersave 1
        ;;
        *)
          log $0 "Switching to performance mode."
          led_mgr
          audio_powersave 0
          cpu_perftune performance
          gpu_performance_level profile_standard
          gpu_power_profile 1
          pcie_aspm_policy default
          device_powersave 0
        ;;
      esac
    fi
    CURRENT_MODE="${STATUS}"
  fi
  sleep 2
done
