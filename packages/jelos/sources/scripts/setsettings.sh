#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present Fewtarius

. /etc/profile

###
### System configuration variables
###

SYSTEM_CONFIG="/storage/.config/system/configs/system.cfg"
RETROARCH_CONFIG="/storage/.config/retroarch/retroarch.cfg"
RETROARCH_TEMPLATE="/usr/config/retroarch/retroarch.cfg"

ROMS_DIR="/storage/roms"
SNAPSHOTS="${ROMS_DIR}/savestates"

TMP_CONFIG="/tmp/.retroarch.cfg"
LOG_DIR="/var/log"
LOG_FILE="exec.log"
LOCK_FILE="/tmp/.retroarch.lock"

###
### Variables parsed from the command line
###

PLATFORM=${1,,}
ROM="${2##*/}"
CORE=${3,,}

#Autosave
AUTOSAVE="$@"
AUTOSAVE="${AUTOSAVE#*--autosave=*}"
AUTOSAVE="${AUTOSAVE% --*}"

#Snapshot
SNAPSHOT="$@"
SNAPSHOT="${SNAPSHOT#*--snapshot=*}"

###
### Arrays containing various supported/non-supported attributes.
###

declare -a HAS_CHEEVOS=(    arcade
                            atari2600
                            atari7800
                            atarilynx
                            colecovision
                            famicom
                            fbn
                            fds
                            gamegear
                            gb
                            gba
                            gbah
                            gbc
                            gbch
                            gbh
                            genesis
                            genh
                            ggh
                            intellivision
                            mastersystem
                            megacd
                            megadrive
                            megadrive-japan
                            msx
                            msx2
                            n64
                            neogeo
                            neogeocd
                            nes
                            nesh
                            ngp
                            ngpc
                            odyssey2
                            pcengine
                            pcenginecd
                            pcfx
                            pokemini
                            psp
                            psx
                            sega32x
                            segacd
                            sfc
                            sg-1000
                            snes
                            snesh
                            snesmsu1
                            supergrafx
                            supervision
                            tg16
                            tg16cd
                            vectrex
                            virtualboy
                            wonderswan
                            wonderswancolor
)

declare -a NO_REWIND=(  atomiswave
                        dreamcast
                        mame
                        n64
                        naomi
                        neogeocd
                        odyssey2
                        psp
                        pspminis
                        psx
                        saturn
                        sega32x
                        zxspectrum
)

declare -a NO_RUNAHEAD=(    atomiswave
                            dreamcast
                            n64
                            naomi
                            neogeocd
                            psp
                            saturn
                            sega32x
)

declare -a NO_ANALOG=(  dreamcast
                        n64
                        psp
                        pspminis
                        psx
                        wonderswan
                        wonderswancolor
)

declare -a IS_32BIT=(   gpsp
                        pcsx_rearmed
)

declare -a CORE_RATIOS=(    4/3
                            16/9
                            16/10
                            16/15
                            21/9
                            1/1
                            2/1
                            3/2
                            3/4
                            4/1
                            9/16
                            5/4
                            6/5
                            7/9
                            8/3
                            8/7
                            19/12
                            19/14
                            30/17
                            32/9
                            config
                            squarepixel
                            core
                            custom
                            full
)

