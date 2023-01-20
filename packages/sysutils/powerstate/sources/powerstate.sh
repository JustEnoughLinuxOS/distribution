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
  STATUS="$(cat /sys/class/power_supply/{BAT*,bat*}/status 2>/dev/null)"
  ${DEBUG} && echo "Status: ${STATUS}"
  if [ ! "${STATUS}" = "${CURRENT_MODE}" ]
  then
    ${DEBUG} && echo "Status changed."
    case ${STATUS} in
      Disch*)
        log $0 "Switching to battery mode."
        if [ "$(get_setting system.powersave)" = 1 ]
        then
          audio_powersave 1
          cpu_perftune battery
          gpu_performance_level auto
          gpu_power_profile 1
          pcie_aspm_policy powersave
          device_powersave 1
        fi
      ;;
      *)
        log $0 "Switching to performance mode."
        if [ "$(get_setting system.powersave)" = 1 ]
        then
          audio_powersave 0
          cpu_perftune performance
          gpu_performance_level profile_standard
          gpu_power_profile 1
          pcie_aspm_policy default
          device_powersave 0
        fi
      ;;
    esac
  fi
  CURRENT_MODE="${STATUS}"
  ${DEBUG} && echo "Current Mode: ${CURRENT_MODE}"
  sleep 2
done
