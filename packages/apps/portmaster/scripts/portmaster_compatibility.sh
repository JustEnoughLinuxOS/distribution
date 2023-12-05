#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present - The JELOS Project (https://github.com/JustEnoughLinuxOS)

. /etc/profile

if [[ "${UI_SERVICE}" =~ weston.service ]]; then
case ${QUIRK_DEVICE} in
  "Hardkernel ODROID-GO-Ultra"|"Powkiddy RGB10 MAX 3"|"Hardkernel ODROID-N2*")
    #Fixing ports on S922X, exclude FNA games
    for port in /storage/roms/ports/*.sh; do
      if ! grep -q FNA "$port"; then
  	    sed -i '/get_controls/c\get_controls && export SDL_VIDEO_GL_DRIVER=/usr/lib/egl/libGL.so.1 SDL_VIDEO_EGL_DRIVER=/usr/lib/egl/libEGL.so.1' "$port"
        echo Fixing: "$port";
      fi
    done;
  ;;
  *)
    #Remove gl4es libs on devices that support OpenGL
    rm -rf /storage/roms/ports/*/lib*/libEGL*
    rm -rf /storage/roms/ports/*/lib*/libGL*
  ;;
esac
fi
