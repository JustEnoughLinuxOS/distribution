#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2020-present Fewtarius

# IMPORTANT: This script should not return (echo) anything other than the shader if its set

. /etc/profile

RETROACHIEVEMENTS=(arcade atari2600 atari7800 atarilynx colecovision famicom fbn fds gamegear gb gba gbah gbc gbch gbh genesis genh ggh intellivision mastersystem megacd megadrive megadrive-japan msx msx2 n64 neogeo neogeocd nes nesh ngp ngpc odyssey2 pcengine pcenginecd pcfx pokemini psp psx sega32x segacd sfc sg-1000 snes snesh snesmsu1 supergrafx supervision tg16 tg16cd vectrex virtualboy wonderswan wonderswancolor)
NOREWIND=(sega32x psx zxspectrum odyssey2 mame n64 dreamcast atomiswave naomi neogeocd saturn psp pspminis)
NORUNAHEAD=(psp sega32x n64 dreamcast atomiswave naomi neogeocd saturn)
# The following systems are listed as they don't need the Analogue D-Pad mode on RA
NOANALOGUE=(n64 psx wonderswan wonderswancolor psp pspminis dreamcast)
IS32BITCORE=(pcsx_rearmed gpsp)

INDEXRATIOS=(4/3 16/9 16/10 16/15 21/9 1/1 2/1 3/2 3/4 4/1 9/16 5/4 6/5 7/9 8/3 8/7 19/12 19/14 30/17 32/9 config squarepixel core custom full)
CONF="/storage/.config/system/configs/system.cfg"
SOURCERACONF="/usr/config/retroarch/retroarch.cfg"
RACONF="/storage/.config/retroarch/retroarch.cfg"
RAAPPENDCONF="/tmp/raappend.cfg"
RACORECONF="/storage/.config/retroarch/retroarch-core-options.cfg"
SNAPSHOTS="/storage/roms/savestates"
PLATFORM=${1,,}
ROM="${2##*/}"
CORE=${3,,}
SHADERSET=0
LOGSDIR="/var/log"
LOGFILE="exec.log"
EE_DEVICE=${HW_DEVICE}

#Autosave
AUTOSAVE="$@"
AUTOSAVE="${AUTOSAVE#*--autosave=*}"
AUTOSAVE="${AUTOSAVE% --*}"

#Snapshot
SNAPSHOT="$@"
SNAPSHOT="${SNAPSHOT#*--snapshot=*}"

### Enable logging
if [ "$(get_setting string LogLevel)" == "minimal" ]; then
	LOG=false
else
	LOG=true
	VERBOSE=true
fi

function log() {
	if [ ${LOG} == true ]; then
		if [[ ! -d "$LOGSDIR" ]]; then
			mkdir -p "$LOGSDIR"
		fi
		DATE=$(date +"%b %d %H:%M:%S")
		echo "${DATE} ${MYNAME}: $1" 2>&1 >> ${LOGSDIR}/${LOGFILE}
	fi
}

## Create / delete raappend.cfg
echo -n > "${RAAPPENDCONF}"

### Move operations to /tmp so we're not writing to the microSD slowing us down.
### Also test the file to ensure it's not 0 bytes which can happen if someone presses reset.
if [ ! -s ${RACONF} ]; then
	log $0 "Fix broken RA conf"
	cp -f "${SOURCERACONF}" "${RACONF}"
fi

if [ ! -d "${SNAPSHOTS}/${PLATFORM}" ]; then
	mkdir -p "${SNAPSHOTS}/${PLATFORM}"
fi

function doexit() {
	log $0 "Exiting.."
	sync
	exit 0
}

## This needs to be killed with fire.
function get_game_setting() {
	log $0 "Get Settings function (${1})"
	#We look for the setting on the ROM first, if not found we search for platform and lastly we search globally
	escaped_rom_name=$(echo "${ROM}" | sed -E 's|([][])|\\\1|g')
	PAT="s|^${PLATFORM}\[\"${escaped_rom_name}\"\][\.-]${1}=\(.*\)|\1|p"
	EES=$(sed -n "${PAT}" "${CONF}" | head -1)

	if [ -z "${EES}" ]; then
		PAT="s|^${PLATFORM}[\.-]${1}=\(.*\)|\1|p"
		EES=$(sed -n "${PAT}" "${CONF}" | head -1)
	fi

	if [ -z "${EES}" ]; then
		PAT="s|^global[\.-].*${1}=\(.*\)|\1|p"
		EES=$(sed -n "${PAT}" "${CONF}" | head -1)
	fi

	[ -z "${EES}" ] && EES="false"
}


