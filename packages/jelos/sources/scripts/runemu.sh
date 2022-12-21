#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2020-present Fewtarius

# Source predefined functions and variables
. /etc/profile
. /etc/os-release

# Command line schema
# $1 = Game/Port
# $2 = Platform
# $3 = Core
# $4 = Emulator

### Define the variables used throughout the script
BTENABLED=$(get_setting bluetooth.enabled)
CFG="/storage/.emulationstation/es_settings.cfg"
VERBOSE=false
LOGSDIR="/var/log"
LOGFILE="exec.log"
TBASH="/usr/bin/bash"
RATMPCONF="/storage/.config/retroarch/retroarch.cfg"
RAAPPENDCONF="/tmp/raappend.cfg"
NETPLAY="No"
SHADERTMP="/tmp/shader"
OUTPUT_LOG="${LOGSDIR}/${LOGFILE}"
### Do not change the variables below as it may break things.
MYNAME=$(basename "$0")

### Enable logging
if [ "$(get_es_setting string LogLevel)" == "minimal" ]; then
    LOG=false
else
    LOG=true
	VERBOSE=true
fi

arguments="$@"
PLATFORM="${arguments##*-P}"  # read from -P onwards
PLATFORM="${PLATFORM%% *}"  # until a space is found
CORE="${arguments##*--core=}"  # read from --core= onwards
CORE="${CORE%% *}"  # until a space is found
EMULATOR="${arguments##*--emulator=}"  # read from --emulator= onwards
EMULATOR="${EMULATOR%% *}"  # until a space is found
ROMNAME="$1"
BASEROMNAME=${ROMNAME##*/}
GAMEFOLDER="${ROMNAME//${BASEROMNAME}}"


### Determine if we're running a Libretro core and append the libretro suffix
if [[ $EMULATOR = "retroarch" ]]; then
	EMU="${CORE}_libretro"
	RETROARCH="yes"
elif [[ $EMULATOR = "mupen64plussa" ]]; then
	EMU="M64P"
else
	EMU="${CORE}"
fi

# freej2me needs the JDK to be downloaded on the first run
if [[ ${EMU} == "freej2me_libretro" ]]; then
  /usr/bin/freej2me.sh
  JAVA_HOME='/storage/jdk'
  export JAVA_HOME
  PATH="$JAVA_HOME/bin:$PATH"
  export PATH
fi

# easyrpg needs runtime files to be downloaded on the first run
if [[ ${EMU} == "easyrpg_libretro" ]]; then
  /usr/bin/easyrpg.sh
fi

### If we're running a port, assume it's libretro
### Re-evaluate as not all ports may be libretro cores
### perhaps rewrite to use ^ functionality
[[ ${PLATFORM} = "ports" ]] && RETROARCH="yes"

# check if we started as host for a game
if [[ "$arguments" == *"--host"* ]]; then
	NETPLAY="${arguments##*--host}"  # read from --host onwards
	NETPLAY="${NETPLAY%%--nick*}"  # until --nick is found
	NETPLAY="--host $NETPLAY --nick"
fi

# check if we are trying to connect to a client on netplay
if [[ "$arguments" == *"--connect"* ]]; then
	NETPLAY="${arguments##*--connect}"  # read from --connect onwards
	NETPLAY="${NETPLAY%%--nick*}"  # until --nick is found
	NETPLAY="--connect $NETPLAY --nick"
fi

### Set the performance mode
PERFORMANCE_MODE=$(get_setting "cpugovernor" "${PLATFORM}" "${ROMNAME##*/}")
if [ ! "${PERFORMANCE_MODE}" = "auto" ]
then
  ${PERFORMANCE_MODE}
fi

### Set the cores to use
CORES=$(get_setting "cores" "${PLATFORM}" "${ROMNAME##*/}")
if [ "${CORES}" = "little" ]
then
  EMUPERF="${SLOW_CORES}"
elif [ "${CORES}" = "big" ]
then
  EMUPERF="${FAST_CORES}"
else
  ### All..
  unset EMUPERF
fi

### We need the original system cooling profile later so get it now!
COOLINGPROFILE=$(get_setting cooling.profile)

if [ -e "/usr/bin/overclock" ]
then
  ### Set the overclock mode
  OVERCLOCK=$(get_setting "overclock" "${PLATFORM}" "${ROMNAME##*/}")
  if [ ! "${OVERCLOCK}" = "system" ]
  then
    if [ ! -z "${OVERCLOCK}" ] && [ -e "/usr/bin/overclock" ]
    then
      /usr/bin/overclock ${OVERCLOCK}
    fi
  fi
fi

if [ "${DEVICE_HAS_FAN}" = "true" ]
then
  ### Set any custom fan profile (make this better!)
  GAMEFAN=$(get_setting "cooling.profile" "${PLATFORM}" "${ROMNAME##*/}")
  if [ ! -z "${GAMEFAN}" ]
  then
    set_setting cooling.profile ${GAMEFAN}
    systemctl restart fancontrol
  fi
fi

# Disable netplay by default
set_setting "netplay.client.ip" "disable"
set_setting "netplay.client.port" "disable"

### Function Library

function log() {
	if [ ${LOG} == true ]
	then
		if [[ ! -d "$LOGSDIR" ]]
		then
			mkdir -p "$LOGSDIR"
		fi
		echo "${MYNAME}: $1" 2>&1 | tee -a ${LOGSDIR}/${LOGFILE}
	else
		echo "${MYNAME}: $1"
	fi
}

function loginit() {
	if [ ${LOG} == true ]
	then
		if [ -e ${LOGSDIR}/${LOGFILE} ]
		then
			rm -f ${LOGSDIR}/${LOGFILE}
		fi
		cat <<EOF >${LOGSDIR}/${LOGFILE}
Emulation Run Log - Started at $(date)

ARG1: $1
ARG2: $2
ARG3: $3
ARG4: $4
ARGS: $*
PLATFORM: $PLATFORM
ROM NAME: ${ROMNAME}
BASE ROM NAME: ${ROMNAME##*/}
USING CONFIG: ${RATMPCONF}
USING APPENDCONFIG : ${RAAPPENDCONF}

EOF
	else
		log "Emulation Run Log - Started at $(date)"
	fi
}

function quit() {
	$VERBOSE && log "Cleaning up and exiting"
	bluetooth enable
	jslisten stop
	clear_screen
	DEVICE_CPU_GOVERNOR=$(get_setting system.cpugovernor)
	${DEVICE_CPU_GOVERNOR}
	set_audio default
	exit $1
}

function clear_screen() {
	$VERBOSE && log "Clearing screen"
	clear
}

function bluetooth() {
	if [ "$1" == "disable" ]
	then
		$VERBOSE && log "Disabling BT"
		if [[ "$BTENABLED" == "1" ]]
		then
			NPID=$(pgrep -f batocera-bluetooth-agent)
			if [[ ! -z "$NPID" ]]; then
				kill "$NPID"
			fi
		fi
	elif [ "$1" == "enable" ]
	then
		$VERBOSE && log "Enabling BT"
		if [[ "$BTENABLED" == "1" ]]
		then
			systemd-run batocera-bluetooth-agent
		fi
	fi
}

### Main Screen Turn On

loginit "$1" "$2" "$3" "$4"
clear_screen
bluetooth disable
jslisten stop

### Per emulator/core configurations
if [ -z ${RETROARCH} ]
then
	$VERBOSE && log "Configuring for a non-libretro emulator"
	case ${PLATFORM} in
		"setup")
				RUNTHIS='${TBASH} "${ROMNAME}"'
		;;
		"nds")
			jslisten set "drastic"
			RUNTHIS='${TBASH} /usr/bin/start_drastic.sh "${ROMNAME}"'
		;;
		"solarus")
			if [ "$EMU" = "solarus" ]
			then
				jslisten set "solarus-run"
				RUNTHIS='${TBASH} /usr/bin/solarus.sh "${ROMNAME}"'
			fi
		;;
		"n64")
			jslisten set "mupen64plus"
			if [ "$EMU" = "M64P" ]
			then
				RUNTHIS='${TBASH} /usr/bin/m64p.sh "${CORE}" "${ROMNAME}"'
			fi
		;;
		"pc")
			jslisten set "dosbox dosbox-x"
			if [ "$EMU" = "DOSBOXSDL2" ]
			then
				RUNTHIS='${TBASH} /usr/bin/dosbox.start -conf "${GAMEFOLDER}dosbox-SDL2.conf"'
			elif [ "$EMU" = "DOSBOX-X" ]
			then
				RUNTHIS='${TBASH} /usr/bin/dosbox-x.start -conf "${GAMEFOLDER}dosbox-SDL2.conf"'
			fi
		;;
		"neocd")
			jslisten set "retroarch"
			if [ "$EMU" = "fbneo" ]
			then
				RUNTHIS='/usr/bin/retroarch -L /tmp/cores/fbneo_libretro.so --subsystem neocd --config ${RATMPCONF} --appendconfig ${RAAPPENDCONF} "${ROMNAME}"'
			fi
		;;
		"psx")
                        jslisten set "duckstation-nogui"
		        if [ "$EMU" = "duckstationsa" ]; then
            		RUNTHIS='${TBASH} /usr/bin/start_duckstation.sh "${ROMNAME}"'
        		fi
                ;;
                "ps2")
                        jslisten set "-9 pcsx2"
                        if [ "$EMU" = "pcsx2sa" ]; then
                        RUNTHIS='${TBASH} /usr/bin/start_pcsx2.sh "${ROMNAME}"'
                        fi
                ;;
                "gamecube")
                        jslisten set "-9 dolphin-emu-nogui"
                        if [ "$EMU" = "dolphinsa-gc" ]; then
                        RUNTHIS='${TBASH} /usr/bin/start_dolphin_gc.sh "${ROMNAME}"'
                        elif [ "$EMU" = "primehack" ]; then
                        RUNTHIS='${TBASH} /usr/bin/start_primehack.sh "${ROMNAME}"'
                        fi

                ;;
                "wii")
                        jslisten set "-9 dolphin-emu-nogui"
                        if [ "$EMU" = "dolphinsa-wii" ]; then
                        RUNTHIS='${TBASH} /usr/bin/start_dolphin_wii.sh "${ROMNAME}"'
                        elif [ "$EMU" = "primehack" ]; then
                        RUNTHIS='${TBASH} /usr/bin/start_primehack.sh "${ROMNAME}"'
                        fi
                ;;
                "switch")
                        jslisten set "-9 yuzu-cmd"
                        if [ "$EMU" = "yuzu" ]; then
                        RUNTHIS='${TBASH} /usr/bin/start_yuzu.sh "${ROMNAME}"'
                        fi
                ;;
		"mplayer")
			jslisten set "mpv"
			RUNTHIS='${TBASH} /usr/bin/mpv_video.sh "${ROMNAME}"'
		;;
		"shell")
			RUNTHIS='${TBASH} "${ROMNAME}"'
		;;
		*)
			jslisten set "${CORE}"
			RUNTHIS='${TBASH} "start_${CORE}.sh" "${ROMNAME}"'
		esac
