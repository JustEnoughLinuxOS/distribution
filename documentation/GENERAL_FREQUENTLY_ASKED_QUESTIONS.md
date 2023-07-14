&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#

## Does JELOS offer any formal support?
  * No. JELOS is something that we develop for fun, it is provided as-is.  There are a variety of avenues to seek community help, but this is a tinkerer's distribution so you will need to get your hands dirty to solve your problems.

## Do you plan to add additional ports, software, or emulators?
  * We are a community developed distribution, and we believe that it is the responsibility of the person who wants a new feature to develop and contribute that feature. If you would like to add something to JELOS, pull requests are welcomed.  Please review our [code of conduct](https://github.com/JustEnoughLinuxOS/distribution/blob/main/CODE_OF_CONDUCT.md), our [contributing guidelines](https://github.com/JustEnoughLinuxOS/distribution/blob/main/CONTRIBUTING.md), and our [build guide](https://github.com/JustEnoughLinuxOS/distribution/blob/main/BUILDING.md) before submitting your first pull request.
## Which emulators and game engines are supported by JELOS?
  * [See JELOS emulators and game engines](https://github.com/JustEnoughLinuxOS/distribution/wiki/JELOS-emulators-and-game-engines)

## Licensing JELOS for redistribution
JELOS utilizes a non-commercial CC BY-NC-SA 4.0 copyleft license on our branding which is intended to prevent abuse of our software.  Device Makers and others who would like to bundle on devices may not do so without our express permission.

### Redistribution Authorization Requirements
If you would like to receive permission from our project to redistribute JELOS, you must request permission in writing.  We can be reached at contact@jelos.org.

#### Benefits
Authorization to use our branding will allow you to distribute JELOS on your device without needing to maintain a fork of the project for your device.  This would include access to our online update feature.

#### Minimum Requirements
To receive permission to redistribute JELOS the following *minimum* criteria must be met.  Please note, that taking these actions without formally receiving approval from our project does not grant you the authority to use our branding.  You MUST receive approval from JELOS.

1. We receive sources for device(s) before they ship to consumers and we have irrevokable authority to publish at our leisure.  We strongly prefer device makers contribute changes to support their device(s) directly to the distribution themselves.
2. Provide, upon request, device samples for every JELOS team member (including core developers, moderation team, and outside contributors), as well as any community developer designated by JELOS, for all devices planned, supported by, or bundled with JELOS for as long as the device maker manufactures the device.
3. It is up to the requestor to secure distribution rights for software included with JELOS that is not developed or owned by JELOS.
4. A support representative must join and participate in our community to support their device(s).

#### Selling JELOS
JELOS branding is licensed for non-commercial use only.  Even if approved to be distributed on a device, it is not allowed to be sold or included as an up charge in any form what-so-ever.  Period.  This is not negotiable.

## What if you stop working on JELOS?
  * I don't expect that to happen, however JELOS is an Open Source project hosted here on GitHub which means the source code is readily available for anyone in the world to pick up and continue where we left off.  Our [license model](https://tldrlegal.com/license/apache-license-2.0-(apache-2.0)) allows for this to happen by providing and encouraging redistribution ([freedom 2](https://www.gnu.org/philosophy/free-sw.en.html#four-freedoms)) and the right to distribute a modified version ([freedom 3](https://www.gnu.org/philosophy/free-sw.en.html#four-freedoms)).  JELOS only prohibits commercial use through our branding which is licensed by the [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](https://tldrlegal.com/license/creative-commons-attribution-noncommercial-sharealike-4.0-international-(cc-by-nc-sa-4.0)).

## I have a device with single storage and I can't see the games partition in Windows or macOS.
  * JELOS does not create an ExFAT partition on the boot device, and expands the full partition using ext4.  You can sync files to the device using SyncThing, copy files to the device using SAMBA, or by loading your files onto a EXT4, ExFAT, or FAT32 formatted usb stick and copy them with FileMan or over ssh.
    * Windows Users can connect to their device by unc path using the device name such as ```\\handheld``` or by IP ```\\device IP address``` into the address bar in Windows Explorer.
    * Mac users can connect by selecting "Go" from the Finder menu, followed by "Connect to Server", then enter ```smb://handheld``` or ```smb://device IP address```.
  * Log in as root.  The root password is required for access which can be found in the system menu.

## I'm using an Intel or AMD based device and I have no sound.
  * Press Start, select System Settings, select your audio output device, save, then choose an available audio path.

## EmuStation displays duplicate game titles. How can I disable a file extension to remove the duplicates? (e.g. display only ```.cue``` and don't display ```.bin``` files for PlayStation)

  * Within EmuStation, select the relevant game system (e.g. PlayStation)
  * Press ```Select``` to View Options
  * In View Options section, choose View Customisation
  * Under File Extensions, deselect any file extensions that are not required (e.g. deselect ```.bin``` for PlayStation when also using ```.cue``` files)

## How do I edit ```es_systems.cfg``` (for example, to modify the list of systems in EmuStation, add a custom core or script, or change the order that systems are displayed)?

  * Delete the ~/.config/emulationstation/es_systems.cfg symlink.
  * Copy the custom version of ```es_systems.cfg``` to ```~/.config/emulationstation```.
  * Stop the UI service.

`systemctl stop ${UI_SERVICE}`
  * Restart the UI service to use the custom version

`systemctl start ${UI_SERVICE}`

> Note: once it's edited any changes made by system updates will be ignored

## Where do I put bios files and files and Retroarch system files

  * They go in ```roms/bios```
  * System bios checker in ```game settings, missing bios``` identities missing files per emulator and indicates their required location

## Where do I put music files to enable background music within emulationstation (while browsing my game library)?
`/storage/roms/BGM`

## My game has slowdown and stuttering issues. What can I do to improve performance?
First make sure you do not have a TDP configured that is too low for your emulator to function correctly.  Next, try adjusting settings within the emulator, either retroarch core or standalone emulator configuration menu. First make sure that rewind is disabled.  Search online to check for recommended settings that others may have determined.

## Where are log files stored?
`/var/log/`

Various logs are generated, including 
  * EmuStation logs `es_log.txt` (cumulative log of all ES activity), `es_launch_stdout.log` (last emulator launched from ES) and `es_launch_stderr.log` (blank if there wasn't an error for the last emulator launch)
  * Execution log `exec.log` (generic execution log that indicates what was last executed, including the command to launch the emulator) e.g. for gzdoom launch of heretic.doom `runemu.sh: Executing /usr/bin/bash start_gzdoom.sh /storage/roms/doom/heretic.doom`
  * Boot log `boot.log` (Output from autostart during system startup)
  * Emulator-specific log (for non-retroarch emulators) e.g. `gzdoom.log` is the log specific to gzdoom to indicate whether there is any issue within the emulator when launching heretic.doom, noted above
  * Retroarch logs are [turned off by default](https://github.com/JustEnoughLinuxOS/distribution/blob/main/packages/games/emulators/retroarch/sources/handheld/retroarch.cfg#L420), but can be enabled within Retroarch (`Tools > Retroarch`: `Settings > Logging > Log to a File`), are stored in `/var/log/retroarch` and are quite detailed, so should provide sufficient detail to identify missing roms within a game's romset, configuration issues and other errors that prevent games from working

> Note: Retroarch uses a shared config file, so logging can be enabled within 64bit or 32bit and it will be enabled for all Retroarch cores