function array_contains () {
    local array="$1[@]"
    local seeking=$2
    local in=1
    for element in "${!array}"; do
        if [[ $element == "$seeking" ]]; then
            in=0
            break
        fi
    done
    return $in
}

## Logging
log $0 "setsettings.sh"
log $0 "Platform: ${PLATFORM}"
log $0 "ROM: ${ROM}"
log $0 "Core: ${CORE}"

##
## Global Setting that have to stay in retroarch.cfg
## All settings that should apply when retroarch is run as standalone
##

MY_CONTROLLER=$(cat /storage/.controller)
if [ "$(get_setting system.autohotkeys)" == "1" ]
then
  if [ -e "/tmp/joypads/${MY_CONTROLLER}.cfg" ]
  then
    cp /tmp/joypads/"${MY_CONTROLLER}.cfg" /tmp
    sed -i "s# = #=#g" /tmp/"${MY_CONTROLLER}.cfg"
    source /tmp/"${MY_CONTROLLER}.cfg"
    sed -i "/input_enable_hotkey_btn/d" ${RACONF}
    sed -i "/input_bind_hold/d" ${RACONF}
    sed -i "/input_exit_emulator_btn/d" ${RACONF}
    sed -i "/input_fps_toggle_btn/d" ${RACONF}
    sed -i "/input_menu_toggle_btn/d" ${RACONF}
    sed -i "/input_save_state_btn/d" ${RACONF}
    sed -i "/input_load_state_btn/d" ${RACONF}
    cat <<EOF >>${RACONF}
input_enable_hotkey_btn = "${input_select_btn}"
input_bind_hold = "${input_select_btn}"
input_exit_emulator_btn = "${input_start_btn}"
input_fps_toggle_btn = "${input_y_btn}"
input_menu_toggle_btn = "${input_x_btn}"
input_save_state_btn = "${input_r_btn}"
input_load_state_btn = "${input_l_btn}"
EOF
    rm -f /tmp/"${MY_CONTROLLER}.cfg"
  fi
fi

# RA menu rgui, ozone, glui or xmb (fallback if everthing else fails)
# if empty (auto in ES) do nothing to enable configuration in RA
get_game_setting "retroarch.menu_driver"
if [ "${EES}" != "false" ]; then
	# delete setting only if we set new ones
	# therefore configuring in RA is still possible
	sed -i "/menu_driver/d" ${RACONF}
	sed -i "/menu_linear_filter/d" ${RACONF}
	# Set new menu driver
	if [ "${EES}" == "rgui" ]; then
		# menu_liner_filter is only needed for rgui
		echo 'menu_driver = "rgui"' >> ${RACONF}
		echo 'menu_linear_filter = "true"' >> ${RACONF}
	elif [ "${EES}" == "ozone" ]; then
		echo 'menu_driver = "ozone"' >> ${RACONF}
	elif [ "${EES}" == "glui" ]; then
		echo 'menu_driver = "glui"' >> ${RACONF}
	else
		# play it save and set xmb if nothing else matches
		echo 'menu_driver = "xmb"' >> ${RACONF}
	fi
fi


##
## Global Settings that go into the temorary config file
##

## FPS
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting "showFPS"
[ "${EES}" == "1" ] && echo 'fps_show = "true"' >> ${RAAPPENDCONF} || echo 'fps_show = "false"' >> ${RAAPPENDCONF}


