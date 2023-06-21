#!/bin/bash
#
# PortMaster
# https://github.com/christianhaitian/arkos/wiki/ArkOS-Emulators-and-Ports-information#ports
# Description : A simple tool that allows you to download
# various game ports for Jelos.
#

if [ -f "/etc/profile" ]; then
  source /etc/profile
fi

toolsfolderloc="/storage/.config"

isitext=$(df -PTh $toolsfolderloc | awk '{print $2}' | grep ext)

if [[ "${UI_SERVICE}" =~ weston.service ]]; then
  CUR_TTY="/dev/tty"
else
  CUR_TTY="/dev/tty0"
fi

ESUDO=""
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/storage/.config/PortMaster/libs"
GREP="/storage/.config/PortMaster/grep"
WGET="/usr/bin/wget"
LANG=""
export DIALOGRC=/storage/.config/PortMaster/colorscheme/jelos.dialogrc
app_colorscheme="Default"
mono_version="mono-6.12.0.122-aarch64.squashfs"

chmod 666 ${CUR_TTY}
export TERM=linux
export XDG_RUNTIME_DIR=/run/user/$UID/
printf "\033c" > ${CUR_TTY}
# hide cursor
printf "\e[?25h" > ${CUR_TTY}
dialog --clear

hotkey="Select"
height="15"
width="55"
power='(?<=Title_P=\").*?(?=\")'
opengl="None"
jport="None"

if [[ "${UI_SERVICE}" =~ weston.service ]]; then
  opengl='(?<=Title_F=\").*?(?=\")'
fi

cd $toolsfolderloc/PortMaster

cp "$toolsfolderloc/PortMaster/gamecontrollerdb.txt" /tmp/gamecontrollerdb.txt
$toolsfolderloc/PortMaster/mapper.txt "/tmp/gamecontrollerdb.txt" > /dev/null 2>&1
export SDL_GAMECONTROLLERCONFIG_FILE="/tmp/gamecontrollerdb.txt"

/usr/bin/gptokeyb PortMaster.sh -c "$toolsfolderloc/PortMaster/portmaster.gptk" &

GW=`ip route | awk '/default/ { print $3 }'`
if [ -z "$GW" ]; then
  dialog --clear --backtitle "PortMaster" --title "$1" --clear \
  --msgbox "\n\nYour network connection doesn't seem to be working. \
  \nDid you make sure to configure your wifi connection?" $height $width 2>&1 > ${CUR_TTY}
  $ESUDO kill -9 $(pidof gptokeyb)
  exit 0
fi

website="https://github.com/PortsMaster/PortMaster-Releases/releases/latest/download/"
jwebsite="https://github.com/UzuCore/JelosAddOns/releases/latest/download/"
isgithubrelease="true" #Github releases convert space " " ("%20") to "."

if [ ! -d "/dev/shm/portmaster" ]; then
  mkdir /dev/shm/portmaster
fi

$WGET -t 3 -T 60 --no-check-certificate "$website"ports.md -O /dev/shm/portmaster/pports.md
$WGET -t 3 -T 60 --no-check-certificate "$jwebsite"jports.md -O /dev/shm/portmaster/jports.md

#JELOS has moonlight built in, dont use PortMaster's version.
sed -i '/Title="Moonlight ."/d' /dev/shm/portmaster/pports.md

#Combine PortMaster with JelosAddOns
cat /dev/shm/portmaster/pports.md /dev/shm/portmaster/jports.md > /dev/shm/portmaster/ports.md