declare -a LANG_CODES=( ["false"]="0"
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

###
### Fetch common settings
###

LOGGING=$(get_setting system.loglevel)

###
### Set up
###

### Create log directory if it doesn't exist
if [ ! -d "${LOG_DIR}" ]
then
    mkdir -p ${LOG_DIR}
fi

if [ -e "${LOCK_FILE}" ]
then
  rm -f "${LOCK_FILE}"
fi

### Copy the retroarch config file for editing
if [ -f "${TMP_CONFIG}" ]
then
  rm -f "${TMP_CONFIG}"
fi

###
### Core functions
###

function log() {
    if [ ${LOGGING} = "verbose" ]
    then
        echo "$(printf '%(%c)T\n' -1): setsettings: $*" >> ${LOG_DIR}/${LOG_FILE} 2>&1
    fi
}

function cleanup() {
    log "Work complete"
    sync
    exit
}

function game_setting() {
    if [ -n "${1}" ]
    then
        SETTING=$(get_setting "${1}" "${PLATFORM}" "${ROM}")
        log "Fetch \"${1}\" \"${PLATFORM}\" \"${ROM}\"] (${SETTING})"
        echo ${SETTING}
    fi
}

function clear_setting() {
      log "Remove setting [${1}]"
      sed -i "/^${1}/d" ${RETROARCH_CONFIG} >/dev/null 2>&1
}

function add_setting() {
    if [ ! "${1}" = "none" ]
    then
        local OS_SETTING="$(game_setting ${1})"
    fi
    local RETROARCH_KEY="${2}"
    local RETROARCH_VALUE="${3}"
    if [ -z "${RETROARCH_VALUE}" ]& \
       [ ! "${1}" = "none" ]
    then
            case ${OS_SETTING} in
            0|false|none)
                RETROARCH_VALUE="false"
            ;;
            1|true)
                RETROARCH_VALUE="true"
            ;;
            *)
                RETROARCH_VALUE="${OS_SETTING}"
            ;;
        esac
    fi
    clear_setting "${RETROARCH_KEY}"
    echo "${RETROARCH_KEY} = \"${RETROARCH_VALUE}\"" >>${TMP_CONFIG}
    log "Added setting: ${RETROARCH_KEY} = \"${RETROARCH_VALUE}\""
}

function match() {
    local seek="${1}"
    shift
    local myarray=(${@})
    if [[ "${myarray[*]}" =~ ${seek} ]]
    then
        local MATCH="1"
    else
        local MATCH="0"
    fi
    log "Match: [${seek}] [${MATCH}] (${myarray[*]})"
    echo ${MATCH}
}

###
### Game data functions
###

### Configure retroarch hotkeys
function configure_hotkeys() {
    log "Configure hotkeys..."
    local MY_CONTROLLER=$(cat /storage/.controller)
    if [ "$(get_setting system.autohotkeys)" == "1" ]
    then
        if [ -e "/tmp/joypads/${MY_CONTROLLER}.cfg" ]
        then
            cp /tmp/joypads/"${MY_CONTROLLER}.cfg" /tmp
            sed -i "s# = #=#g" /tmp/"${MY_CONTROLLER}.cfg"
            source /tmp/"${MY_CONTROLLER}.cfg"
            for HKEYSETTING in input_enable_hotkey_btn input_bind_hold      \
                               input_exit_emulator_btn input_fps_toggle_btn \
                               input_menu_toggle_btn input_save_state_btn   \
                               input_load_state_btn
            do
                clear_setting "${HKEYSETTING}"
            done
            cat <<EOF >>${RETROARCH_CONFIG}
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
}

function set_ra_menudriver() {
    add_setting "retroarch.menu_driver" "menu_driver"
    local MENU_DRIVER=$(game_setting retroarch.menu_driver)
    case ${MENU_DRIVER} in
        rgui)
            add_setting "none" "menu_linear_filter" "true"
        ;;
    esac
}

function set_fps() {
    add_setting "showFPS" "fps_show"
}

function set_cheevos() {
    local USE_CHEEVOS=$(game_setting "retroachievements")
    local CHECK_CHEEVOS="$(match "${PLATFORM}" "${HAS_CHEEVOS[@]}")"
    if [ "${USE_CHEEVOS}" = 1 ]& \
       [ "${CHECK_CHEEVOS}" = 1 ]
    then
        add_setting "none" "cheevos_enable" "true"
        add_setting "retroachievements.username" "cheevos_username"
        add_setting "retroachievements.password" "cheevos_password"
        add_setting "retroachievements.hardcore" "cheevos_hardcore_mode_enable"
        add_setting "retroachievements.leaderboards" "cheevos_leaderboards_enable"
        add_setting "retroachievements.verbose" "cheevos_verbose_enable"
        add_setting "retroachievements.screenshot" "cheevos_auto_screenshot"
        add_setting "retroachievements.richpresence" "cheevos_richpresence_enable"
        add_setting "retroachievements.challengeindicators" "cheevos_challenge_indicators"
        add_setting "retroachievements.testunofficial" "cheevos_test_unofficial"
        add_setting "retroachievements.badges" "cheevos_badges_enable"
        add_setting "retroachievements.active" "cheevos_start_active"
        add_setting "retroachievements.soundenable" "cheevos_unlock_sound_enable"
    else
        add_setting "none" "cheevos_enable" "false"
    fi
}