else
	$VERBOSE && log "Configuring for a libretro core"

	### Set jslisten to kill the appropriate retroarch
	jslisten set "retroarch retroarch32"

	RABIN="retroarch"
	if [[ "${HW_ARCH}" =~ aarch64 ]]
	then
		### Check if we need retroarch 32 bits or 64 bits
		if [[ "${CORE}" =~ pcsx_rearmed32 ]] || \
	           [[ "${CORE}" =~ parallel_n64 ]] || \
	           [[ "${CORE}" =~ gpsp ]] || \
	           [[ "${CORE}" =~ flycast32 ]]
		then
                        export LIBGL_DRIVERS_PATH="/usr/lib32/dri"
                        export LD_LIBRARY_PATH="/usr/lib32"
			export RABIN="retroarch32"
		fi
	fi

	# Platform specific configurations
        case ${PLATFORM} in
                "doom")
			# EXT can be wad, WAD, iwad, IWAD, pwad, PWAD or doom
			EXT=${ROMNAME##*.}

			# If its not a simple wad (extension .doom) read the file and parse the data
			if [ ${EXT} == "doom" ]; then
			  dos2unix "${1}"
			  while IFS== read -r key value; do
			    if [ "$key" == "IWAD" ]; then
			      ROMNAME="$value"
			    fi
			    done < "${1}"
			fi
                ;;
				"quake")
			# EXT can only by quake
			EXT=${ROMNAME##*.}

			# If its not a simple pak (extension .pak0) read the file and parse the data
			if [ ${EXT} == "quake" ]; then
			  dos2unix "${1}"
			  while IFS== read -r key value; do
			    if [ "$key" == "PAK" ]; then
			      ROMNAME="$value"
			    fi
			    done < "${1}"
			fi
                ;;
        esac
	
	if [[ "${CORE}" =~ "custom" ]] 
	then
	RUNTHIS='${EMUPERF} /usr/bin/${RABIN} -L /storage/.config/retroarch/cores/${EMU}.so --config ${RATMPCONF} --appendconfig ${RAAPPENDCONF} "${ROMNAME}"'
	else
	RUNTHIS='${EMUPERF} /usr/bin/${RABIN} -L /tmp/cores/${EMU}.so --config ${RATMPCONF} --appendconfig ${RAAPPENDCONF} "${ROMNAME}"'
	fi
	CONTROLLERCONFIG="${arguments#*--controllers=*}"

	if [[ "$arguments" == *"-state_slot"* ]]; then
		CONTROLLERCONFIG="${CONTROLLERCONFIG%% -state_slot*}"  # until -state is found
		SNAPSHOT="${arguments#*-state_slot *}" # -state_slot x
		SNAPSHOT="${SNAPSHOT%% -*}"
		if [[ "$arguments" == *"-autosave"* ]]; then
			CONTROLLERCONFIG="${CONTROLLERCONFIG%% -autosave*}"  # until -autosave is found
			AUTOSAVE="${arguments#*-autosave *}" # -autosave x
			AUTOSAVE="${AUTOSAVE%% -*}"
		else
			AUTOSAVE=""
		fi
	else
		CONTROLLERCONFIG="${CONTROLLERCONFIG%% --*}"  # until a -- is found
		SNAPSHOT=""
		AUTOSAVE=""
	fi

#	CORE=${EMU%%_*}

	### Configure netplay
	if [[ ${NETPLAY} != "No" ]]; then
		NETPLAY_NICK=$(get_setting netplay.nickname)
		[[ -z "$NETPLAY_NICK" ]] && NETPLAY_NICK="${uuidgen | awk 'BEGIN {FS="-"} {print toupper($1)}'}"
		set_setting netplay.nickname ${NETPLAY_NICK}

		if [[ "${NETPLAY}" == *"connect"* ]]; then
			NETPLAY_PORT="${arguments##*--port }"  # read from -netplayport  onwards
			NETPLAY_PORT="${NETPLAY_PORT%% *}"  # until a space is found
			NETPLAY_IP="${arguments##*--connect }"  # read from -netplayip  onwards
			NETPLAY_IP="${NETPLAY_IP%% *}"  # until a space is found
			set_setting "netplay.client.ip" "${NETPLAY_IP}"
			set_setting "netplay.client.port" "${NETPLAY_PORT}"
			RUNTHIS=$(echo ${RUNTHIS} | sed "s|--config|--connect ${NETPLAY_IP}\|${NETPLAY_PORT} --nick ${NETPLAY_NICK} --config|")
		else
			RUNTHIS=$(echo ${RUNTHIS} | sed "s|--config|${NETPLAY} --nick ${NETPLAY_NICK} --config|")
		fi

	fi

	# Platform specific configurations
        case ${PLATFORM} in
                "atomiswave")
                        rm ${ROMNAME}.nvmem*
                ;;
                "ports")
                        PORTCORE="${arguments##*-C}"  # read from -C onwards
                        EMU="${PORTCORE%% *}_libretro"  # until a space is found
                        PORTSCRIPT="${arguments##*-SC}"  # read from -SC onwards
                ;;
                "scummvm")
			GAMEDIR=$(cat "${ROMNAME}" | awk 'BEGIN {FS="\""}; {print $2}')
			cd "${GAMEDIR}"
			RUNTHIS='${TBASH} /usr/bin/scummvm.start libretro .'
                ;;
        esac