## RetroAchievements / Cheevos
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting "retroachievements"
for i in "${!RETROACHIEVEMENTS[@]}"; do
	if [[ "${RETROACHIEVEMENTS[$i]}" = "${PLATFORM}" ]]; then
		if [ "${EES}" == "1" ]; then
			echo 'cheevos_enable = "true"' >> ${RAAPPENDCONF}
			get_game_setting "retroachievements.username"
			echo "cheevos_username = \"${EES}\"" >> ${RAAPPENDCONF}
			get_game_setting "retroachievements.password"
			echo "cheevos_password = \"${EES}\"" >> ${RAAPPENDCONF}

			# retroachievements_hardcore_mode
			get_game_setting "retroachievements.hardcore"
			[ "${EES}" == "1" ] && echo 'cheevos_hardcore_mode_enable = "true"' >> ${RAAPPENDCONF} || echo 'cheevos_hardcore_mode_enable = "false"' >> ${RAAPPENDCONF}

			# retroachievements_leaderboards
			get_game_setting "retroachievements.leaderboards"
			if [ "${EES}" == "enabled" ]; then
				echo 'cheevos_leaderboards_enable = "true"' >> ${RAAPPENDCONF}
			elif [ "${EES}" == "trackers only" ]; then
				echo 'cheevos_leaderboards_enable = "trackers"' >> ${RAAPPENDCONF}
			elif [ "${EES}" == "notifications only" ]; then
				echo 'cheevos_leaderboards_enable = "notifications"' >> ${RAAPPENDCONF}
			else
				echo 'cheevos_leaderboards_enable = "false"' >> ${RAAPPENDCONF}
			fi

			# retroachievements_verbose_mode
			get_game_setting "retroachievements.verbose"
			[ "${EES}" == "1" ] && echo 'cheevos_verbose_enable = "true"' >> ${RAAPPENDCONF} || echo 'cheevos_verbose_enable = "false"' >> ${RAAPPENDCONF}

			# retroachievements_automatic_screenshot
			get_game_setting "retroachievements.screenshot"
			[ "${EES}" == "1" ] && echo 'cheevos_auto_screenshot = "true"' >> ${RAAPPENDCONF} || echo 'cheevos_auto_screenshot = "false"' >> ${RAAPPENDCONF}

			# cheevos_richpresence_enable
			get_game_setting "retroachievements.richpresence"
			[ "${EES}" == "1" ] && echo 'cheevos_richpresence_enable = "true"' >> ${RAAPPENDCONF} || echo 'cheevos_richpresence_enable = "false"' >> ${RAAPPENDCONF}

			# cheevos_challenge_indicators
			get_game_setting "retroachievements.challengeindicators"
			[ "${EES}" == "1" ] && echo 'cheevos_challenge_indicators = "true"' >> ${RAAPPENDCONF} || echo 'cheevos_challenge_indicators = "false"' >> ${RAAPPENDCONF}

			# cheevos_test_unofficial
			get_game_setting "retroachievements.testunofficial"
			[ "${EES}" == "1" ] && echo 'cheevos_test_unofficial = "true"' >> ${RAAPPENDCONF} || echo 'cheevos_test_unofficial = "false"' >> ${RAAPPENDCONF}

			# cheevos_badges_enable
			get_game_setting "retroachievements.badges"
			[ "${EES}" == "1" ] && echo 'cheevos_badges_enable = "true"' >> ${RAAPPENDCONF} || echo 'cheevos_badges_enable = "false"' >> ${RAAPPENDCONF}

			# cheevos_start_active
			get_game_setting "retroachievements.active"
			[ "${EES}" == "1" ] && echo 'cheevos_start_active = "true"' >> ${RAAPPENDCONF} || echo 'cheevos_start_active = "false"' >> ${RAAPPENDCONF}

			# cheevos_unlock_sound_enable
			get_game_setting "retroachievements.soundenable"
			[ "${EES}" == "1" ] && echo 'cheevos_unlock_sound_enable = "true"' >> ${RAAPPENDCONF} || echo 'cheevos_unlock_sound_enable = "false"' >> ${RAAPPENDCONF}
		else
			echo 'cheevos_enable = "false"' >> ${RAAPPENDCONF}
			echo 'cheevos_username = ""' >> ${RAAPPENDCONF}
			echo 'cheevos_password = ""' >> ${RAAPPENDCONF}
			echo 'cheevos_hardcore_mode_enable = "false"' >> ${RAAPPENDCONF}
			echo 'cheevos_leaderboards_enable = "false"' >> ${RAAPPENDCONF}
			echo 'cheevos_verbose_enable = "false"' >> ${RAAPPENDCONF}
			echo 'cheevos_test_unofficial = "false"' >> ${RAAPPENDCONF}
			echo 'cheevos_unlock_sound_enable = "false"' >> ${RAAPPENDCONF}
			echo 'cheevos_auto_screenshot = "false"' >> ${RAAPPENDCONF}
			echo 'cheevos_badges_enable = "false"' >> ${RAAPPENDCONF}
			echo 'cheevos_start_active = "false"' >> ${RAAPPENDCONF}
			echo 'cheevos_richpresence_enable = "false"' >> ${RAAPPENDCONF}
			echo 'cheevos_challenge_indicators = "false"' >> ${RAAPPENDCONF}
		fi
	fi
done

## Netplay
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting "netplay"
if [ "${EES}" == "false" ] || [ "${EES}" == "none" ] || [ "${EES}" == "0" ]; then
	echo 'netplay = false' >> ${RAAPPENDCONF}