function set_netplay() {
    local USE_NETPLAY=$(game_setting "netplay")
    if [ "${USE_NETPLAY}" = 1 ]
    then
        add_setting "retroachievements.hardcore" "cheevos_hardcore_mode_enable" "false"
        add_setting "netplay.frames" "netplay_delay_frames"
        add_setting "netplay.nickname" "netplay_nickname"
        add_setting "netplay.spectator" "netplay_spectator_mode_enable"
        add_setting "netplay_public_announce" "netplay_public_announce"
        local NETPLAY_MODE=$(game_setting "netplay.mode")
        case ${NETPLAY_MODE} in
            host)
                add_setting "none" "netplay_mode" "false"
                add_setting "none" "netplay_client_swap_input" "false"
                add_setting "netplay.port" "netplay_ip_port"
            ;;
            client)
                add_setting "none" "netplay_mode" "true"
                add_setting "none" "netplay_client_swap_input" "true"
                add_setting "netplay.client.ip" "netplay_ip_address"
                add_setting "netplay.client.port" "netplay_ip_port"
            ;;
        esac
        local NETPLAY_RELAY=$(game_setting netplay.relay)
        case $(NETPLAY_RELAY) in
            none|false|0)
                add_setting "none" "netplay_use_mitm_server" "false"
            ;;
            *)
                add_setting "none" "netplay_use_mitm_server" "true"
                add_setting "none" "netplay_mitm_server" "${NETPLAY_RELAY}"
            ;; 
        esac
    else
        add_setting "none" "netplay" "false"
    fi
}

function set_translation() {
    local USE_AI_SERVICE="$(game_setting ai_service_enabled)"
    case ${USE_AI_SERVICE} in
        0|false|none)
            add_setting "none" "ai_service_enable" "false"
        ;;
        *)
            add_setting "none" "ai_service_enable" "true"
            local AI_LANG="$(game_setting ai_target_lang)"
            local AI_URL="$(game_setting ai_service_url)"
            case ${AI_URL} in
              0|false|none)
                add_setting "none" "ai_service_url" "http://ztranslate.net/service?api_key=BATOCERA&mode=Fast&output=png&target_lang=${AI_LANG}"
              ;;
              *)
                add_setting "none" "ai_service_url" "${AI_URL}&mode=Fast&output=png&target_lang=${AI_LANG}"
              ;;
            esac
        ;;
    esac
}

function set_aspectratio() {
    local ASPECT_RATIO="$(game_setting ratio)"
    case ${ASPECT_RATIO} in
      0|false|none)
        add_setting "none" "aspect_ratio_index" "22"
      ;;
      *)
        for AR in ${!CORE_RATIOS[@]}
        do
            log "Test [${ASPECT_RATIO}] (${CORE_RATIOS[${AR}]}) (${AR})"
            if [ "${CORE_RATIOS[${AR}]}" = "${ASPECT_RATIO}" ]
            then
                log "Find aspect ratio [${ASPECT_RATIO}] (${CORE_RATIOS[${AR}]})"
                add_setting "none" "aspect_ratio_index" "${AR}"
                break
            fi
        done
      ;;
    esac
}

function set_filtering() {
    add_setting "smooth" "video_smooth"
}

function set_integerscale() {
    add_setting "integerscale" "video_scale_integer"
}

function set_rgascale() {
    add_setting "rgascale" "video_ctx_scaling"
}

