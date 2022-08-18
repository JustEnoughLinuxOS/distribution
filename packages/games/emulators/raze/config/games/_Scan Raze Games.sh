#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present travis134

. /etc/profile

RAZEPATH="/storage/roms/build"

clear >/dev/console
echo "Scanning for games..." >/dev/console
grp_files=$(find "${RAZEPATH}" -type f -iname "*.grp")
echo "Adding games..." >/dev/console
while read -r grp_file; do
	abs_path=$(dirname "${grp_file}")
	cp -f /storage/.config/game/raze/raze.pk3 "${abs_path}/raze.pk3"
	path=${abs_path#"$RAZEPATH/"}
	if [[ "$path" =~ \ |\' ]]; then
		path="\"${path}\""
	fi
	grp=$(basename "${grp_file}")
	if [[ "$grp" =~ \ |\' ]]; then
		path="\"${grp}\""
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
