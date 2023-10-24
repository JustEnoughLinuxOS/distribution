# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023-present - The JELOS Project (https://github.com/JustEnoughLinuxOS)

PKG_NAME="gamesupport"
PKG_LICENSE="GPLv2"
PKG_SITE="www.jelos.org"
PKG_SECTION="virtual"
PKG_LONGDESC="Game support software metapackage."

PKG_GAMESUPPORT="sixaxis gptokeyb jstest-sdl gamecontrollerdb sdljoytest control-gen"

PKG_DEPENDS_TARGET="${PKG_GAMESUPPORT}"