else
	echo 'netplay = true' >> ${RAAPPENDCONF}
	get_game_setting "netplay.mode"
	NETPLAY_MODE=${EES}
	# Security : hardcore mode disables save states, which would kill netplay
	sed -i '/cheevos_hardcore_mode_enable =/d' ${RAAPPENDCONF}
	echo 'cheevos_hardcore_mode_enable = "false"' >> ${RAAPPENDCONF}

	if [[ "${NETPLAY_MODE}" == "host" ]]; then
		# Quite strangely, host mode requires netplay_mode to be set to false when launched from command line
		echo 'netplay_mode = false' >> ${RAAPPENDCONF}
		echo 'netplay_client_swap_input = false' >> ${RAAPPENDCONF}
		get_game_setting "netplay.port"
		echo "netplay_ip_port = ${EES}" >> ${RAAPPENDCONF}
	elif [[ "${NETPLAY_MODE}" == "client" ]]; then
		# But client needs netplay_mode = true ... bug ?
		echo 'netplay_mode = true' >> ${RAAPPENDCONF}
		get_game_setting "netplay.client.ip"
		echo "netplay_ip_address = ${EES}" >> ${RAAPPENDCONF}
		get_game_setting "netplay.client.port"
		echo "netplay_ip_port = ${EES}" >> ${RAAPPENDCONF}
		echo 'netplay_client_swap_input = true' >> ${RAAPPENDCONF}
	fi # Host or Client

	# relay
	get_game_setting "netplay.relay"
	if [[ ! -z "${EES}" && "${EES}" != "false" ]]; then
		echo 'netplay_use_mitm_server = true' >> ${RAAPPENDCONF}
		echo "netplay_mitm_server = ${EES}" >> ${RAAPPENDCONF}
	else
		echo 'netplay_use_mitm_server = false' >> ${RAAPPENDCONF}
		# sed -i "/netplay_mitm_server/d" ${RACONF}
	fi

	get_game_setting "netplay.frames"
	echo "netplay_delay_frames = ${EES}" >> ${RAAPPENDCONF}
	get_game_setting "netplay.nickname"
	echo "netplay_nickname = ${EES}" >> ${RAAPPENDCONF}
	# spectator mode
	get_game_setting "netplay.spectator"
	[ "${EES}" == "1" ] && echo 'netplay_spectator_mode_enable = true' >> ${RAAPPENDCONF} || echo 'netplay_spectator_mode_enable = false' >> ${RAAPPENDCONF}
	get_game_setting "netplay_public_announce"
	[ "${EES}" == "1" ] && echo 'netplay_public_announce = true' >> ${RAAPPENDCONF} || echo 'netplay_public_announce = false' >> ${RAAPPENDCONF}
fi

## AI Translation Service
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting "ai_service_enabled"
if [ "${EES}" == "false" ] || [ "${EES}" == "none" ] || [ "${EES}" == "0" ]; then
	echo 'ai_service_enable = "false"' >> ${RAAPPENDCONF}
else
	# Translation table to get the values RA needs
	declare -A LangCodes=( 	["false"]="0"
							["En"]="1"
							["Fr"]="3"
							["Pt"]="49"
							["De"]="5"
							["El"]="30"
							["Es"]="2"
							["Cs"]="8"
							["Da"]="9"
							["Hr"]="11"
							["Hu"]="35"
							["It"]="4"
							["Ja"]="6"
							["Ko"]="12"
							["Nl"]="7"
							["Nn"]="46"
							["Po"]="48"
							["Ro"]="50"
							["Ru"]="51"
							["Sv"]="10"
							["Tr"]="59"
							["Zh"]="13"
                  		)
	echo 'ai_service_enable = "true"' >> ${RAAPPENDCONF}
	get_game_setting "ai_target_lang"
	AI_LANG=${EES}
	# [[ "$AI_LANG" == "false" ]] && AI_LANG="0"
	get_game_setting "ai_service_url"
	AI_URL=${EES}
	echo "ai_service_target_lang = \"${LangCodes[${AI_LANG}]}\"" >> ${RAAPPENDCONF}
	if [ "${AI_URL}" == "false" ] || [ "${AI_URL}" == "auto" ] || [ "${AI_URL}" == "none" ]; then
		echo "ai_service_url = \"http://ztranslate.net/service?api_key=BATOCERA&mode=Fast&output=png&target_lang=${AI_LANG}" >> ${RAAPPENDCONF}
	else
		echo "ai_service_url = \"${AI_URL}&mode=Fast&output=png&target_lang=${AI_LANG}" >> ${RAAPPENDCONF}
	fi
fi

##
## Global/System/Game specific settings
##

## Ratio
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting "ratio"
if [[ "${EES}" == "false" ]]; then
	# 22 is the "Core Provided" aspect ratio and its set by default if no other is selected
	echo 'aspect_ratio_index = "22"' >> ${RAAPPENDCONF}
