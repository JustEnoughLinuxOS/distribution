&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#

# Creating custom shader preset for use with JELOS game and per-system selection
JELOS supports adding custom shaders in addition to the built-in shaders available in the "Advanced Game Options" and "Game Settings / Per System Advanced Configuration" settings "shader set" selection.

## Step 1: Launch a game and access the shaders menu in quick settings
If Shaders are set to "off," change to "on" 

## Step 2: Configure Shader settings to preference by modifying existing shaders
Specific parameters will vary on a per-shader basis so it's recommended you test with the individual shaders first by loading the built-ins and modifying their parameters to your preference. 
When you know how you'd lke to configure everything, you'll select your parameters and passes. To start, you'll select the number of shader passes, the filtering (linear, nearests, or default), and the number of passes for each individual shader listed (generally leave this item at default). Then select "apply changes," set parameters, and save the shader.

----

### Example 
The below example shader configuration is based on a custom shader with two passes for GBA to enable vba-color for original colors (ala real hardware) and LCD grid:

In shaders, choose "load" and then load "vba-color" (either from the main list, or if on android/PC, it'll be in the "handhelds" folder.

Once loaded, go down to "shader passes" and change it from 1 to 2. 

For the second pass where it says "N/A" select it, go into the "handhelds" folder and choose LCD1x. 

Then press "Apply changes" to set it. From there go into "shader parameters" and you'll see the darkening, brighten scanlines, and brighten LCD options. Configure parameters as preferred. For this example, set:

* Darken: 0.25
* Brighten Scanlines: 28.00
* Brighten LCD: 6.00

Once it's configured to your liking, back out of the parameters menu and in the shaders menu press "save" in the menu list. In the save menu set "Simple Presets" to "off" and then "save shader preset as" and name the custom shader. It will now be selectable as a default like any of the other preconfigured shaders.

-----------

You can add additional passes following the steps above (increase passes to 3 and follow the same steps), but keep in mind performance will be dependent on your device, and not all shaders will work at full speed with multiple passes.


## Step 3: Save your new shader preset
Select "Save" in the shaders menu.

At the top of the list, set "Simple Presets" to off. Then choose "Save Shader Preset As" and name the shader. Press the enter key on the on-screen keyboard to save the preset. Exit Retroarch normally via the hotkey preset, or by backing out to the main menu and choosing "Quit Retroarch"

## Step 4: Load your shader preset from JELOS menu

Browse into either "advanced game options" within game selection, or Main Menu -> Game Settings -> Per System Advanced Configuration.

Select shader set, then browse through with the d-pad, joystick, or L/R buttons to page. Your custom shader will now be available to select in the list. 
It may not be specifically where you'd expect. The shader list is alphabetical, but custom shaders are placed at the end of the folder list for shaders, but before the Borders folder path at the end, so you will likely find your custom shader a few pages up from the bottom of the list.


