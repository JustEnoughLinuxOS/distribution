#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2021-present - Fewtarius

. /etc/profile

ARG=${1//[\\]/}
export SDL_AUDIODRIVER=alsa
echo "[${ARG}]"
${FAST_CORES} x64sc -sounddev alsa -sdl2renderer opengles2 "$ARG"