function set_shader() {
    local SHADER="$(game_setting shaderset)"
    case ${SHADER} in
        0|false|none)
            add_setting "none" "video_shader_enable" "false"
        ;;
        *)
            add_setting "none" "video_shader_enable" "true"
            add_setting "none" "video_shader" "${SHADER}"
            echo "--set-shader /tmp/shaders/${SHADER}"
        ;;
    esac
}

function set_filter() {
    local FILTER="$(game_setting filterset)"
    case ${FILTER} in
        0|false|none)
            add_setting "none" "video_filter" ""
        ;;
        *)
            local FILTER_PATH="/usr/share/retroarch/filters"
            add_setting "none" "video_ctx_scaling" "false"
            local CHECK_BITNESS="$(match ${CORE} ${IS_32BIT[@]})"
            if [ "${CHECK_BITNESS}" = 1 ]
            then
                BITS="32"
            else
                BITS="64"
            fi
                add_setting "none" "video_filter" "${FILTER_PATH}/${BITS}bit/video/${FILTER}"
                add_setting "none" "video_filter_dir" "${FILTER_PATH}/${BITS}bit/video/"
                add_setting "none" "audio_filter_dir" "${FILTER_PATH}/${BITS}bit/audio"
        ;;
    esac
}

function set_rewind() {
    local REWIND="$(game_setting rewind)"
    local HAS_REWIND="$(match ${CORE} ${NO_REWIND[@]})"
    case ${HAS_REWIND} in
        0)
            add_setting "none" "rewind_enable" "false"
        ;;
        *)
            add_setting "none" "rewind_enable" "true"
        ;;
    esac
}

function set_savestates() {
    local SAVESTATES="$(game_setting incrementalsavestates)"
    case ${SAVESTATES} in
        0|false|none)
            add_setting "none" "savestate_auto_index" "false"
            add_setting "none" "savestate_max_keep" "50"
        ;;
        *)
            add_setting "none" "savestate_auto_index" "true"
            add_setting "none" "savestate_max_keep" "0"
        ;;
    esac
}

function set_autosave() {
    local CHKAUTOSAVE="$(game_setting autosave)"
    local SETLOADSTATE=false
    local SETSAVESTATE=false
    case ${CHKAUTOSAVE} in
        [1-3])
            log "Autosave enabled (${CHKAUTOSAVE})"
            add_setting "none" "savestate_directory" "${SNAPSHOTS}/${PLATFORM}"
            case ${AUTOSAVE} in
                1)
                    log "Autosave active (${AUTOSAVE})"
                    SETSAVESTATE="true"
                    if [ ! -z "${SNAPSHOT}" ]
                    then
                        log "Autosave snapshot enabled (${SNAPSHOT})"
                        add_setting "none" "state_slot" "${SNAPSHOT}"
                        SETLOADSTATE="true"
                    else
                        SETLOADSTATE="false"
                    fi
                ;;
            esac
        ;;
    esac
    add_setting "none" "savestate_auto_load" "${SETLOADSTATE}"
    add_setting "none" "savestate_auto_save" "${SETSAVESTATE}"
}

function set_runahead() {
    local RUNAHEAD="$(game_setting runahead)"
    local HAS_RUNAHEAD="$(match ${PLATFORM} ${NO_RUNAHEAD[@]})"
    case ${HAS_RUNAHEAD} in
        0|false|none)
            add_setting "none" "run_ahead_enabled" "false"
            add_setting "none" "run_ahead_frames" "1"
        ;;
        *)
            add_setting "none" "run_ahead_enabled" "true"
            add_setting "none" "run_ahead_frames" "${RUNAHEAD}"
            add_setting "secondinstance" "run_ahead_secondary_instance"
        ;;
    esac
}

function set_audiolatency() {
    add_setting "audiolatency" "audio_latency"
}

