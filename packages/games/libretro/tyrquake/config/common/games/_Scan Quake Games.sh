#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2022-present travis134

. /etc/profile

QUAKEPATH="/storage/roms/quake"

stop_ui
clear >/dev/console
echo "Scanning for games..." >/dev/console
pak_files=$(find "${QUAKEPATH}" -mindepth 1 -type f -iname pak0.pak)
echo "Adding games..." >/dev/console
while read -r pak_file; do
	abs_path=$(dirname "${pak_file}")
	path=${abs_path#"$QUAKEPATH/"}
	filename="${path##*/}"
	if [[ "${path,,}" == *"id1"* ]]; then
		filename="Quake"
	elif [[ "${path,,}" == *"hipnotic"* ]]; then
		filename="Quake Mission Pack 1 - Scourge of Armagon"
	elif [[ "${path,,}h" == *"rogue"* ]]; then
		filename="Quake Mission Pack 2 - Dissolution of Eternity"
	elif [[ "${path,,}" == *"dopa"* ]]; then
		filename="Quake - Dimension of the Past"
	fi
	file="${QUAKEPATH}/${filename}.quake"
	cat >"${file}" <<-EOM
		PAK=${pak_file}
		-- end --
	EOM
done <<<"${pak_files}"
start_ui
clear >/dev/console
