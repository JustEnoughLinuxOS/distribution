#!/bin/bash

text_viewer -w -y -t "System BIOS Downloader" -m "\nDownload the bios from the network."
response=$?
case $response in
	0)
		message_stream "Bye~:)"
	;;

	21)
		if ping -q -c 1 -W 1 google.com >/dev/null; then
			message_stream "Downloading-"
			wget --no-hsts -P /storage/roms/bios/ https://github.com/UzuCore/minimal-Bios/archive/refs/heads/main.zip
			unzip /storage/roms/bios/main.zip -d /storage/roms/bios/
			cp -rf /storage/roms/bios/minimal-Bios-main/* /storage/roms/bios/
			rm -rf /storage/roms/bios/minimal-Bios-main
			rm -rf /storage/roms/bios/main.zip
			clear >/dev/console
			text_viewer -m "BIOS download completed!" -t "System BIOS Downloader"
		else
			text_viewer -m "The network is off." -t "System BIOS Downloader"
		fi
	;;
esac
