#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Fewtarius (https://github.com/fewtarius)

. /etc/profile

case $1 in
  ac)
    if [ "$(get_setting gpu.powersave)" = 1 ]
    then
       echo auto > /sys/class/drm/card0/device/power_dpm_force_performance_level 2>/dev/null
       echo performance > /sys/class/drm/card0/device/power_dpm_state
       echo default >/sys/module/pcie_aspm/parameters/policy
       ryzenadj --max-performance
    fi
  ;;
  battery)
    if [ "$(get_setting gpu.powersave)" = 1 ]
    then
       echo battery > /sys/class/drm/card0/device/power_dpm_force_performance_level 2>/dev/null
       echo low > /sys/class/drm/card0/device/power_dpm_state
       echo powersupersave >/sys/module/pcie_aspm/parameters/policy
       ryzenadj --power-saving
    fi
  ;;
esac