else
for i in "${!INDEXRATIOS[@]}"; do
	if [[ "${INDEXRATIOS[$i]}" = "${EES}" ]]; then
		break
	fi
done
	echo "aspect_ratio_index = \"${i}\"" >> ${RAAPPENDCONF}
fi

## Bilinear filtering
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting "smooth"
[ "${EES}" == "1" ] && echo 'video_smooth = "true"' >> ${RAAPPENDCONF} || echo 'video_smooth = "false"' >> ${RAAPPENDCONF}

## Video Integer Scale
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting "integerscale"
[ "${EES}" == "1" ] && echo 'video_scale_integer = "true"' >> ${RAAPPENDCONF} || echo 'video_scale_integer = "false"' >> ${RAAPPENDCONF}

## RGA Scaling / CTX Scaling
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting	"rgascale"
[ "${EES}" == "1" ] && echo 'video_ctx_scaling = "true"' >> ${RAAPPENDCONF} || echo 'video_ctx_scaling = "false"' >> ${RAAPPENDCONF}

## Shaderset
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting "shaderset"
if [ "${EES}" == "false" ] || [ "${EES}" == "none" ] || [ "${EES}" == "0" ]; then
	echo 'video_shader_enable = "false"' >> ${RAAPPENDCONF}
	echo 'video_shader = ""' >> ${RAAPPENDCONF}
else
	echo "video_shader = \"${EES}\"" >> ${RAAPPENDCONF}
	echo 'video_shader_enable = "true"' >> ${RAAPPENDCONF}
	echo "--set-shader /tmp/shaders/${EES}"
fi

## Filterset
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting "filterset"
if [ "${EES}" == "false" ] || [ "${EES}" == "none" ]; then
	echo 'video_filter = ""' >> ${RAAPPENDCONF}
else
	# Turn off RGA scaling first - just in case
	sed -i "/video_ctx_scaling/d" ${RAAPPENDCONF}
	echo 'video_ctx_scaling = "false"' >> ${RAAPPENDCONF}
	if array_contains IS32BITCORE ${CORE}; then
		echo "video_filter = \"/usr/share/retroarch/filters/32bit/video/${EES}\"" >> ${RAAPPENDCONF}
	else
		echo "video_filter = \"/usr/share/retroarch/filters/64bit/video/${EES}\"" >> ${RAAPPENDCONF}
	fi
fi

## Set correct path for video- and audio-filters
if array_contains IS32BITCORE ${CORE}; then
	echo 'audio_filter_dir = "/usr/share/retroarch/filters/32bit/audio"' >> ${RAAPPENDCONF}
	echo 'video_filter_dir = "/usr/share/retroarch/filters/32bit/video"' >> ${RAAPPENDCONF}
else
	echo 'audio_filter_dir = "/usr/share/retroarch/filters/64bit/audio"' >> ${RAAPPENDCONF}
	echo 'video_filter_dir = "/usr/share/retroarch/filters/64bit/video"' >> ${RAAPPENDCONF}
fi

## Rewind
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting "rewind"
(for e in "${NORUNAHEAD[@]}"; do [[ "${e}" == "${PLATFORM}" ]] && exit 0; done) && RA=0 || RA=1
if [ $RA == 1 ] && [ "${EES}" == "1" ]; then
	echo 'rewind_enable = "true"' >> ${RAAPPENDCONF}
else
	echo 'rewind_enable = "false"' >> ${RAAPPENDCONF}
fi

## Incrementalsavestates
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting "incrementalsavestates"
if [ "${EES}" == "false" ] || [ "${EES}" == "none" ] || [ "${EES}" == "0" ]; then
	echo 'savestate_auto_index = "false"' >> ${RAAPPENDCONF}
	echo 'savestate_max_keep = "50"' >> ${RAAPPENDCONF}
else
	echo 'savestate_auto_index = "true"' >> ${RAAPPENDCONF}
	echo 'savestate_max_keep = "0"' >> ${RAAPPENDCONF}
fi

## Autosave
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting "autosave"
if [ "${EES}" == "false" ] || [ "${EES}" == "none" ] || [ "${EES}" == "0" ]; then
	echo 'savestate_auto_save = "false"' >> ${RAAPPENDCONF}
	echo 'savestate_auto_load = "false"' >> ${RAAPPENDCONF}
else
	echo 'savestate_auto_save = "true"' >> ${RAAPPENDCONF}
	echo 'savestate_auto_load = "true"' >> ${RAAPPENDCONF}
fi

