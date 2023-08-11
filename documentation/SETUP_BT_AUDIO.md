# Bluetooth Audio Setup

## How to pair your headset
Go to the "Controller & Bluetooth Settings" menu in Emulation Station and enable Bluetooth. Put your headset into pairing mode, then select "Pair a bluetooth device" - your audio device should be detected and paired automatically.
Once your headset is paired go to "System Settings" -> "Audio Device" - your headset should appear in the list of devices. Select "Bluetooth Device" or your paired device from the list and let EmulationStation restart. All audio should now go through your bluetooth device.

## Known Working Devices
Since bluetooth is infamously unreliable I'm putting together a few test results with various headphones. This list is very outdated at this point so please feel free to submit your own results - it would greatly help to identify issues and fix them.

| JELOS Device  | JELOS Version | Bluetooth Device | Codec(s) | Test Results |
|:-------------:|:-------------:|:----------------:|:-----:|:-------|
| RG353V,<br>RG351V (+dongle) | 20221114 | Jaybird X3       | AAC   | Connects but does not play any audio.<br>Worked with previous JELOS version. |
| RG353V        | 20221114 | Sennheiser PXC 550-II | AAC, aptX | No issues, connects and works fine. |
| RG353V,<br>RG351V (+dongle) | 20221114 | Sennheiser Momentum TW3 | aptX | No issues, connects and works fine.<br>Required bluez update to v5.66 to prevent occasional crashes.
| RG353V,<br>RG351V (+dongle) | 20221114 | Sony WH-1000XM3 | LDAC | **Very** minor audio stutters with "mobile" (330kbps) and "standard" (660kbps) quality profiles. Best results achieved with "standard" and adaptive bit rate.<br>"High" (990kbps) quality profile has significant impact on emulator performance and is not recommended.<br>No connectivity issues. |

## How to change codec settings
If you run into issues playing audio from your headset you can try playing with the codec configuration options for BlueALSA. A list of command line parameters can be found here: https://github.com/Arkq/bluez-alsa/blob/master/doc/bluealsa.8.rst. On the device they are read from `/storage/.cache/services/bluealsa.conf` (restart required after change).

## Known Issues

* Disconnects are not handled gracefully by JELOS at this point. If you disconnect your headset without first switching back to the default audio device, you won't get any audio until you reboot.
* Does not work with the PCSX ReARMed32 Retroarch core for unknown reasons (no sound will play from this core).<br>**Workaround**: Use a different PSX core (e.g. PCSX ReARMed, SwanStation) when you want to play with a bluetooth headset.