function set_analogsupport() {
    local HAS_ANALOG="$(match ${PLATFORM} ${NO_ANALOG[@]})"
    case ${HAS_ANALOG} in
        0|false|none)
            add_setting "none" "input_player1_analog_dpad_mode" "0"
        ;;
        *)
            add_setting "analogue" "input_player1_analog_dpad_mode"
        ;;
    esac
}

function set_tatemode() {
    log "Setup tate mode..."
    local TATEMODE="$(game_setting tatemode)"
    local MAME2003DIR="/storage/.config/retroarch/config/MAME 2003-Plus"
    local MAME2003REMAPDIR="/storage/remappings/MAME 2003-Plus"
    if [ ! -d "${MAME2003DIR}" ]
    then
            mkdir -p "${MAME2003DIR}"
    fi
    if [ ! -d "${MAME2003REMAPDIR}" ]
    then
            mkdir -p "${MAME2003REMAPDIR}"
    fi
    case ${TATEMODE} in
        0|false|none)
            if [ -e "${MAME2003DIR}/MAME 2003-Plus.opt" ]
            then
                sed -i 's#mame2003-plus_tate_mode.*$#mame2003-plus_tate_mode = "disabled"#' "${MAME2003DIR}/MAME 2003-Plus.opt" 2>/dev/null
            fi
            if [ -e "${MAME2003REMAPDIR}/MAME 2003-Plus.rmp" ]
            then
                rm -f "${MAME2003REMAPDIR}/MAME 2003-Plus.rmp"
            fi  
        ;;
        *)
            cp "/usr/config/retroarch/TATE-MAME 2003-Plus.rmp" "${MAME2003REMAPDIR}/MAME 2003-Plus.rmp"
            if [ "$(grep mame2003-plus_tate_mode "${MAME2003DIR}/MAME 2003-Plus.opt" > /dev/null 2>&1)" ]
            then
                sed -i 's#mame2003-plus_tate_mode.*$#mame2003-plus_tate_mode = "enabled"#' "${MAME2003DIR}/MAME 2003-Plus.opt" 2>/dev/null
            else
                echo 'mame2003-plus_tate_mode = "enabled"' > "${MAME2003DIR}/MAME 2003-Plus.opt"
            fi
        ;;
    esac
}

function set_n64opts() {
    log "Set up N64..."
    local PARALLELN64DIR="/storage/.config/retroarch/config/ParaLLEl N64"
    if [ ! -d "${PARALLELN64DIR}" ]
    then
        mkdir -p "${PARALLELN64DIR}"
    fi

    if [ ! -f "${PARALLELN64DIR}/ParaLLEl N64.opt" ]
    then
        cp "/usr/config/retroarch/ParaLLEl N64.opt" "${PARALLELN64DIR}/ParaLLEl N64.opt"
    fi
    local VIDEO_CORE="$(game_setting parallel_n64_video_core)"
    sed -i '/parallel-n64-gfxplugin = /c\parallel-n64-gfxplugin = "'${VIDEO_CORE}'"' "${PARALLELN64DIR}/ParaLLEl N64.opt"
    local SCREENSIZE="$(game_setting parallel_n64_internal_resolution)"
    sed -i '/parallel-n64-screensize = /c\parallel-n64-screensize = "'${SCREENSOZE}'"' "${PARALLELN64DIR}/ParaLLEl N64.opt"
    local GAMESPEED="$(game_setting parallel_n64_gamespeed)"
    sed -i '/parallel-n64-framerate = /c\parallel-n64-framerate = "'${GAMESPEED}'"' "${PARALLELN64DIR}/ParaLLEl N64.opt"
    local ACCURACY="$(game_setting parallel_n64_gfx_accuracy)"
    sed -i '/parallel-n64-gfxplugin-accuracy = /c\parallel-n64-gfxplugin-accuracy = "'${ACCURACY}'"' "${PARALLELN64DIR}/ParaLLEl N64.opt"
    local CONTROLLERPAK="$(game_setting parallel_n64_controller_pak)"
    sed -i '/parallel-n64-pak1 = /c\parallel-n64-pak1 = "'${CONTROLLERPAK}'"' "${PARALLELN64DIR}/ParaLLEl N64.opt"
}