PortInfoInstall() {

local setwebsiteback="N"
local unzipstatus

whichsd="storage/roms"

  msgtxt=$(cat /dev/shm/portmaster/ports.md | $GREP "$1" | $GREP -oP '(?<=Desc=").*?(?=")')
  installloc=$(cat /dev/shm/portmaster/ports.md | $GREP "$1" | $GREP -oP '(?<=locat=").*?(?=")')
  porter=$(cat /dev/shm/portmaster/ports.md | $GREP "$1" | $GREP -oP '(?<=porter=").*?(?=")')
  needmono=$(cat /dev/shm/portmaster/ports.md | $GREP "$1" | $GREP -oP '(?<=mono=").*?(?=")')
  if [[ -f "/storage/roms/ports/PortMaster/libs/$mono_version" ]]; then
    ismonothere="y"
  else
    ismonothere="n"
  fi

  if [[ "$isgithubrelease" == "true" ]]; then
    #Github releases convert space " " ("%20") to "."
    # Examples:
    #  - "Bermuda%20Syndrome" -> "Bermuda.Syndrome"
    #  - "Bermuda Syndrome" -> "Bermuda.Syndrome"
    #  - "Mr. Boom" -> "Mr.Boom" (note how space is removed)
    installloc="$( echo "$installloc" | sed 's/%20/./g' | sed 's/ /./g' | sed 's/\.\././g' )"
  fi

  if [[ "${needmono,,}" == "y" ]] && [[ "$ismonothere" == "n" ]]; then
    dialog --clear --backtitle "PortMaster" --title "$1" --clear \
    --yesno "\n$msgtxt \n\nPorted By: $porter\n\nThis port also requires the download and install 
	of the mono library which is over 200MBs in size.  This download may take a while.
	\n\nWould you like to continue to install this port?" $height $width 2>&1 > ${CUR_TTY}
  else
    dialog --clear --backtitle "PortMaster" --title "$1" --clear \
    --yesno "\n$msgtxt \n\nPorted By: $porter\n\nWould you like to continue to install this port?" $height $width 2>&1 > ${CUR_TTY}
  fi

  case $? in
     0)
	    if [ ${needmono,,} == "y" ] && [ $ismonothere == "n" ]; then
	      $WGET -t 3 -T 60 -q --show-progress "$website$mono_version" -O \
	      /storage/roms/ports/PortMaster/libs/$mono_version 2>&1 | stdbuf -oL sed -E 's/\.\.+/---/g'| dialog --progressbox \
		  "Downloading ${mono_version} package..." $height $width > ${CUR_TTY}
        fi
        if [ ${needmono,,} == "y" ] && [ $ismonothere == "n" ] && [ $? -ne 0 ]; then
          dialog --clear --backtitle "PortMaster" --title "$mono_version" --clear --msgbox "\n\n$mono_version did NOT download. \
          \n\nIt did not download correctly.  Please verify that you have at least 500MBs of space left in your roms parition
          and your internet connection is stable and try again." $height $width 2>&1 > ${CUR_TTY}
          $ESUDO rm -f /storage/roms/ports/PortMaster/libs/$mono_version
        else
	      $WGET -t 3 -T 60 -q --show-progress "$dwebsite$installloc" -O \
	      /dev/shm/portmaster/$installloc 2>&1 | stdbuf -oL sed -E 's/\.\.+/---/g'| dialog --progressbox \
	      "Downloading ${1} package..." $height $width > ${CUR_TTY}
	      unzip -o /dev/shm/portmaster/$installloc -d /$whichsd/ports/ > ${CUR_TTY}
	      unzipstatus=$?
		  if [ $unzipstatus -eq 0 ] || [ $unzipstatus -eq 1 ]; then
		    if [ ! -z $isitext ]; then
		      $ESUDO chmod -R 777 /$whichsd/ports
		    fi
		    if [[ -e "/storage/.config/.OS_ARCH" ]] || [ "${OS_NAME}" == "JELOS" ]; then
		      cd /$whichsd/ports/
		      for s in *.sh
			  do
			    if [[ -z $(cat "$s" | $GREP "ESUDO") ]] || [[ -z $(cat "$s" | $GREP "controlfolder") ]]; then
			      sed -i 's/sudo //g' /storage/roms/ports/"$s"
			    fi
			  done
		    fi
		    cd $toolsfolderloc/PortMaster
		    dialog --clear --backtitle "PortMaster" --title "$1" --clear --msgbox "\n\n$1 installed successfully. \
		    \n\nMake sure to restart EmulationStation in order to see it in the ports menu." $height $width 2>&1 > ${CUR_TTY}
		  elif [ $unzipstatus -eq 2 ] || [ $unzipstatus -eq 3 ] || [ $unzipstatus -eq 9 ] || [ $unzipstatus -eq 51 ]; then
		    dialog --clear --backtitle "PortMaster" --title "$1" --clear --msgbox "\n\n$1 did NOT install. \
		    \n\nIt did not download correctly.  Please check your internet connection and try again." $height $width 2>&1 > ${CUR_TTY}
		  elif [ $unzipstatus -eq 50 ]; then
		    dialog --clear --backtitle "PortMaster" --title "$1" --clear --msgbox "\n\n$1 did NOT install. \
		    \n\nYour roms partition seems to be full." $height $width 2>&1 > ${CUR_TTY}
		  else
		    dialog --clear --backtitle "PortMaster" --title "$1" --clear --msgbox "\n\n$1 did NOT install. \
		    \n\nUnzip error code:$unzipstatus " $height $width 2>&1 > ${CUR_TTY}
		  fi

	      $ESUDO rm -f /dev/shm/portmaster/$installloc
        fi
	    ;;
	 *)
	    ;;
  esac
}

