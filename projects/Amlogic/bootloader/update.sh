#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-2021 Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2021-present Fewtarius

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
          BOOT_UUID="$(blkid $boot | sed 's/.* UUID="//;s/".*//g')"
          ;;
        UUID=*|LABEL=*)
          BOOT_UUID="$(blkid | sed 's/"//g' | grep -m 1 -i " $boot " | sed 's/.* UUID=//;s/ .*//g')"
          ;;
        FOLDER=*)
          BOOT_UUID="$(blkid ${boot#*=} | sed 's/.* UUID="//;s/".*//g')"
          ;;
      esac
    ;;
    disk=*)
      disk="${arg#*=}"
      case $disk in
        /dev/mmc*)
          DISK_UUID="$(blkid $disk | sed 's/.* UUID="//;s/".*//g')"
          ;;
        UUID=*|LABEL=*)
          DISK_UUID="$(blkid | sed 's/"//g' | grep -m 1 -i " $disk " | sed 's/.* UUID=//;s/ .*//g')"
          ;;
        FOLDER=*)
          DISK_UUID="$(blkid ${disk#*=} | sed 's/.* UUID="//;s/".*//g')"
          ;;
      esac
    ;;
  esac
done

CONFS=$SYSTEM_ROOT/usr/share/bootloader/extlinux/*.conf

for all_conf in $CONFS; do
  conf="$(basename ${all_conf})"
  echo "Updating ${conf}..."
  cp -p $SYSTEM_ROOT/usr/share/bootloader/extlinux/${conf} $BOOT_ROOT/extlinux/${conf} &>/dev/null
  sed -e "s/@BOOT_UUID@/$BOOT_UUID/" \
      -e "s/@DISK_UUID@/$DISK_UUID/" \
      -i $BOOT_ROOT/extlinux/${conf}
done

if [ -f $SYSTEM_ROOT/usr/share/bootloader/boot.ini ]; then
  echo "Updating boot.ini..."
  cp -p $SYSTEM_ROOT/usr/share/bootloader/boot.ini $BOOT_ROOT/boot.ini &>/dev/null
    sed -e "s/@BOOT_UUID@/$BOOT_UUID/" \
      -e "s/@DISK_UUID@/$DISK_UUID/" \
      -i $BOOT_ROOT/boot.ini
fi

if [ -f $SYSTEM_ROOT/usr/share/bootloader/ODROIDBIOS.BIN ]; then
  echo "Updating odroidbios.bin..."
  cp -p $SYSTEM_ROOT/usr/share/bootloader/ODROIDBIOS.BIN $BOOT_ROOT/ODROIDBIOS.BIN &>/dev/null
fi

if [ -d $SYSTEM_ROOT/usr/share/bootloader/res ]; then
  echo "Updating res..."
  cp -rp $SYSTEM_ROOT/usr/share/bootloader/res $BOOT_ROOT/ &>/dev/null
fi

# update device tree
for all_dtb in $SYSTEM_ROOT/usr/share/bootloader/*.dtb; do
  dtb="$(basename ${all_dtb})"
    echo -n "Updating $dtb... "
    cp -p $SYSTEM_ROOT/usr/share/bootloader/$dtb $BOOT_ROOT &>/dev/null
    echo "done"
done


echo "UPDATE" > /storage/.boot.hint

# update bootloader

if [ -f $SYSTEM_ROOT/usr/share/bootloader/u-boot.bin ]; then
  echo -n "Updating uboot.bin... "
  dd if=$SYSTEM_ROOT/usr/share/bootloader/u-boot.bin of=$BOOT_DISK conv=fsync,notrunc bs=512 seek=1 &>/dev/null
  echo "done"
fi

# mount $BOOT_ROOT r/o
  sync
  mount -o remount,ro $BOOT_ROOT &>/dev/null

sync