function set_atari() {
    log "Set up Atari (FIXME)..."
    if [ "${CORE}" = "atari800" ]
    then
        ATARICONF="/storage/.config/system/configs/atari800.cfg"
        ATARI800CONF="/storage/.config/retroarch/config/Atari800/Atari800.opt"
        if [ ! -f "$ATARI800CONF" ]
        then
            touch "$ATARI800CONF"
        fi
        sed -i "/RAM_SIZE=/d" ${ATARICONF}
        sed -i "/STEREO_POKEY=/d" ${ATARICONF}
        sed -i "/BUILTIN_BASIC=/d" ${ATARICONF}
        sed -i "/atari800_system =/d" ${ATARI800CONF}

        if [ "${PLATFORM}" == "atari5200" ]; then
            add_setting "none" "atari800_system" "5200"
            echo "atari800_system = \"5200\"" >> ${ATARI800CONF}
            echo "RAM_SIZE=16" >> ${ATARICONF}
            echo "STEREO_POKEY=0" >> ${ATARICONF}
            echo "BUILTIN_BASIC=0" >> ${ATARICONF}
        else
            add_setting "none" "atari800_system" "800XL (64K)"
            echo "atari800_system = \"800XL (64K)\"" >> ${ATARI800CONF}
            echo "RAM_SIZE=64" >> ${ATARICONF}
            echo "STEREO_POKEY=1" >> ${ATARICONF}
            echo "BUILTIN_BASIC=1" >> ${ATARICONF}
        fi
    fi
}

function set_gambatte() {
    log "Set up Gambatte (FIXME)..."
    if [ "${CORE}" = "gambatte" ]
    then
        GAMBATTECONF="/storage/.config/retroarch/config/Gambatte/Gambatte.opt"
        if [ ! -f "GAMBATTECONF" ]
        then
            echo 'gambatte_gbc_color_correction = "disabled"' > ${GAMBATTECONF}
        else
            sed -i "/gambatte_gb_colorization =/d" ${GAMBATTECONF}
            sed -i "/gambatte_gb_internal_palette =/d" ${GAMBATTECONF}
        fi
        local RENDERER=$(game_setting renderer.colorization)
        case ${RENDERER} in
            0|false|none)
                echo 'gambatte_gb_colorization = "disabled"' >> ${GAMBATTECONF}
            ;;
            "Best Guess")
                echo 'gambatte_gb_colorization = "auto"' >> ${GAMBATTECONF}
            ;;
            GBC|SGB)
                echo 'gambatte_gb_colorization = "'${RENDERER}'"' >> ${GAMBATTECONF}
            ;;
            *)
                echo 'gambatte_gb_colorization = "internal"' >> ${GAMBATTECONF}
                echo 'gambatte_gb_internal_palette = "'${RENDERER}'"' >> ${GAMBATTECONF}
            ;;
        esac
    fi
}

function set_controllers() {
    CONTROLLERS="$@"
    CONTROLLERS="${CONTROLLERS#*--controllers=*}"

    for i in $(seq 1 1 5)
    do
        log "Controller setup (${1})"
        if [[ "$CONTROLLERS" == *p${i}* ]]
        then
            PINDEX="${CONTROLLERS#*-p${i}index }"
            PINDEX="${PINDEX%% -p${i}guid*}"
            add_setting "none" "input_player${i}_joypad_index" "${PINDEX}"
            case ${PLATFORM} in
                atari5200)
                    add_setting "none" "input_libretro_device_p${i}" "513"
                ;;
            esac
        fi
    done
}

###
### Execute functions
###

configure_hotkeys
set_ra_menudriver
set_fps
set_cheevos
set_netplay
set_translation
set_aspectratio
set_filtering
set_integerscale
set_rgascale
set_shader
set_filter
set_rewind
set_savestates
set_autosave
set_runahead
set_audiolatency
set_analogsupport
set_tatemode
set_n64opts
set_atari
set_gambatte
set_controllers

cleanup
