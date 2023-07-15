&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#

# Hotkey Auto-configuration
By default JELOS will detect your controller and configure RetroArch hotkeys automatically.  If this behavior is not desired it can be disabled in the System Settings menu by disabling the "AUTOCONFIGURE RETROARCH HOTKEYS" option.

# RetroArch Hotkeys
* [Hotkey Enable](https://docs.libretro.com/guides/input-and-controls/#hotkey-controls): Select (Hold)
  * Exit: Start (Press Twice)
  * Menu: X
  * Favorite: Hold X
  * Show/Hide FPS: Y
  * Save State: R1
  * Load State: L1
  * Rewind: L2
  * Fast-Forward Toggle: R2
> Note: X and Y are reversed on some devices, this is normal behavior.

# Global Hotkeys
  * Pause: Start
  * Quit: Start+Select
  * Force-Close: L1+Start+Select
  * Skip 5s: R1
  * Back 5s: L1
  * Skip 60s: R2
  * Back 60s: L2
  * Battery Status: L2+Vol-Up
  * WIFI Toggle: L2+Vol-Down
  * Brightness Up: R2+Vol-Up
  * Brightness Down: R2+Vol-Down

# Per Device Hotkeys
|Device|Brightness Up|Brightness Down|Battery Status|WIFI Toggle|
|----|----|----|----|----|
|Anbernic RG351M|Select & Vol +|Select & Vol -|Start  & Vol +|Start & Vol -|
|Anbernic RG353M|Select & Vol +|Select & Vol -|Fn & Vol +|Fn & Vol -|
|Anbernic RG353P|Select & Vol +|Select & Vol -|Fn & Vol +|Fn & Vol -|
|Anbernic RG353V|Select & Vol +|Select & Vol -|Fn & Vol +|Fn & Vol -|
|Anbernic RG503|Select & Vol +|Select & Vol -|Fn & Vol +|Fn & Vol -|
|Anbernic RG552|Select & Vol +|Select & Vol -|Fn & Vol +|Fn & Vol -|
|ATARI VCS 800 Onyx|NA|NA|NA|NA|
|AYANEO AIR|Aya Button & Vol + | Aya Button & Vol - | = Button & Vol + | = Button & Vol -|
|AYANEO AIR Plus|Aya Button & Vol + | Aya Button & Vol - | = Button & Vol + | = Button & Vol -|
|AYANEO AIR Pro|Aya Button & Vol + | Aya Button & Vol - | = Button & Vol + | = Button & Vol -|
|AYANEO AYANEO 2|Aya Button & Vol + | Aya Button & Vol - | = Button & Vol + | = Button & Vol -|
|AYANEO AYA NEO 2021|Aya Button & Vol + | Aya Button & Vol - | = Button & Vol + | = Button & Vol -|
|AYANEO AYANEO 2021|Aya Button & Vol + | Aya Button & Vol - | = Button & Vol + | = Button & Vol -|
|AYANEO AYANEO 2021 Pro|Aya Button & Vol + | Aya Button & Vol - | = Button & Vol + | = Button & Vol -|
|AYANEO AYANEO 2021 Pro Retro Power|Aya Button & Vol + | Aya Button & Vol - | = Button & Vol + | = Button & Vol -|
|AYA NEO AYA NEO Founder|Aya Button & Vol + | Aya Button & Vol - | = Button & Vol + | = Button & Vol -|
|AYANEO AYANEO NEXT Pro|Aya Button & Vol + | Aya Button & Vol - | = Button & Vol + | = Button & Vol -|
|AYANEO GEEK|Aya Button & Vol + | Aya Button & Vol - | = Button & Vol + | = Button & Vol -|
|AYANEO NEXT|Aya Button & Vol + | Aya Button & Vol - | = Button & Vol + | = Button & Vol -|
|AYANEO NEXT Advance|Aya Button & Vol + | Aya Button & Vol - | = Button & Vol + | = Button & Vol -|
|AYANEO NEXT Pro|Aya Button & Vol + | Aya Button & Vol - | = Button & Vol + | = Button & Vol -|
|GPD G1619-04|TBD|TBD|TBD|TBD|
|Hardkernel ODROID-GO-Ultra|F1 & Vol +|F1 & Vol -|F2 & Vol +|F2 & Vol -|
|Indiedroid Nova|NA|NA|NA|NA|
|LENOVO 81TC|NA|NA|NA|NA|
|ODROID-GO Advance|Select & Vol +|Select & Vol -|Start & Vol +|Start & Vol -|
|ODROID-GO Advance Black Edition|Select & Vol +|Select & Vol -|Start & Vol +|Start & Vol -|
|ODROID-GO Super|Select & Vol +|Select & Vol -|Start & Vol +|Start & Vol -|
|Orange Pi 5|NA|NA|NA|NA|
|Powkiddy RGB10 MAX 3|F1 & Vol +|F1 & Vol -|F2 & Vol +|F2 & Vol -|
|Powkiddy RK2023|Select & Vol +|Select & Vol -|Start & Vol +|Start & Vol -|
|Powkiddy x55|Select & Vol +|Select & Vol -|Start & Vol +|Start & Vol -|
|Valve Jupiter|Steam Button & Vol + | Steam Button & Vol - | ... Button & Vol + | ... Button & Vol -|

[Reference](https://github.com/JustEnoughLinuxOS/distribution/blob/main/packages/jelos/profile.d/98-jslisten)

# Emulator Hotkeys and Button Assignments
<table>
  <tr style="vertical-align:top">
    <th align="left">Emulator</th><th align="left">Notes</th>
  </tr>
  <tr>
    <td><a href="https://github.com/midwan/amiberry/wiki">Amiberry</a></td><td><a href="https://github.com/midwan/amiberry/wiki/Kickstart-ROMs-(BIOS)">Standalone</a></td>
  </tr>
  <tr>
    <td valign="top"><a href="https://github.com/dolphin-emu/dolphin">Dolphin (dolphin-sa)</a></td><td><a href="https://dolphin-emu.org/">Standalone</a>
    
```
HOTKEYS (BASED ON GAMECUBE CONTROLLER PROFILE)
=======
SELECT hotkey enable                
START  exit to EmulationStation ("ES")
R     save state
L     load state
A     screenshot
B     internal resolution
Z     game speed (fast forward)
X     aspect ratio
Y     fps on / off
DUP   +1 save state slot
DDOWN -1 save state slot
```
</td>
  </tr>
  <tr>
    <td><a href="http://maniacsvault.net/ecwolf/wiki/Main_Page">ecwolf</a></td><td><a href="http://maniacsvault.net/ecwolf/wiki/Game_data">Game Engine</a></td>
  </tr>
  <tr>
    <td><a href="https://github.com/coelckers/gzdoom">gzdoom</a></td><td><a href="https://zdoom.org/wiki/IWAD">Game Engine</a></td>
  </tr>
  <tr>
    <td><a href="https://git.tuxfamily.org/hatari/hatari.git">Hatari (Hatarisa)</a></td><td><a href="https://docs.libretro.com/library/hatari/#bios">Standalone</a></td>
  </tr>
  <tr>
    <td valign="top"><a href="https://github.com/DirtBagXon/hypseus-singe">Hypseus-singe</a></td><td><a href="https://www.daphne-emu.com:9443/mediawiki/index.php/Main_Page">Standalone</a>
    
```
SELECT        coin
START         start
BUTTON 1      a
BUTTON 2      b
BUTTON 3      x
MOVEMENT      d-pad or left-analog
QUIT          select+start
```
to add functions, edit `/storage/.config/game/configs/hypseus/hypinput.ini` under `[KEYBOARD]` section by changing third number for a function from `0` (disabled) to the joystick button number

retrieve joystick button numbers with

```jstest /dev/input/js0```

the following assigns quit to ```L1``` and pause to ```R1```

```
[KEYBOARD]
KEY_QUIT = SDLK_ESCAPE 0 5
KEY_PAUSE = SDLK_p 0 6

```
</td>
  </tr>
  <tr>
    <td><a href="https://github.com/drfrag666/gzdoom">lzdoom</a></td><td><a href="https://zdoom.org/wiki/IWAD">Game Engine</a></td>
  </tr>
  <tr>
    <td valign="top"><a href="https://github.com/mupen64plus/mupen64plus-video-glide64mk2">mupen64plus (mupen64plussa)</a></td><td><a href="https://mupen64plus.org/docs">Standalone</a>
    
```
SELECT        hotkey enable
START         start
B             a
Y             b
RIGHT ANALOG  C-stick
LEFT ANALOG   analog
L1            L
L2            Z
R1            R

HOTKEYS
=======
SELECT+START  exit to EmulationStation ("ES")
SELECT+R1     save state
SELECT+L1     load state
SELECT+Y      screenshot
SELECT+B      reset current game
```
CONTROLLER PROFILES

Z and L button assignment can be changed in ES.

* Highlight the game and press X
* Select ADVANCED GAME OPTIONS (A to confirm)
* Set EMULATOR to either MUPEN64PLUSSA
* Change INPUT CONFIGURATION
  * DEFAULT:       L1 = L, L2 = Z
  * Z & L SWAP:    L1 = Z, L2 = L
  * CUSTOM:        Users can create their own controller layout in ```/storage/.configs/game/configs/mupen64plussa```
</td>
  </tr>
  <tr>
    <td valign="top"><a href="https://github.com/DCurrent/openbor">Openbor</a></td><td><a href="https://www.chronocrash.com/forum/index.php?resources/">Standalone</a>
    
```
START         start, confirm
A             attack 1
X             attack 2
L1            attack 3
R1            attack 4
B             jump
Y             special
D-PAD         up/down/left/right
SELECT        cancel, screenshot
```
note: pressing A on title screen will exit

</td>
  </tr>
  <tr>
    <td valign="top"><a href="https://github.com/hrydgard/ppsspp">PPSSPPSDL</a></td><td><a href="https://www.ppsspp.org/faq.html">Standalone</a>

```
START         start
SELECT        select
B             cross
A             circle
X             triangle
Y             square
L1            L
R1            R
ANALOG LEFT   analog
ANALOG RIGHT  cross(down) circle(right) triangle(up) square(left)
D-PAD         up/down/left/right
L3            PPSSPPSDL menu
```
</td>
  </tr>
  <tr>
    <td><a href="https://zdoom.org/wiki/Raze">Raze</a></td><td><a href="https://zdoom.org/wiki/Raze#Supported_games">Game Engine</a></td>
  </tr>
  <tr>
    <td><a href="https://www.scummvm.org">Scummmvm (Scummvmsa)</a></td><td><a href="https://www.scummvm.org/compatibility/">Standalone</a></td>
  </tr>
  <tr>
    <td valign="top"><a href="https://vice-emu.sourceforge.io/vice_toc.html">vice (vicesa)</a></td><td><a href="https://vice-emu.sourceforge.io/vice_2.html#SEC5">Standalone</a>

```
SELECT        onscreen keyboard
START         show menu
A             back (in menus); show menu
B             fire (joystick port 1); confirm (in menus)
L1            back (in menus); show menu
L2            assign hotkey
L3            fire (joystick port 2)
R1            confirm (in menus)
R2            swap joystick port (either [left analog + B=fire] or [right analog + L3=fire])
```
Notes: 

Games will require keyboard key presses to progress through messages and to launch 
(e.g. SPACE, RSTR [run/start], F3, F7). 

SELECT to show onscreen keyboard, left analog/d-pad to move cursor, B to confirm 

C= on keyboard resets the machine

L2 to assign highlighted key or menu function to gamepad button (save config to retain)

To cancel onscreen keyboard, move cursor to blank area and A/L1 to close keyboard
or click on X in top left corner of keyboard

Joystick can be assigned to port 1 or 2. R2 to switch ports.
port 1: [left analog] + [B = fire]
port 2: [right analog] + [L3 = fire].

To quit emulator, START, highlight Exit Emulator, B to confirm
</td>
  </tr>
  <tr>
    <td valign="top"><a href="http://wiki.yabause.org/index.php5?title=Documentations">Yabasanshiro</a></td><td><a href="http://www.uoyabause.org">Standalone</a>
    
```
SELECT        menu
START         start
D-PAD         up/down/left/right
Y             a
B             b
A             c
X             x
L1 (shoulder) y
R1 (shoulder) z
L2 (trigger)  l
R2 (trigger)  r
LEFT ANALOG   analog stick
START+SELECT+L1+R1  exit emulator
```
</td>
  </tr>
  <tr>
    <td valign="top"><a href="https://www.retroarch.com">Retroarch with Libretro Cores (<strong>RA:</strong>)</a></td><td>64-bit and 32-bit versions use shared config files
    
```
SELECT+START: exit (press twice)
SELECT+A:     pause emulation
SELECT+B:     reset emulation
SELECT+X:     Retroarch menu
SELECT+Y:     toggle fps
SELECT+L1:    load state
SELECT+R1:    save state
SELECT+L2:    rewind toggle
SELECT+R2:    fast-forward toggle
```
  </td>
  </tr>
  <tr>
    <td><a href="https://github.com/christianhaitian/PortMaster/blob/main/README.md">Port Master</a></td><td><a href="https://github.com/christianhaitian/PortMaster/wiki">Port Installer</a></td>
  </tr>
</table>

# Button Codes
From ssh terminal:
```
evtest
```
then select `retrogame_joypad` to see details for each button press, including button labels, codes and analog stick values in real-time

```
jstest-sdl -t 0
```
to see interactive keymap

<table>
  <tr style="vertical-align:top">
    <th align="left">Joypad Button</th><th align="left" colspan=4>Button Codes</th>
  </tr>
  <tr>
  <td>
<strong>DIGITAL</strong></td><td><strong><a href="https://github.com/JustEnoughLinuxOS/distribution/blob/5ae14a65cc446c1e6f7083ac47adeafc806134a6/packages/ui/emulationstation/config/es_input.cfg#L63">RG552/RG503/RG353P</a></strong></td><td><strong><a href="https://github.com/JustEnoughLinuxOS/distribution/blob/5ae14a65cc446c1e6f7083ac47adeafc806134a6/packages/ui/emulationstation/config/es_input.cfg#L33">RG351MP</a></strong></td><td><strong><a href="https://github.com/JustEnoughLinuxOS/distribution/blob/5ae14a65cc446c1e6f7083ac47adeafc806134a6/packages/ui/emulationstation/config/es_input.cfg#L6">RG351P/M</a></strong></td><td><strong><a href="https://github.com/JustEnoughLinuxOS/distribution/blob/5ae14a65cc446c1e6f7083ac47adeafc806134a6/packages/ui/emulationstation/config/es_input.cfg#L6">RG351V</a></strong></td></tr>
  <tr><td>
A (EAST)      </td><td><strong>1</strong>  (305 BTN_EAST)</td><td><strong>1</strong>  (305 BTN_EAST)</td><td><strong>0</strong>  (305 BTN_EAST)</td><td><strong>0</strong>  (305 BTN_EAST)</td></tr>
  <tr><td>
B (SOUTH)     </td><td><strong>0</strong>  (304 BTN_SOUTH)</td><td><strong>0</strong>  (304 BTN_SOUTH)</td><td><strong>1</strong>  (304 BTN_SOUTH)</td><td><strong>1</strong>  (304 BTN_SOUTH)</td></tr>
  <tr><td>
X (NORTH)     </td><td><strong>2</strong>  (307 BTN_NORTH)</td><td><strong>2</strong>  (307 BTN_NORTH)</td><td><strong>2</strong>  (307 BTN_NORTH)</td><td><strong>2</strong>  (307 BTN_NORTH)</td></tr>
  <tr><td>
Y (WEST)      </td><td><strong>3</strong>  (308 BTN_WEST)</td><td><strong>3</strong>  (308 BTN_WEST)</td><td><strong>3</strong>  (306 BTN_C)</td><td><strong>3</strong>  (306 BTN_C)</td></tr>
  <tr><td>
L1     </td><td><strong>4</strong>  (310 BTN_TL)</td><td><strong>4</strong>  (310 BTN_TL)</td><td><strong>4</strong>  (308 BTN_WEST)</td><td><strong>4</strong>  (308 BTN_WEST)</td></tr>
  <tr><td>
L2     </td><td><strong>6</strong>  (312 BTN_TL2)</td><td><strong>6</strong>  (312 BTN_TL2)</td><td><strong>10</strong> (314 BTN_SELECT)</td><td><strong>10</strong> (314 BTN_SELECT)</td></tr>
  <tr><td>
L3     </td><td><strong>11</strong> (317 BTN_THUMBL)</td><td><strong>14</strong> (706 BTN_TRIGGER_HAPPY3)</td><td><strong>8</strong>  (312 BTN_TL2)</td><td><strong>8</strong>  (312 BTN_TL2)</td></tr>
  <tr><td>
R1     </td><td><strong>5</strong>  (311 BTN_TR)</td><td><strong>5</strong>  (311 BTN_TR)</td><td><strong>5</strong>  (309 BTN_Z)</td><td><strong>5</strong>  (309 BTN_Z)</td></tr>
  <tr><td>
R2     </td><td><strong>7</strong>  (313 BTN_TR2)</td><td><strong>7</strong>  (313 BTN_TR2)</td><td><strong>11</strong> (315 BTN_START)</td><td><strong>11</strong> (315 BTN_START)</td></tr>
  <tr><td>
R3     </td><td><strong>12</strong> (318 BTN_THUMBR)</td><td><strong>15</strong> (707 BTN_TRIGGER_HAPPY4)</td><td><strong>9</strong>  (313 BTN_TR2)</td><td><strong>9</strong>  (313 BTN_TR2; F)</td></tr>
  <tr><td>
SELECT </td><td><strong>8</strong>  (314 BTN_SELECT)</td><td><strong>12</strong> (704 BTN_TRIGGER_HAPPY1)</td><td><strong>7</strong>  (311 BTN_TR)</td><td><strong>7</strong>  (311 BTN_TR)</td></tr>
  <tr><td>
START  </td><td><strong>9</strong>  (315 BTN_START)</td><td><strong>13</strong> (705 BTN_TRIGGER_HAPPY2)</td><td><strong>6</strong>  (310 BTN_TL)</td><td><strong>6</strong>  (310 BTN_TL)</td></tr>
  <tr><td>
HOTKEY ENABLE   </td><td><strong>10</strong> (316)     </td><td><strong>12</strong> (704 BTN_TRIGGER_HAPPY1)     </td><td><strong>7</strong>  (311 BTN_TR)     </td><td><strong>7</strong>  (311 BTN_TR)     </td></tr>
  <tr><td>
DPAD UP         </td><td><strong>13</strong> (544 BTN_DPAD_UP)     </td><td><strong>8</strong>  (544 BTN_DPAD_UP)     </td><td><strong>hat(1)</strong> (16 -ve ABS_HAT0Y -1)</td><td><strong>hat(1)</strong> (16 -ve ABS_HAT0Y -1)</td></tr>
  <tr><td>
DPAD DOWN       </td><td><strong>14</strong> (545 BTN_DPAD_DOWN)     </td><td><strong>9</strong>  (545 BTN_DPAD_DOWN)     </td><td><strong>hat(4)</strong> (16 +ve ABS_HAT0Y 1)</td><td><strong>hat(4)</strong> (16 +ve ABS_HAT0Y 1)</td></tr>
  <tr><td>
DPAD LEFT       </td><td><strong>15</strong> (546 BTN_DPAD_LEFT)     </td><td><strong>10</strong> (546 BTN_DPAD_LEFT)     </td><td><strong>hat(8)</strong> (17 -ve ABS_HAT0X -1)</td><td><strong>hat(8)</strong> (17 -ve ABS_HAT0X -1)</td></tr>
  <tr><td>
DPAD RIGHT      </td><td><strong>16</strong> (547 BTN_DPAD_RIGHT)     </td><td><strong>11</strong> (547 BTN_DPAD_RIGHT)     </td><td><strong>hat(2)</strong> (17 +ve ABS_HAT0X 1)</td><td><strong>hat(2)</strong> (17 +ve ABS_HAT0X 1)</td></tr>
  <tr><td>
<strong>ANALOG</strong></td><td><strong><a href="https://github.com/JustEnoughLinuxOS/distribution/blob/5ae14a65cc446c1e6f7083ac47adeafc806134a6/packages/ui/emulationstation/config/es_input.cfg#L63">RG552/RG503/RG353P</a></strong></td><td><strong><a href="https://github.com/JustEnoughLinuxOS/distribution/blob/5ae14a65cc446c1e6f7083ac47adeafc806134a6/packages/ui/emulationstation/config/es_input.cfg#L33">RG351MP</a></strong></td><td><strong><a href="https://github.com/JustEnoughLinuxOS/distribution/blob/5ae14a65cc446c1e6f7083ac47adeafc806134a6/packages/ui/emulationstation/config/es_input.cfg#L6">RG351P/M</a></strong></td><td><strong><a href="https://github.com/JustEnoughLinuxOS/distribution/blob/5ae14a65cc446c1e6f7083ac47adeafc806134a6/packages/ui/emulationstation/config/es_input.cfg#L6">RG351V</a></strong></td></tr>
  <tr><td>
LEFTANALOGLEFT   </td><td><strong>AXIS 0 -ve</strong> (ABS_X)</td><td><strong>AXIS 0 -ve</strong> (ABS_X)</td><td><strong>AXIS 2 +ve</strong> (ABS_Z  4095)</td><td><strong>AXIS 2 +ve</strong> (ABS_Z 4095)</td></tr>
  <tr><td>
LEFTANALOGRIGHT  </td><td><strong>AXIS 0 +ve</strong> (ABS_X)</td><td><strong>AXIS 0 +ve</strong> (ABS_X)</td><td><strong>AXIS 2 -ve (ABS_Z 0)</strong></td><td><strong>AXIS 2 -ve</strong> (ABS_Z 0)</td></tr>
  <tr><td>
LEFTANALOGUP     </td><td><strong>AXIS 1 -ve</strong> (ABS_Y)</td><td><strong>AXIS 1 -ve</strong> (ABS_Y)</td><td><strong>AXIS 3 +ve</strong> (ABS_RX 4040)</td><td><strong>AXIS 3 +ve</strong> (ABS_RX 4040)</td></tr>
  <tr><td>
LEFTANALOGDOWN   </td><td><strong>AXIS 1 +ve</strong> (ABS_Y)</td><td><strong>AXIS 1 +ve</strong> (ABS_Y)</td><td><strong>AXIS 3 -ve</strong> (ABS_RX 0)</td><td><strong>AXIS 3 -ve</strong> (ABS_RX 0)</td></tr>
  <tr><td>
RIGHTANALOGLEFT  </td><td><strong>AXIS 2 -ve</strong> (ABS_RX)</td><td><strong>AXIS 2 -ve</strong> (ABS_RX)</td><td><strong>AXIS 4 -ve</strong> (ABS_RY)</td><td></td></tr>
  <tr><td>
RIGHTANALOGRIGHT </td><td><strong>AXIS 2 +ve</strong> (ABS_RX)</td><td><strong>AXIS 2 +ve</strong> (ABS_RX)</td><td><strong>AXIS 4 +ve</strong> (ABS_RY)</td><td></td></tr>
  <tr><td>
RIGHTANALOGUP    </td><td><strong>AXIS 3 -ve</strong> (ABS_RY)</td><td><strong>AXIS 3 -ve (ABS_RY)</strong></td><td><strong>AXIS 5 -ve</strong> (ABS_RZ)</td><td></td></tr>
  <tr><td>
RIGHTANALOGDOWN  </td><td><strong>AXIS 3 +ve</strong> (ABS_RY)</td><td><strong>AXIS 3 +ve (ABS_RY)</strong></td><td><strong>AXIS 5 +ve</strong> (ABS_RZ)</td><td></td>
  </tr>
</table>