fi

if [ -e "${SHADERTMP}" ]
then
	rm -f "${SHADERTMP}"
fi

if [[ ${PLATFORM} == "ports" ]]; then
	(/usr/bin/setsettings.sh "${PLATFORM}" "${PORTSCRIPT}" "${CORE}" --controllers="${CONTROLLERCONFIG}" --autosave="${AUTOSAVE}" --snapshot="${SNAPSHOT}" >${SHADERTMP}) &
else
	(/usr/bin/setsettings.sh "${PLATFORM}" "${ROMNAME}" "${CORE}" --controllers="${CONTROLLERCONFIG}" --autosave="${AUTOSAVE}" --snapshot="${SNAPSHOT}" >${SHADERTMP}) &
fi
SETSETTINGS_PID=$!

clear_screen

### Wait for background jobs to complete before continuing.
wait ${SETSETTINGS_PID}  #Don't wait for show splash

### If setsettings wrote data in the background, grab it and assign it to SHADERSET
if [ -e "${SHADERTMP}" ]
then
	SHADERSET=$(cat ${SHADERTMP})
	rm -f ${SHADERTMP}
	$VERBOSE && log "Shader set to ${SHADERSET}"
fi

if [[ ${SHADERSET} != 0 ]]; then
	RUNTHIS=$(echo ${RUNTHIS} | sed "s|--config|${SHADERSET} --config|")
