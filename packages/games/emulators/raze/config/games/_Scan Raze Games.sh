#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present travis134

. /etc/profile

RAZEPATH="/storage/roms/build"

# From https://zdoom.org/wiki/Raze#Supported_games
SUPPORTED_GRP=("BLOOD.RFF" "DUKE3D.GRP" "DUKEDC.GRP" "VACATION.GRP" "NWINTER.GRP" "STUFF.DAT" "NAM.GRP" "REDNECK.GRP" "SW.GRP" "TD.GRP" "TWINDRAG.GRP" "WT.GRP" "WW2GI.GRP" "PLATOONL.DAT")

clear >/dev/console
echo "Scanning for games..." >/dev/console
find_names=()
for i in "${!SUPPORTED_GRP[@]}"; do
	if [[ "${i}" != 0 ]]; then
		find_names+=("-o")
	fi
	find_names+=("-name")
	find_names+=("${SUPPORTED_GRP[$i]}")
done
grp_files=$(find "${RAZEPATH}" -mindepth 1 -type f \( "${find_names[@]}" \))
echo "Adding games..." >/dev/console
while read -r grp_file; do
	abs_path=$(dirname "${grp_file}")
	path=${abs_path#"$RAZEPATH/"}
	filename="${path##*/}"
	if [[ "$path" =~ \ |\' ]]; then
		path="\"${path}\""
	fi
	grp=$(basename "${grp_file}")
	if [[ "$grp" =~ \ |\' ]]; then
		grp="\"${grp}\""
	fi

	file="${RAZEPATH}/${filename}.build"
	cat >"${file}" <<-EOM
		PATH=${path}
		GRP=${grp}
		-- end --
	EOM
done <<<"${grp_files}"
systemctl restart emustation
clear >/dev/console
