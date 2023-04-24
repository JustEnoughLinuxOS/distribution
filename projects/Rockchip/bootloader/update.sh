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
fi

# update device tree
for all_dtb in $SYSTEM_ROOT/usr/share/bootloader/*.dtb; do
  dtb=$(basename $all_dtb)
    echo -n "Updating $dtb... "
    cp -p $SYSTEM_ROOT/usr/share/bootloader/$dtb $BOOT_ROOT &>/dev/null
    echo "done"
done

echo "UPDATE" > /storage/.config/boot.hint

# update bootloader

if [ -f $SYSTEM_ROOT/usr/share/bootloader/idbloader.img ]; then
  echo -n "Updating idbloader.img... "
  dd if=$SYSTEM_ROOT/usr/share/bootloader/idbloader.img of=$BOOT_DISK bs=512 seek=64 conv=fsync &>/dev/null
  echo "done"
fi
if [ -f $SYSTEM_ROOT/usr/share/bootloader/u-boot.img ]; then
  echo -n "Updating uboot.img... "
  dd if=$SYSTEM_ROOT/usr/share/bootloader/u-boot.img of=$BOOT_DISK bs=512 seek=16384 conv=fsync &>/dev/null
  echo "done"
fi
if [ -f $SYSTEM_ROOT/usr/share/bootloader/u-boot.itb ]; then
  echo -n "Updating uboot.itb... "
  dd if=$SYSTEM_ROOT/usr/share/bootloader/u-boot.itb of=$BOOT_DISK bs=512 seek=16384 conv=fsync &>/dev/null
  echo "done"
fi
if [ -f $SYSTEM_ROOT/usr/share/bootloader/trust.img ]; then
  echo -n "Updating trust.img... "
  dd if=$SYSTEM_ROOT/usr/share/bootloader/trust.img of=$BOOT_DISK bs=512 seek=24576 conv=fsync &>/dev/null
  echo "done"
elif [ -f $SYSTEM_ROOT/usr/share/bootloader/resource.img ]; then
  echo -n "Updating resource.img... "
  dd if=$SYSTEM_ROOT/usr/share/bootloader/resource.img of=$BOOT_DISK bs=512 seek=24576 conv=fsync &>/dev/null
  echo "done"
fi

if [ -f $SYSTEM_ROOT/usr/share/bootloader/logo.bmp ]; then
  echo -n "Updating uboot logo... "
  cp -p $SYSTEM_ROOT/usr/share/bootloader/logo.bmp $BOOT_ROOT &>/dev/null
  echo "done"
fi

# mount $BOOT_ROOT r/o
  sync
  mount -o remount,ro $BOOT_ROOT &>/dev/null

sync
