&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#

## Panel Rotation
If you have a new device that supports Mainline Linux, adding and submitting a rotation patch is very simple.  Adding a rotation patch to the kernel will provide the hints needed for Wayland/Weston to also correctly rotate the panel.

To begin, download the kernel sources.  Extract the kernel and rename it to linux-{version}.orig, and then copy that folder to linux-{version} or extract it again so there are two copies.  This will be necessary to create the [patch](https://github.com/JustEnoughLinuxOS/distribution/blob/main/BUILDING.md#creating-a-patch-for-a-package).

### Panel Definition and Default Orientation
Next, edit `linux-{version}/./drivers/gpu/drm/drm_panel_orientation_quirks.c` and add a struct describing your panel and its orientation if one does not already exist.  For example:

```
static const struct drm_dmi_panel_orientation_data lcd1080x1920_leftside_up = {
        .width = 1080,
        .height = 1920,
        .orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
};
```

In the example above, the panel is 1080p, and rotated to the left in order to be corrected.

### DMI Matching
Now that the rotation correction has been defined, the kernel needs a method to match and apply it.  For this we use DMI data.  You can retrieve the DMI data by using `cat`, or `dmidecode`.  For our example, we'll use `cat`.

```
airplus:~ # cat /sys/class/dmi/id/sys_vendor
AYANEO
airplus:~ # cat /sys/class/dmi/id/product_name
AIR Plus
```

Using this data, we will create a match rule to match our panel struct in drm_panel_orientation_quirks.c.

```
{
                .matches = {
                  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
                  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AIR Plus"),
                },
                .driver_data = (void *)&lcd1080x1920_leftside_up,
        }
```

Save, and build your patch following the instructions in BUILDING.md.  Place your patch in `packages/kernel/linux/patches/AMD64` or the appropriate device directory, and run a test build.

> Note: DMI_EXACT_MATCH or DMI_MATCH can be used.  DMI_EXACT_MATCH is as implied, an exact match.  DMI_MATCH will match that any device where its DMI data includes "AIR Plus"

## Hardware
Adding hardware quirks are simple, and many examples can be found in `packages/hardware/quirks/devices`.  To begin, review an existing quirk to familiarize yourself with the pattern.

### Creating a Quirk
The simplest way to create a quirk for your device is to copy an existing quirk and modify it.  To copy it, simply copy the whole folder to the name of your device using the same DMI pattern as above.  If you are working on an AYANEO Air Plus, the folder name would be "AYANEO Air Plus" based on the DMI data in our example.

Next, edit each file to contain the data appropriate for your device.  To collect the data that you need, use the following tools:

#### 001-deviceconfig
This configuration file contains basic information for JELOS that cannot currently be determined automatically.  A configuration is provided with the distribution if there is no quirk found, however it can be customized to suit.  The following tools can be used to identify the correct data for your device.
* KEYA/B_MODIFIER - `evtest`.
* PATH_SPK/HP - `amixer`.

#### 001-audio
Audio is not detected automatically in JELOS currently, and requires a quirk to configure it on startup.  To test and identify the proper configuration for your device use the following method.
* Configure Audio using the "System Settings" menu in EmulationStation.
  * `set-audio get` and `set-audio esget`

#### 002-fancontrol
Not all devices have methods available to control the fan.  The following can help determine if yours can be controlled.
* `find /sys/devices -name pwm*` and evaluate if fan control is available.
* DEVICE_HAS_FAN=false if manual control cannot be enabled.

#### Additional Quirks
Your device may need additional quirks to function correctly or for optimization. Ask in the JELOS discord if you need additional guidance.

## Submitting Quirks
Please follow BUILDING.md and CONTRIBUTING.md to submit your quirks to the distribution for inclusion.  Please do not change major functionality of the distribution or break our hotkey standards, submissions that do not follow our standards will need to be revised.