## Snapshots
echo 'savestate_directory = "'"${SNAPSHOTS}/${PLATFORM}"'"' >> ${RAAPPENDCONF}
if [ ! -z ${SNAPSHOT} ]
then
		sed -i "/savestate_auto_load =/d" ${RAAPPENDCONF}
		sed -i "/savestate_auto_save =/d" ${RAAPPENDCONF}
		if [ ${AUTOSAVE} == "1" ]; then
			echo 'savestate_auto_load = "true"' >> ${RAAPPENDCONF}
			echo 'savestate_auto_save = "true"' >> ${RAAPPENDCONF}
		else
			echo 'savestate_auto_load = "false"' >> ${RAAPPENDCONF}
			echo 'savestate_auto_save = "false"' >> ${RAAPPENDCONF}
                fi
		echo "state_slot = \"${SNAPSHOT}\"" >> ${RAAPPENDCONF}
fi

## Runahead
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting "runahead"
(for e in "${NORUNAHEAD[@]}"; do [[ "${e}" == "${PLATFORM}" ]] && exit 0; done) && RA=0 || RA=1
if [ $RA == 1 ]; then
	if [ "${EES}" == "false" ] || [ "${EES}" == "none" ] || [ "${EES}" == "0" ]; then
		echo 'run_ahead_enabled = "false"' >> ${RAAPPENDCONF}
		echo 'run_ahead_frames = "1"' >> ${RAAPPENDCONF}
	else
		echo 'run_ahead_enabled = "true"' >> ${RAAPPENDCONF}
		echo "run_ahead_frames = \"${EES}\"" >> ${RAAPPENDCONF}
	fi
fi

## Secondinstance
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting "secondinstance"
(for e in "${NORUNAHEAD[@]}"; do [[ "${e}" == "${PLATFORM}" ]] && exit 0; done) && RA=0 || RA=1
if [ $RA == 1 ]; then
	[ "${EES}" == "1" ] && echo 'run_ahead_secondary_instance = "true"' >> ${RAAPPENDCONF} || echo 'run_ahead_secondary_instance = "false"' >> ${RAAPPENDCONF}
fi

## Audiolatency
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting "audiolatency"
if [[ "${EES}" =~ ^[0-9]+$ ]] && [[ "${EES}" -gt "0" ]]; then
	echo "audio_latency = \"${EES}\"" >> ${RAAPPENDCONF}
fi

## D-Pad to Analogue support, option in ES is missing atm but is managed as global.analogue=1 in system.cfg (that is made by postupdate.sh)
# Get configuration from system.cfg and set to retroarch.cfg
get_game_setting "analogue"
(for e in "${NOANALOGUE[@]}"; do [[ "${e}" == "${PLATFORM}" ]] && exit 0; done) && RA=1 || RA=0
if [ $RA == 1 ] || [ "${EES}" == "false" ] || [ "${EES}" == "0" ]; then
        echo 'input_player1_analog_dpad_mode = "0"' >> ${RAAPPENDCONF}
else
        echo 'input_player1_analog_dpad_mode = "1"' >> ${RAAPPENDCONF}
fi

##
## Tate Mode
##

get_game_setting "tatemode"
MAME2003DIR="/storage/.config/retroarch/config/MAME 2003-Plus"
MAME2003REMAPDIR="/storage/remappings/MAME 2003-Plus"
if [ "${EES}" == "1" ]
then
	if [ ! -d "${MAME2003DIR}" ]
	then
		mkdir -p "${MAME2003DIR}"
	fi

        if [ ! -d "${MAME2003REMAPDIR}" ]
        then
                mkdir -p "${MAME2003REMAPDIR}"
	fi

	cp "/usr/config/retroarch/TATE-MAME 2003-Plus.rmp" "${MAME2003REMAPDIR}/MAME 2003-Plus.rmp"

	if [ "$(grep mame2003-plus_tate_mode "${MAME2003DIR}/MAME 2003-Plus.opt" > /dev/null 2>&1)" ]
	then
		sed -i 's#mame2003-plus_tate_mode.*$#mame2003-plus_tate_mode = "enabled"#' "${MAME2003DIR}/MAME 2003-Plus.opt" 2>/dev/null
	else
		echo 'mame2003-plus_tate_mode = "enabled"' > "${MAME2003DIR}/MAME 2003-Plus.opt"
	fi
else
	if [ -e "${MAME2003DIR}/MAME 2003-Plus.opt" ]
	then
		sed -i 's#mame2003-plus_tate_mode.*$#mame2003-plus_tate_mode = "disabled"#' "${MAME2003DIR}/MAME 2003-Plus.opt" 2>/dev/null
	fi
	if [ -e "${MAME2003REMAPDIR}/MAME 2003-Plus.rmp" ]
	then
		rm -f "${MAME2003REMAPDIR}/MAME 2003-Plus.rmp"
	fi
