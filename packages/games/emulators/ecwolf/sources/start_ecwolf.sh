#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC/351ELEC)

. /etc/profile
. /etc/os-release

EE_DEVICE=${HW_DEVICE}
RUN_DIR="/storage/roms/ecwolf"
CONFIG_DIR="/storage/.config/game/ecwolf"
CONFIG_FILE="${CONFIG_DIR}/ecwolf.cfg"
PK3_FILE="${CONFIG_DIR}/ecwolf.pk3"
SAVE_DIR="/storage/roms/gamedata/ecwolf"
LEGACY=true

if [ ! -L "/storage/.config/ecwolf" ]; then
  ln -sf "/storage/.config/game/ecwolf" "/storage/.config/ecwolf"
fi

if [ ! -f "/storage/.config/game/ecwolf/ecwolf.cfg" ]; then
  cp -rf /usr/config/game/ecwolf/ecwolf.cfg /storage/.config/game/ecwolf/
fi

mkdir -p ${SAVE_DIR}

params=" --config ${CONFIG_FILE} --savedir ${SAVE_DIR}"

# data can be SD2 SD3 SOD WL6 or N3D and it's passed as the ROM
EXT=${1##*.}

# If its a mod (extension .ecwolf) read the file and parse the data
if [ ${EXT} == "ecwolf" ]; then
  dos2unix "${1}"

  # We don't want to break users that have .ecwolf files that predate the PATH
  # option, so we'll track that here so we can handle it by:
  # 1. Parsing PK3[_N] keys
  # 2. Ignoring MOD and PATH keys
  # 3. Running from the config dir
  if grep -q "^PATH=" "${1}"; then
    LEGACY=false
  fi

  while IFS== read -r key value; do
    if $LEGACY; then
      if [ "$key" == "PK3" ]; then
        params+=" --file $value"
      fi
      if [ "$key" == "PK3_1" ]; then
        params+=" --file $value"
      fi
      if [ "$key" == "PK3_2" ]; then
        params+=" --file $value"
      fi
      if [ "$key" == "PK3_3" ]; then
        params+=" --file $value"
      fi
      if [ "$key" == "PK3_4" ]; then
        params+=" --file $value"
      fi
    else
      if [ "$key" == "PATH" ]; then
        # Unquote path value
        temp="${value}"
        temp="${temp%\"}"
        temp="${temp#\"}"
        RUN_DIR+="/$temp"
      fi
      if [ "$key" == "MOD" ]; then
        params+=" --file $value"
      fi
    fi

    if [ "$key" == "DATA" ]; then
      params+=" --data $value"
    fi
  done <"${1}"
else
  params+=" --data ${EXT}"
fi

if $LEGACY; then
  cd "${CONFIG_DIR}"
else

  # There doesn't appear to be a way to tell the engine with command line
  # arguments where the ecwolf.pk3 is located -- it just looks in the current
  # working directory. To work around this, we'll bind the ecwolf.pk3 file that
  # ships with the distribution into the provided game path, if one isn't
  # already present.
  DST_PK3_FILE="${RUN_DIR}/ecwolf.pk3"

  if [ ! -e "$DST_PK3_FILE" ]; then
    do_cleanup() {
      umount "$DST_PK3_FILE" &>/dev/null
      rm "${DST_PK3_FILE}"
    }

    touch "$DST_PK3_FILE"
    mount -o ro,bind "$PK3_FILE" "$DST_PK3_FILE" >/dev/null 2>&1
    trap do_cleanup EXIT
  fi

  cd "${RUN_DIR}"
fi

echo ${params} | xargs /usr/bin/ecwolf >/var/log/ecwolf.log 2>&1
