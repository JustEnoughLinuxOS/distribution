#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present 5schatten (https://github.com/5schatten)

. /etc/profile

# Set some common variables
HATARI_DIR_HOME=/storage/.hatari
HATARI_DIR=/storage/.config/hatari
HATARI_CONFIG_DIR=$HATARI_DIR/conf
HATARI_TMP_DIR=/tmp/hatari
HATARI_TMP_CONFIG="$HATARI_TMP_DIR"/.hatari-temp.cfg
HATARI_LOG="/var/log/hatari.log"
MAX_DRIVES=2
i=0

# create symlink to hatari config dir
if [ ! -L $HATARI_DIR_HOME ]; then
  rm -rf $HATARI_DIR_HOME
  ln -s $HATARI_DIR $HATARI_DIR_HOME
fi

# Which file should hatari load?
echo "Trying to boot this game:" "$1" >> $HATARI_LOG

# Create a clean working directory
if [ -d "$HATARI_TMP_DIR" ]; then
  echo "Clean up old working directory." >> $HATARI_LOG
  rm -rf "$HATARI_TMP_DIR"
fi
mkdir -p "$HATARI_TMP_DIR"

# copy default config file to tmp
cp $HATARI_CONFIG_DIR/Atari-ST-default.cfg "$HATARI_TMP_CONFIG"

# Check if we are loading a .zip file
if [ `echo $1 | grep -i .zip | wc -l` -eq 1 ]; then

  #unpack the zip file
  unzip -q -o "$1" -d "$HATARI_TMP_DIR"

  # Assign files to floppy 1 & 2
  for FILE in "$HATARI_TMP_DIR"/*
  do
    i=$(($i+1))
    case "$i" in
    1)
      ARGS="\nszDiskAFileName = "$FILE""
      ;;
    2)
      ARGS="${ARGS}\nszDiskBFileName = "$FILE""
      ;;
    esac

    # This emulator supports 2 floppies max
    if [ $i -eq $MAX_DRIVES ]; then
      break;
    fi
  done

    # Add game files as floppy 1 & 2 to .hatari-temp.cfg & start hatari
    echo -e ${ARGS} >> "$HATARI_TMP_CONFIG"
    echo -e "\nAssigned floppy drives:" ${ARGS} "\n" >> "$HATARI_LOG"
    nice -n -19 hatarisa --configfile "$HATARI_TMP_CONFIG" >> $HATARI_LOG 2>&1

# Check for .cfg config file
elif [ `echo $1 | grep -i .cfg | wc -l` -eq 1 ]; then
  nice -n -19 hatarisa --configfile "$1" >> $HATARI_LOG 2>&1
# All other files
else
  nice -n -19 hatarisa --configfile "$HATARI_TMP_CONFIG" --disk-a "$1" >> $HATARI_LOG 2>&1
fi
# Remove temporary dir
rm -rf "$HATARI_TMP_DIR"