fi

##
## Parallel-N64 core options
##

PARALLELN64DIR="/storage/.config/retroarch/config/ParaLLEl N64"

        if [ ! -d "${PARALLELN64DIR}" ]
        then
                mkdir -p "${PARALLELN64DIR}"
        fi

        if [ ! -f "${PARALLELN64DIR}/ParaLLEl N64.opt" ]
        then
                cp "/usr/config/retroarch/ParaLLEl N64.opt" "${PARALLELN64DIR}/ParaLLEl N64.opt"
        fi

get_game_setting "parallel_n64_video_core"

        if [ "${EES}" == "glide64" ]
        then
                sed -i '/parallel-n64-gfxplugin = /c\parallel-n64-gfxplugin = "glide64"' "/storage/.config/retroarch/config/ParaLLEl N64/ParaLLEl N64.opt"
        fi

        if [ "${EES}" == "rice" ]
        then
                sed -i '/parallel-n64-gfxplugin = /c\parallel-n64-gfxplugin = "rice"' "/storage/.config/retroarch/config/ParaLLEl N64/ParaLLEl N64.opt"
        fi

        if [ "${EES}" == "gln64" ]
        then
                sed -i '/parallel-n64-gfxplugin = /c\parallel-n64-gfxplugin = "gln64"' "/storage/.config/retroarch/config/ParaLLEl N64/ParaLLEl N64.opt"
        fi

get_game_setting "parallel_n64_internal_resolution"

        if [ "${EES}" == "240p" ]
        then
                sed -i '/parallel-n64-screensize = /c\parallel-n64-screensize = "320x240"' "/storage/.config/retroarch/config/ParaLLEl N64/ParaLLEl N64.opt"
        fi

        if [ "${EES}" == "480p" ]
        then
                sed -i '/parallel-n64-screensize = /c\parallel-n64-screensize = "640x480"' "/storage/.config/retroarch/config/ParaLLEl N64/ParaLLEl N64.opt"
        fi

        if [ "${EES}" == "720p" ]
        then
                sed -i '/parallel-n64-screensize = /c\parallel-n64-screensize = "960x720"' "/storage/.config/retroarch/config/ParaLLEl N64/ParaLLEl N64.opt"
        fi

        if [ "${EES}" == "1080p" ]
        then
                sed -i '/parallel-n64-screensize = /c\parallel-n64-screensize = "1440x1080"' "/storage/.config/retroarch/config/ParaLLEl N64/ParaLLEl N64.opt"
        fi

get_game_setting "parallel_n64_gamespeed"

        if [ "${EES}" == "original" ]
        then
                sed -i '/parallel-n64-framerate = /c\parallel-n64-framerate = "original"' "/storage/.config/retroarch/config/ParaLLEl N64/ParaLLEl N64.opt"
        fi

        if [ "${EES}" == "fullspeed" ]
        then
                sed -i '/parallel-n64-framerate = /c\parallel-n64-framerate = "fullspeed"' "/storage/.config/retroarch/config/ParaLLEl N64/ParaLLEl N64.opt"
        fi

get_game_setting "parallel_n64_gfx_accuracy"

        if [ "${EES}" == "low" ]
        then
                sed -i '/parallel-n64-gfxplugin-accuracy = /c\parallel-n64-gfxplugin-accuracy = "low"' "/storage/.config/retroarch/config/ParaLLEl N64/ParaLLEl N64.opt"
        fi

        if [ "${EES}" == "medium" ]
        then
                sed -i '/parallel-n64-gfxplugin-accuracy = /c\parallel-n64-gfxplugin-accuracy = "medium"' "/storage/.config/retroarch/config/ParaLLEl N64/ParaLLEl N64.opt"
        fi

		if [ "${EES}" == "high" ]
        then
                sed -i '/parallel-n64-gfxplugin-accuracy = /c\parallel-n64-gfxplugin-accuracy = "high"' "/storage/.config/retroarch/config/ParaLLEl N64/ParaLLEl N64.opt"
        fi

        if [ "${EES}" == "veryhigh" ]
        then
                sed -i '/parallel-n64-gfxplugin-accuracy = /c\parallel-n64-gfxplugin-accuracy = "veryhigh"' "/storage/.config/retroarch/config/ParaLLEl N64/ParaLLEl N64.opt"
        fi

