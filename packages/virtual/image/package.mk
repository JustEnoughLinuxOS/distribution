# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="image"
PKG_LICENSE="GPL"
PKG_SITE="https://libreelec.tv"

PKG_SECTION="virtual"
PKG_LONGDESC="Root package used to build and create complete image"

PKG_DEPENDS_TARGET="toolchain squashfs-tools:host dosfstools:host fakeroot:host kmod:host \
                    mtools:host populatefs:host libc gcc linux linux-drivers linux-firmware \
                    ${BOOTLOADER} busybox util-linux corefonts misc-packages debug \
                    usb-modeswitch unzip poppler textviewer jq socat p7zip file bluez \
                    splash initramfs plymouth-lite grep wget util-linux patchelf imagemagick \
                    terminus-font bash coreutils alsa-ucm-conf modules system-utils \
                    autostart quirks powerstate powertop ectool gnupg gzip six xmlstarlet \
                    vim pyudev dialog git dbus-python network synctools pygobject libzip \
                    libao alsa-lib lzo zstd lz4 empty jelos"

PKG_UI="emulationstation es-themes"

PKG_UI_TOOLS="fileman fbgrab"

PKG_MULTIMEDIA="ffmpeg vlc mpv"

PKG_TOOLS="i2c-tools evtest jslisten"

if [ "${BASE_ONLY}" = "true" ]
then
  EMULATION_DEVICE=false
else
  PKG_DEPENDS_TARGET+=" ${PKG_TOOLS} ${PKG_UI} ${PKG_UI_TOOLS} ${PKG_MULTIMEDIA}"
fi

# Device is an emulation focused device
[ "${EMULATION_DEVICE}" = "yes" ] && PKG_DEPENDS_TARGET+=" emulators gamesupport"

# Add support for containers
[ "${CONTAINER_SUPPORT}" = "yes" ] && PKG_DEPENDS_TARGET+=" docker"

# 32Bit package support
[ "${ENABLE_32BIT}" == true ] && PKG_DEPENDS_TARGET+=" lib32"

# Architecture specific tools
[ "${ARCH}" = "x86_64" ] && PKG_DEPENDS_TARGET+=" ryzenadj lm_sensors dmidecode xterm"

# GL demos and tools
[ "${OPENGL_SUPPORT}" = "yes" ]&& PKG_DEPENDS_TARGET+=" mesa-demos glmark2"

# Sound support
[ "${ALSA_SUPPORT}" = "yes" ] && PKG_DEPENDS_TARGET+=" alsa"

# Automounter support
[ "${UDEVIL}" = "yes" ] && PKG_DEPENDS_TARGET+=" udevil"

# EXFAT support
[ "${EXFAT}" = "yes" ] && PKG_DEPENDS_TARGET+=" exfat exfatprogs"

# NTFS 3G support
[ "${NTFS3G}" = "yes" ] && PKG_DEPENDS_TARGET+=" ntfs-3g_ntfsprogs"

# Virtual image creation support
[ "${PROJECT}" = "Generic" ] && PKG_DEPENDS_TARGET+=" virtual"

# Installer support
[ "${INSTALLER_SUPPORT}" = "yes" ] && PKG_DEPENDS_TARGET+=" installer"

# Devtools... (not for Release)
[ "${TESTING}" = "yes" ] && PKG_DEPENDS_TARGET+=" testing"

# OEM packages
[ "${OEM_SUPPORT}" = "yes" ] && PKG_DEPENDS_TARGET+=" oem"

# htop
[ "${HTOP_TOOL}" = "yes" ] && PKG_DEPENDS_TARGET+=" htop"

true
