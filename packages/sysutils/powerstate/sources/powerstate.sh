#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Fewtarius (https://github.com/fewtarius)

###
### Normally this would be a udev rule, but some devices like the AyaNeo Air
### do not properly report the applied power state to udev, and we can't use
### inotifyd to watch the status in /sys.
###

. /etc/profile

DEBUG=false

performance_level() {
  for card in /sys/class/drm/card*/device/power_dpm_force_performance_level
  do
    if [ -e "${card}" ]
    then
      echo ${1} >${card} 2>/dev/null
    fi
  done
}

power_dpm_state() {
  for card in /sys/class/drm/card*/device/power_dpm_state
  do
    if [ -e "${card}" ]
    then
      echo ${1} >${card} 2>/dev/null
    fi
  done
}

pcie_aspm_policy() {
  if [ -e "/sys/module/pcie_aspm/parameters/policy" ]
  then
    echo ${1} >/sys/module/pcie_aspm/parameters/policy 2>/dev/null
  fi
}

perftune() {
  CPU="$(awk '/vendor_id/ {print $3;exit}' /proc/cpuinfo)"
  if [ "${CPU}" = "AuthenticAMD" ]
  then
    if [ "${1}" = "battery" ]
    then
      ryzenadj --power-saving >/dev/null 2>&1
    else
      ryzenadj --max-performance >/dev/null 2>&1
    fi
  elif [ "${CPU}" = "GenuineIntel" ]
  then
    for policy in $(find /sys/devices/system/cpu/cpufreq/policy*/ -name energy_performance_preference)
    do
      if [ "${1}" = "battery" ]
      then
        echo power >${policy} >/dev/null 2>&1
      else
        echo performance >${policy} >/dev/null 2>&1
      fi
    done
  fi
}

audio_powersave() {
  if [ -e "/sys/module/snd_hda_intel/parameters/power_save" ]
  then
    echo ${1} >/sys/module/snd_hda_intel/parameters/power_save 2>/dev/null
  fi
}

device_powersave() {
  case ${1} in
    1)
      PSMODE=auto
    ;;
    *)
      PSMODE=on
    ;;
  esac
  find /sys/devices -name control -print0 | \
  while read -r -d '' DEVICE
  do
    echo ${PSMODE} >"${DEVICE}" 2>/dev/null
  done
}

while true
do
  STATUS="$(cat /sys/class/power_supply/{BAT*,bat*}/status 2>/dev/null)"
  ${DEBUG} && echo "Status: ${STATUS}"
  if [ ! "${STATUS}" = "${CURRENT_MODE}" ]
  then
    ${DEBUG} && echo "Status changed."
    case ${STATUS} in
      Disch*)
        /usr/bin/logger -t user.notice "Switching to battery mode."
        if [ "$(get_setting system.powersave)" = 1 ]
        then
          audio_powersave 1
          perftune battery
          performance_level auto
          power_dpm_state battery
          pcie_aspm_policy powersave
          device_powersave 1
        fi
      ;;
      *)
        /usr/bin/logger -t user.notice "Switching to performance mode."
        if [ "$(get_setting system.powersave)" = 1 ]
        then
          audio_powersave 0
          perftune performance
          performance_level profile_peak
          power_dpm_state performance
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