get_game_setting "parallel_n64_controller_pak"

        if [ "${EES}" == "none" ]
        then
                sed -i '/parallel-n64-pak1 = /c\parallel-n64-pak1 = "none"' "/storage/.config/retroarch/config/ParaLLEl N64/ParaLLEl N64.opt"
        fi
        if [ "${EES}" == "memory" ]
        then
                sed -i '/parallel-n64-pak1 = /c\parallel-n64-pak1 = "memory"' "/storage/.config/retroarch/config/ParaLLEl N64/ParaLLEl N64.opt"
        fi
        if [ "${EES}" == "rumble" ]
        then
                sed -i '/parallel-n64-pak1 = /c\parallel-n64-pak1 = "rumble"' "/storage/.config/retroarch/config/ParaLLEl N64/ParaLLEl N64.opt"
        fi

##
## Settings for special cores
##

## atari800 core needs other settings when emulation atari5200
if [ "${CORE}" == "atari800" ]; then
	log $0 "Atari 800 section"
	ATARICONF="/storage/.config/system/configs/atari800.cfg"
	ATARI800CONF="/storage/.config/retroarch/config/Atari800/Atari800.opt"
	[[ ! -f "$ATARI800CONF" ]] && touch "$ATARI800CONF"

	sed -i "/atari800_system =/d" ${RACORECONF}
	sed -i "/RAM_SIZE=/d" ${ATARICONF}
	sed -i "/STEREO_POKEY=/d" ${ATARICONF}
	sed -i "/BUILTIN_BASIC=/d" ${ATARICONF}
	sed -i "/atari800_system =/d" ${ATARI800CONF}

	if [ "${PLATFORM}" == "atari5200" ]; then
		echo "atari800_system = \"5200\"" >> ${RACORECONF}
		echo "atari800_system = \"5200\"" >> ${ATARI800CONF}
		echo "RAM_SIZE=16" >> ${ATARICONF}
		echo "STEREO_POKEY=0" >> ${ATARICONF}
		echo "BUILTIN_BASIC=0" >> ${ATARICONF}
	else
		echo "atari800_system = \"800XL (64K)\"" >> ${RACORECONF}
		echo "atari800_system = \"800XL (64K)\"" >> ${ATARI800CONF}
		echo "RAM_SIZE=64" >> ${ATARICONF}
		echo "STEREO_POKEY=1" >> ${ATARICONF}
		echo "BUILTIN_BASIC=1" >> ${ATARICONF}
 	fi
fi

## Gambatte
if [ "${CORE}" == "gambatte" ]; then
	log $0 "Gambatte section"
	GAMBATTECONF="/storage/.config/retroarch/config/Gambatte/Gambatte.opt"
	if [ ! -f "$GAMBATTECONF" ]; then
		# set some defaults
		echo 'gambatte_gbc_color_correction = "disabled"' > ${GAMBATTECONF}
	else
		sed -i "/gambatte_gb_colorization =/d" ${GAMBATTECONF}
		sed -i "/gambatte_gb_internal_palette =/d" ${GAMBATTECONF}
	fi
	get_game_setting "renderer.colorization"
	if [ "${EES}" == "false" ] || [ "${EES}" == "auto" ] || [ "${EES}" == "none" ]; then
		echo "gambatte_gb_colorization = \"disabled\"" >> ${GAMBATTECONF}
	elif [ "${EES}" == "Best Guess" ]; then
		echo "gambatte_gb_colorization = \"auto\"" >> ${GAMBATTECONF}
	elif [ "${EES}" == "GBC" ] || [ "${EES}" == "SGB" ]; then
		echo "gambatte_gb_colorization = \"${EES}\"" >> ${GAMBATTECONF}
	else
		echo "gambatte_gb_colorization = \"internal\"" >> ${GAMBATTECONF}
		echo "gambatte_gb_internal_palette = \"${EES}\"" >> ${GAMBATTECONF}
	fi
fi

# We set up the controller index
#sed -i "/input_libretro_device_p1/d" ${RACONF}
CONTROLLERS="$@"
CONTROLLERS="${CONTROLLERS#*--controllers=*}"

for i in 1 2 3 4 5; do
log $0 "Controller section (${1})"
if [[ "$CONTROLLERS" == *p${i}* ]]; then
PINDEX="${CONTROLLERS#*-p${i}index }"
PINDEX="${PINDEX%% -p${i}guid*}"
#sed -i "/input_player${i}_joypad_index =/d" ${RACONF}
echo "input_player${i}_joypad_index = \"${PINDEX}\"" >> ${RAAPPENDCONF}

# Setting controller type for different cores
if [ "${PLATFORM}" == "atari5200" ]; then
	sed -i "/input_libretro_device_p${i}/d" ${RAAPPENDCONF}
	echo "input_libretro_device_p${i} = \"513\"" >> ${RAAPPENDCONF}
fi

fi
done

##
## Clean Exit
##
doexit