userExit() {
  rm -f /dev/shm/portmaster/*ports.md
  dialog --clear
  printf "\033c" > ${CUR_TTY}

  #Fixing ports on S922X, exclude FNA games
  for port in /storage/roms/ports/*.sh; do
    if ! grep -q FNA "$port"; then
      sed -i '/get_controls/c\get_controls && export SDL_VIDEO_GL_DRIVER=/usr/lib/egl/libGL.so.1 SDL_VIDEO_EGL_DRIVER=/usr/lib/egl/libEGL.so.1' "$port"
      echo Fixing: "$port";
    fi
  done;

  exit 0
}

JelosPorts() {
  dwebsite=$jwebsite
  jport='(?<=Title_J=\").*?(?=\")'
  local options=(
   $(cat /dev/shm/portmaster/ports.md | $GREP 'runtype="jp"' | $GREP -oP "(?<=Title=\").*?(?=\")|$power|$opengl|$jport")
  )
  while true; do
    selection=(dialog \
   	--backtitle "PortMaster" \
   	--title "[ Brooksytech Ports]" \
   	--no-collapse \
   	--clear \
	--cancel-label "Back" \
    --menu "Available Brooksytech ports for install" $height $width 15)

    choices=$("${selection[@]}" "${options[@]}" 2>&1 > ${CUR_TTY}) || TopLevel

    for choice in $choices; do
      case $choice in
        *) PortInfoInstall $choice ;;
      esac
    done
  done
}

MainMenu() {
  dwebsite=$website
  jport="None"
  local options=(
   $(cat /dev/shm/portmaster/ports.md | $GREP -oP "(?<=Title=\").*?(?=\")|$power|$opengl|$jport")
  )

  while true; do
    selection=(dialog \
   	--backtitle "PortMaster" \
   	--title "[ Main Menu of all ports]" \
   	--no-collapse \
   	--clear \
	--cancel-label "Back" \
    --menu "Available ports for install" $height $width 15)

    choices=$("${selection[@]}" "${options[@]}" 2>&1 > ${CUR_TTY}) || TopLevel

    for choice in $choices; do
      case $choice in
        *) PortInfoInstall $choice ;;
      esac
    done
  done
}

MainMenuRTR() {
  dwebsite=$website
  jport="None"
  local options=(
   $(cat /dev/shm/portmaster/ports.md | $GREP 'runtype="rtr"' | $GREP -oP "(?<=Title=\").*?(?=\")|$power|$opengl|$jport")
  )

  while true; do
    selection=(dialog \
   	--backtitle "PortMaster" \
   	--title "[ Main Menu for Ready to Run ports ]" \
   	--no-collapse \
   	--clear \
	--cancel-label "Back" \
    --menu "Available Ready to Run ports for install" $height $width 15)

    choices=$("${selection[@]}" "${options[@]}" 2>&1 > ${CUR_TTY}) || TopLevel

    for choice in $choices; do
      case $choice in
        *) PortInfoInstall $choice ;;
      esac
    done
  done
}

TopLevel() {
  local topoptions=( 1 "All Available Ports" 2 "Ready to Run Ports" 3 "Brooksytech Ports" )

  while true; do
    topselection=(dialog \
   	--backtitle "PortMaster" \
   	--title "[ Top Level Menu ]" \
   	--no-collapse \
   	--clear \
	--cancel-label "Exit" \
    --menu "Please make your selection" $height $width 15)

	topchoices=$("${topselection[@]}" "${topoptions[@]}" 2>&1 > ${CUR_TTY}) || userExit

    for choice in $topchoices; do
      case $choice in
        1) MainMenu ;;
	2) MainMenuRTR ;;
	3) JelosPorts ;;
      esac
    done
  done
}

TopLevel
