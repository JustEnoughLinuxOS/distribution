#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 0riginally created by Escalade (https://github.com/escalade)
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

. /etc/profile

jslisten set "-9 amiberry"

# Set some common variables
AMIBERRY_DIR="/storage/.config/amiberry"
AMIBERRY_CONFIG_DIR="${AMIBERRY_DIR}/conf"
AMIBERRY_TMP_DIR="/tmp/emulation/amiberry"
AMIBERRY_TMP_CONFIG="${AMIBERRY_TMP_DIR}/.amiberry_conf.uae"
AMIBERRY_LOG="/var/log/amiberry.log"
BIOS_PATH="/storage/roms/bios"
MAX_DRIVES=4
i=0

echo "Amiberry Log" > "${AMIBERRY_LOG}"

if [ ! -d "${AMIBERRY_TMP_DIR}" ]
then
  mkdir -p "${AMIBERRY_TMP_DIR}"
fi

if [ ! -d "${AMIBERRY_DIR}" ]
then
  cp -rf /usr/config/amiberry ${AMIBERRY_DIR}
fi

### Refresh the configs so we can manage them.
cp -f /usr/config/amiberry/conf/* ${AMIBERRY_DIR}/conf

find_gamepad() {
  GAMEPAD=$(grep -b4 js0 /proc/bus/input/devices | awk 'BEGIN {FS="\""}; /Name/ {printf $2}')
  sed -i "s|joyport1_friendlyname=.*|joyport1_friendlyname=${GAMEPAD}|" "${AMIBERRY_TMP_CONFIG}"
  echo "Gamepad used ${GAMEPAD}" >> "${AMIBERRY_LOG}"
}

# Which file should amiberry load?
echo "Trying to boot this game:" "$1" >> ${AMIBERRY_LOG}

# Change working directory cause amiberry loads assets from there
cd ${AMIBERRY_DIR}

# Create a clean working directory
if [ -d "${AMIBERRY_TMP_DIR}" ]; then
  echo "Clean up old working directory." >> ${AMIBERRY_LOG}
  rm -rf "${AMIBERRY_TMP_DIR}"
fi
mkdir -p "${AMIBERRY_TMP_DIR}"

# Check if the file is an Amiga 1200/CD32 game and set configuration options for an Amiga 1200
AMIBERRY_SET_CONF() {
  if [ `echo $1 | grep -E 'AGA|CD32' | wc -l` -eq 1 -o `echo "${AMIBERRY_TMP_DIR}"/* | grep -e 'AGA|CD32' | wc -l` -eq 1 ]; then
    echo "Loading Amiga 1200/CD32 config." >> ${AMIBERRY_LOG}
    cp ${AMIBERRY_CONFIG_DIR}/AmigaA1200-default.uae "${AMIBERRY_TMP_CONFIG}"
  else
    echo "Loading Amiga 500 config." >> ${AMIBERRY_LOG}
    cp ${AMIBERRY_CONFIG_DIR}/AmigaA500-default.uae "${AMIBERRY_TMP_CONFIG}"
  fi
  sed -i "s#@BIOS_PATH@#${BIOS_PATH}#g" ${AMIBERRY_TMP_CONFIG}
  sed -i "s#gfx_width=.*\$#$(fbwidth)#g" ${AMIBERRY_TMP_CONFIG}
  sed -i "s#gfx_height=.*\$#$(fbheight)#g" ${AMIBERRY_TMP_CONFIG}
  find_gamepad 
}

# Check if we are loading a .zip file
if [ `echo $1 | grep -i .zip | wc -l` -eq 1 ]; then
  
  # Unpack the zip file
  unzip -q -o "$1" -d "${AMIBERRY_TMP_DIR}"
  
  if [ -f "${AMIBERRY_TMP_DIR}"/*.*nfo ] && [ -f "${AMIBERRY_TMP_DIR}"/*/*.*lave ]; then

    # WHDLoad file detected
    echo "Loading a WHDLoad (.zip) file..." >> ${AMIBERRY_LOG}

    # Set default config
    AMIBERRY_SET_CONF "$1"

    # Add amiberry.uae conf & start amiberry with WHDLoad
    amiberry -f "${AMIBERRY_TMP_CONFIG}" --autoload "$1" >> ${AMIBERRY_LOG} 2>&1

  else
    # .zip file detected
    echo "Loading a .zip file..." >> ${AMIBERRY_LOG}

    # Set default config
    AMIBERRY_SET_CONF "$1"
  
    # Assign files to floppy0-3
    for FILE in "${AMIBERRY_TMP_DIR}"/*
    do
      ARGS="${ARGS}\nfloppy$i="${FILE}""
      i=$(($i+1))
      # This emulator supports 4 floppies max
      if [ $i -eq ${MAX_DRIVES} ]; then
        break;
      fi
    done
  
    # Add game files as floppies 0-3 to amiberry.uae & start amiberry
    echo -e ";" >> "${AMIBERRY_TMP_CONFIG}"
    echo -e "; *** temporary added Floppy Drives" >> "${AMIBERRY_TMP_CONFIG}"
    echo -e ";" >> "${AMIBERRY_TMP_CONFIG}"
    echo -e ${ARGS} >> "${AMIBERRY_TMP_CONFIG}"
    echo -e "\nAssigned floppy drives:" ${ARGS} "\n" >> "${AMIBERRY_LOG}"
    amiberry -f "${AMIBERRY_TMP_CONFIG}" >> ${AMIBERRY_LOG} 2>&1
  fi

# Check for WHDload files (.lha)
elif [ `echo $1 | grep -i .lha | wc -l` -eq 1 ]; then
    
  #.lha file detected
  echo "Loading a WHDLoad (.lha) file..." >> ${AMIBERRY_LOG}

  # Set default config
  AMIBERRY_SET_CONF "$1"

  # Add amiberry.uae conf & start amiberry with WHDLoad
  amiberry -f "${AMIBERRY_TMP_CONFIG}" --autoload "$1" >> ${AMIBERRY_LOG} 2>&1

# Check for .uae config file
elif [ `echo $1 | grep -i .uae | wc -l` -eq 1 ]; then

  # .uae file detected
  echo "Loading an .uae file..." >> ${AMIBERRY_LOG}

  # Load .uae config file
  amiberry -f "$1" >> ${AMIBERRY_LOG} 2>&1

# All other files (.adf .adz .ipf)
else

  #.adf or .adz or .ipf file detected
  echo "Loading a single .adf or .adz or .ipf file..." >> ${AMIBERRY_LOG}

  # Set default config
  AMIBERRY_SET_CONF "$1"

  # Add game file as floppy0 to amiberry.uae & start amiberry
  echo -e ";" >> "${AMIBERRY_TMP_CONFIG}"
  echo -e "; *** temporary added Floppy Drives" >> "${AMIBERRY_TMP_CONFIG}"
  echo -e ";" >> "${AMIBERRY_TMP_CONFIG}"
  echo -e "\nfloppy0=$1" >> "${AMIBERRY_TMP_CONFIG}"
  echo -e "\nAssigned floppy drive:\nfloppy0=$1\n" >> "${AMIBERRY_LOG}"
  amiberry -f "${AMIBERRY_TMP_CONFIG}" >> ${AMIBERRY_LOG} 2>&1
fi

# Remove temporary dir
rm -rf "${AMIBERRY_TMP_DIR}"
