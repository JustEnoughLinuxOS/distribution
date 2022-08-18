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
	path=$(dirname "${grp_file}")
	grp=$(basename "${grp_file}")
	file="${RAZEPATH}/${grp%.*}.build"
	cat >"${file}" <<-EOM
		PATH=${path#"$RAZEPATH/"}
		GRP=${grp}
		-- end --
	EOM
done <<<"${grp_files}"
systemctl restart emustation
clear >/dev/console
