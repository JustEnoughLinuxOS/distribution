#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

# Source predefined functions and variables
. /etc/profile

export SDL_AUDIODRIVER=pulseaudio

TZ=$(get_setting system.timezone)
echo -n "TIMEZONE=${TZ}" > /storage/.cache/timezone
echo -n "${TZ}" >/storage/.cache/system_timezone
systemctl restart tz-data.service

MYLOCALE=$(get_setting system.language)
if [[ -n "${MYLOCALE}" ]]
then

  unset I18NPATH LANG LANGUAGE LOCPATH

  MYCHARMAP="UTF-8"
  MYLANG="${MYLOCALE}.${MYCHARMAP}"
  MYLOCPATH="/storage/.config/emulationstation"

  if [ ! -e "${MYLOCPATH}/locale/${MYLANG}/LC_NAME" ]; then
    performance
 I18NPATH="/usr/share/i18n"
 localedef -i ${MYLOCALE} \
           -c \
           -v \
           -f ${MYCHARMAP} \
           ${MYLOCPATH}/locale/${MYLANG} >/var/log/start_es.log 2>&1
    ${DEVICE_CPU_GOVERNOR}
  fi

  export LOCPATH="${MYLOCPATH}/locale"
  export LANG=${MYLANG}
  export LANGUAGE=${MYLANG}
  systemctl import-environment LANG
  systemctl import-environment LOCPATH
  systemctl import-environment I18NPATH
  systemctl import-environment LANGUAGE
fi

jslisten set "emulationstation"

emulationstation --log-path /var/log --no-splash
