#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-2021 Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

if [ -z "${1}" ]
then
  [ -z "$SYSTEM_ROOT" ] && SYSTEM_ROOT=""
  [ -z "$BOOT_ROOT" ] && BOOT_ROOT="/flash"
  [ -z "$BOOT_PART" ] && BOOT_PART=$(df "$BOOT_ROOT" | tail -1 | awk {' print $1 '})
  if [ -z "$BOOT_DISK" ]; then
    case $BOOT_PART in
      /dev/sd[a-z][0-9]*)
        BOOT_DISK=$(echo $BOOT_PART | sed -e "s,[0-9]*,,g")
        ;;
      /dev/mmcblk*)
        BOOT_DISK=$(echo $BOOT_PART | sed -e "s,p[0-9]*,,g")
        ;;
    esac
  fi

  # mount $BOOT_ROOT r/w
    mount -o remount,rw $BOOT_ROOT


  for arg in $(cat /proc/cmdline); do
    case $arg in
      boot=*)
        boot="${arg#*=}"
        case $boot in
          /dev/mmc*)
            UUID_SYSTEM="$(blkid $boot | sed 's/.* UUID="//;s/".*//g')"
            ;;
          UUID=*|LABEL=*)
            UUID_SYSTEM="$(blkid | sed 's/"//g' | grep -m 1 -i " $boot " | sed 's/.* UUID=//;s/ .*//g')"
            ;;
          FOLDER=*)
            UUID_SYSTEM="$(blkid ${boot#*=} | sed 's/.* UUID="//;s/".*//g')"
            ;;
        esac
      ;;
      disk=*)
        disk="${arg#*=}"
        case $disk in
          /dev/mmc*)
            UUID_STORAGE="$(blkid $disk | sed 's/.* UUID="//;s/".*//g')"
            ;;
          UUID=*|LABEL=*)
            UUID_STORAGE="$(blkid | sed 's/"//g' | grep -m 1 -i " $disk " | sed 's/.* UUID=//;s/ .*//g')"
            ;;
          FOLDER=*)
            UUID_STORAGE="$(blkid ${disk#*=} | sed 's/.* UUID="//;s/".*//g')"
            ;;
        esac
      ;;
    esac
  done
else
  BOOT_DISK="${1}"
  BOOT_ROOT="${2}"
  UUID_SYSTEM="${3}"
  UUID_STORAGE="${4}"
fi

DT_ID=$($SYSTEM_ROOT/usr/bin/dtname)

if [ -n "$DT_ID" ]; then
  case $DT_ID in
    *odroid-go-ultra*|*rgb10-max-3*)
      SUBDEVICE="Odroid_GOU"
      ;;
    *odroid-n2|*odroid-n2-plus)
      SUBDEVICE="Odroid_N2"
      ;;
    *odroid-n2l)
      SUBDEVICE="Odroid_N2L"
      ;;
  esac
fi

for all_dtb in $BOOT_ROOT/*.dtb; do
  dtb=$(basename $all_dtb)
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/$dtb ]; then
    echo "Updating $dtb..."
    cp -p $SYSTEM_ROOT/usr/share/bootloader/$dtb $BOOT_ROOT
  fi
done

if [ -f $BOOT_ROOT/extlinux/extlinux.conf ] || [ -n "${1}" ]; then
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/extlinux/extlinux.conf ]; then
    echo "Updating extlinux.conf..."
    if [ ! -d "${BOOT_ROOT}/extlinux" ]
    then
      mkdir "${BOOT_ROOT}/extlinux"
    fi
    cp -p $SYSTEM_ROOT/usr/share/bootloader/extlinux/extlinux.conf $BOOT_ROOT/extlinux
    sed -e "s/@UUID_SYSTEM@/$UUID_SYSTEM/" \
        -e "s/@UUID_STORAGE@/$UUID_STORAGE/" \
        -i $BOOT_ROOT/extlinux/extlinux.conf
  fi
fi

if [ -f $BOOT_ROOT/boot.ini ] || [ -n "${1}" ]; then
  if [ -f /usr/share/bootloader/boot.ini ]; then
    echo "Updating boot.ini"
    cp -p /usr/share/bootloader/boot.ini $BOOT_ROOT/boot.ini
    sed -e "s/@UUID_SYSTEM@/$UUID_SYSTEM/" \
        -e "s/@UUID_STORAGE@/$UUID_STORAGE/" \
        -i $BOOT_ROOT/boot.ini
  fi
fi

if [ -f $SYSTEM_ROOT/usr/share/bootloader/${SUBDEVICE}_u-boot ]; then
  echo "Updating u-boot on: $BOOT_DISK..."
  dd if=$SYSTEM_ROOT/usr/share/bootloader/${SUBDEVICE}_u-boot of=$BOOT_DISK conv=fsync,notrunc bs=512 seek=1 &>/dev/null
fi

if [ -f $BOOT_ROOT/ODROIDBIOS.BIN ]; then
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/ODROIDBIOS.BIN ]; then
    echo "Updating ODROIDBIOS.BIN..."
    cp -p $SYSTEM_ROOT/usr/share/bootloader/ODROIDBIOS.BIN $BOOT_ROOT
  fi
fi

if [ -d $BOOT_ROOT/res ]; then
  if [ -d $SYSTEM_ROOT/usr/share/bootloader/res ]; then
    echo "Updating res..."
    cp -rp $SYSTEM_ROOT/usr/share/bootloader/res $BOOT_ROOT
  fi
fi

mount -o ro,remount $BOOT_ROOT

echo "UPDATE" > /storage/.boot.hint