fi

clear_screen
$VERBOSE && log "executing game: ${ROMNAME}"
$VERBOSE && log "script to execute: ${RUNTHIS}"
# If the rom is a shell script just execute it, useful for DOSBOX and ScummVM scan scripts
if [[ "${ROMNAME}" == *".sh" ]]; then
	$VERBOSE && log "Executing shell script ${ROMNAME}"
	"${ROMNAME}" &>>${OUTPUT_LOG}
        ret_error=$?
else
	$VERBOSE && log "Executing $(eval echo ${RUNTHIS})"
	eval ${RUNTHIS} &>>${OUTPUT_LOG}
	ret_error=$?
fi

clear_screen

### Restore the overclock mode
if [ -e "/usr/bin/overclock" ]
then
	OVERCLOCK=$(get_setting "system.overclock")
	if [ ! -z "${OVERCLOCK}" ]
	then
		/usr/bin/overclock ${OVERCLOCK}
		if [ "${DEVICE_HAS_FAN}" = "true" ]
		then
			set_setting cooling.profile ${COOLINGPROFILE}
			systemctl restart fancontrol
		fi
	fi
fi

### Backup save games
CLOUD_BACKUP=$(get_setting "cloud.backup")
if [ "${CLOUD_BACKUP}" = "1" ]
then
  INETUP=$(/usr/bin/amionline >/dev/null 2>&1)
  if [ $? == 0 ]
  then
    log "backup saves to the cloud."
    run /usr/bin/cloud_backup
  fi
fi

$VERBOSE && log "Checking errors: ${ret_error} "
if [ "${ret_error}" == "0" ]
then
	quit 0
else
	log "exiting with $ret_error"

	# Check for missing bios if needed
	REQUIRESBIOS=(atari5200 atari800 atari7800 atarilynx colecovision amiga amigacd32 o2em intellivision pcengine pcenginecd pcfx fds segacd saturn dreamcast naomi atomiswave x68000 neogeo neogeocd msx msx2 sc-3000)

	(for e in "${REQUIRESBIOS[@]}"; do [[ "${e}" == "${PLATFORM}" ]] && exit 0; done) && RB=0 || RB=1
	if [ $RB == 0 ]; then
		CBPLATFORM="${PLATFORM}"
		[[ "${CBPLATFORM}" == "msx2" ]] && CBPLATFORM="msx"
		[[ "${CBPLATFORM}" == "pcenginecd" ]] && CBPLATFORM="pcengine"
		[[ "${CBPLATFORM}" == "amigacd32" ]] && CBPLATFORM="amiga"
		check_bios "${CBPLATFORM}" "${CORE}" "${EMULATOR}" "${ROMNAME}" "${LOGSDIR}/${LOGFILE}"
	fi
	quit 1
fi

