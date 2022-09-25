#!/bin/bash

# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2022-present travis134

. /etc/profile

BUILDENGINEPATH="/storage/roms/build"

# From https://zdoom.org/wiki/Raze#Supported_games
SUPPORTED_GRP=(
	"BLOOD.RFF"
	"DUKE3D.GRP"
	"DUKEDC.GRP"
	"VACATION.GRP"
	"NWINTER.GRP"
	"STUFF.DAT"
	"NAM.GRP"
	"REDNECK.GRP"
	"SW.GRP"
	"TD.GRP"
	"TWINDRAG.GRP"
	"WT.GRP"
	"WW2GI.GRP"
	"PLATOONL.DAT"
)

clear
echo "Scanning for games..."
find_names=()
for i in "${!SUPPORTED_GRP[@]}"; do
	if [[ "${i}" != 0 ]]; then
		find_names+=("-o")
	fi
	find_names+=("-name")
	find_names+=("${SUPPORTED_GRP[$i]}")
done
grp_files=$(find "${BUILDENGINEPATH}" -mindepth 1 -type f \( "${find_names[@]}" \))
# This is a hack that ensures any expansion GRP file gets written out as a
# build file last. For example, VACATION.GRP is an expansion for DUKE3D.GRP.
# For the expansion to work, both GRP files must be present, but the expansion
# GRP must be passed to the Raze engine. It just so happens that all of the
# expansion GRP files are named alphabetically later than base game GRP files,
# meaning we can get by with a simple lexical sort before processing.
grp_files=$(echo "${grp_files}" | sort)
echo "Adding games..."
while read -r grp_file; do
	abs_path=$(dirname "${grp_file}")
	path=${abs_path#"$BUILDENGINEPATH/"}
	filename="${path##*/}"
	if [[ "$path" =~ \ |\' ]]; then
		path="\"${path}\""
	fi
	grp=$(basename "${grp_file}")
	if [[ "$grp" =~ \ |\' ]]; then
		grp="\"${grp}\""
	fi

	file="${BUILDENGINEPATH}/${filename}.build"
	cat >"${file}" <<-EOM
		PATH=${path}
		GRP=${grp}
		-- end --
	EOM
done <<<"${grp_files}"
clear
