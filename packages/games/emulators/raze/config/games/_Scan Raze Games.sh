#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present travis134

. /etc/profile

RAZEPATH="/storage/roms/build"

clear >/dev/console
echo "Scanning for games..." >/dev/console
grp_files=$(find "${RAZEPATH}" -type f \( -iname "*.grp" -o -iname "*.rff" \))
echo "Adding games..." >/dev/console
while read -r grp_file; do
	abs_path=$(dirname "${grp_file}")
	path=${abs_path#"$RAZEPATH/"}
	if [[ "$path" =~ \ |\' ]]; then
		path="\"${path}\""
	fi
	grp=$(basename "${grp_file}")
	if [[ "$grp" =~ \ |\' ]]; then
		grp="\"${grp}\""
	fi

	# Skip known non-game matches
	if [[ ${grp^^} = "GUI.RFF" || ${grp^^} = "SOUNDS.RFF" ]]; then
		continue
	fi

	file="${RAZEPATH}/${grp%.*}.build"
	cat >"${file}" <<-EOM
		PATH=${path}
		GRP=${grp}
		-- end --
	EOM
done <<<"${grp_files}"
systemctl restart emustation
clear >/dev/console
