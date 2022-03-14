# JELOS Emulators and Cores
https://github.com/JustEnoughLinuxOS/distribution

## Emulators
<table>
  <tr style="vertical-align:top">
    <th align="left">Emulator</th><th align="left">Notes</th>
  </tr>
  <tr>
    <td><a href="https://www.advancemame.it/readme">AdvanceMame</a></td><td><a href="https://www.advancemame.it/download">Standalone</a></td>
  </tr>
  <tr>
    <td><a href="https://github.com/midwan/amiberry/wiki">Amiberry</a></td><td><a href="https://github.com/midwan/amiberry/wiki/Kickstart-ROMs-(BIOS)">Standalone</a></td>
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
    <td><a href="https://github.com/DirtBagXon/hypseus-singe">Hypseus</a></td><td><a href="https://www.daphne-emu.com:9443/mediawiki/index.php/Main_Page">Standalone</a></td>
  </tr>
  <tr>
    <td><a href="https://github.com/drfrag666/gzdoom">lzdoom</a></td><td><a href="https://zdoom.org/wiki/IWAD">Game Engine</a></td>
  </tr>
  <tr>
    <td><a href="https://github.com/DCurrent/openbor">Openbor</a></td><td><a href="https://www.chronocrash.com/forum/index.php?resources/">Standalone</a></td>
  </tr>
  <tr>
    <td><a href="https://github.com/hrydgard/ppsspp">PPSSPPSDL</a></td><td><a href="https://www.ppsspp.org/faq.html">Standalone</a></td>
  </tr>
  <tr>
    <td><a href="https://zdoom.org/wiki/Raze">Raze</a></td><td><a href="https://zdoom.org/wiki/Raze#Supported_games">Game Engine</a></td>
  </tr>
  <tr>
    <td><a href="https://www.scummvm.org">Scummmvm (Scummvmsa)</a></td><td><a href="https://www.scummvm.org/compatibility/">Standalone</a></td>
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
    <td><a href="https://github.com/christianhaitian/arkos/wiki/PortMaster">Port Master</a></td><td><a href="https://github.com/christianhaitian/arkos/wiki/ArkOS-Emulators-and-Ports-information#ports">Port Installer</a></td>
  </tr>
</table>


## Arcade

<table>
  <tr>
    <th align="left">System</th><th align="left">Manufacturer</th><th align="left">Emulator</th><th>Rom Folder</th><th align="left">Extensions</th><th align="left">Bios</th>
  </tr>
  <tr>
    <td rowspan=2 valign="top">Arcade</td><td rowspan=2 valign="top">Various</td><td>RA: <a href="https://docs.libretro.com/library/mame2003_plus"><strong>(mame2003_plus)</strong></a>, <a href="https://github.com/libretro/mame2000-libretro">mame2000</a>, <a href="https://docs.libretro.com/library/mame_2010">mame2010</a>, <a href="https://github.com/libretro/mame2015-libretro">mame2015</a>, <a href="https://github.com/libretro/mame">mame</a>, <a href="https://docs.libretro.com/library/fbneo">fbneo</a>, <a href="https://github.com/libretro/fbalpha2012">fbalpha2012</a></td><td rowspan=2>

```arcade```</td><td rowspan=2 valign="top">.zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/mame2003_plus/#bios">mame2003 plus</a>, <a href="https://docs.libretro.com/library/mame_2010/#bios">mame2010</a>, <a href="https://docs.libretro.com/library/fbneo/#bios">fbneo</a></td>
  </tr>
  <tr>
    <td>SA: <a href="https://www.advancemame.it/readme">AdvanceMame</a></td><td><a href="https://www.advancemame.it/download">Mame 0.106</a></td>
  </tr>
  <tr>
    <td>Atomiswave</td><td>Sammy</td><td>RA: <a href="https://docs.libretro.com/library/flycast"><strong>(flycast)</strong></a></td><td>

```atomiswave```</td><td>.lst .LST .bin .BIN .dat .DAT .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/flycast/#bios">flycast</a></td>
  </tr>
  <tr>
    <td rowspan=2 valign="top">Daphne</td><td rowspan=2 valign="top">Various</td><td>RA: <a href="https://github.com/libretro/daphne">daphne</a></td><td rowspan=2>

```daphne```</td><td rowspan=2 valign="top">.daphne .DAPHNE</td><td rowspan="2"><a href="https://github.com/libretro/daphne#game-compatibility-at-initial-commit">daphne</a></td>
  </tr>
  <tr>
    <td>SA: <a href="https://github.com/DirtBagXon/hypseus-singe"><strong>(HYPSEUS)</strong></a></td>
  </tr>
  <tr>
    <td>Final Burn Neo</td><td>Arcade</td><td>RA: <a href="https://docs.libretro.com/library/fbneo"><strong>(fbneo)</strong></a>, <a href="https://docs.libretro.com/library/mame2003_plus">mame2003_plus</a>, <a href="https://docs.libretro.com/library/mame_2010">mame2010</a>, <a href="https://github.com/libretro/mame2015-libretro">mame2015</a>, <a href="https://github.com/libretro/mame">mame</a>, <a href="https://github.com/libretro/fbalpha2012">fbalpha2012</a>, <a href="https://github.com/libretro/fbalpha">fbalpha2019</a></td><td>

```fbneo```</td><td>.7z .zip .7Z .ZIP</td><td><a href="https://docs.libretro.com/library/fbneo/#bios">fbneo</a>, <a href="https://docs.libretro.com/library/mame2003_plus/#bios">mame2003 plus</a>, <a href="https://docs.libretro.com/library/mame_2010/#bios">mame2010</a></td>
  </tr>
  <tr>
    <td rowspan=2 valign="top">MAME</td><td rowspan=2 valign="top">Various</td><td>RA: <a href="https://docs.libretro.com/library/mame2003_plus"><strong>(mame2003_plus)</strong></a>, <a href="https://github.com/libretro/mame2000-libretro">mame2000</a>, <a href="https://docs.libretro.com/library/mame_2010">mame2010</a>, <a href="https://github.com/libretro/mame2015-libretro">mame2015</a>, <a href="https://github.com/libretro/mame">mame</a>, <a href="https://docs.libretro.com/library/fbneo">fbneo</a>, <a href="https://github.com/libretro/fbalpha2012">fbalpha2012</a></td><td rowspan=2>

```mame```</td><td rowspan=2 valign="top">.7z .7Z .zip .ZIP</td><td><a href="https://docs.libretro.com/library/mame2003_plus/#bios">mame2003 plus</a>, <a href="https://docs.libretro.com/library/mame_2010/#bios">mame2010</a>, <a href="https://docs.libretro.com/library/fbneo/#bios">fbneo</a></td>
  </tr>
  <tr>
    <td>SA: <a href="https://www.advancemame.it/readme">AdvanceMame</a></td><td><a href="https://www.advancemame.it/download">Mame 0.106</a></td>
  </tr>
  <tr>
    <td>Naomi</td><td>Sega</td><td>RA: <a href="https://docs.libretro.com/library/flycast"><strong>(flycast)</strong></a></td><td>

```naomi```</td><td>.lst .LST .bin .BIN .dat .DAT .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/flycast/#bios">flycast</a></td>
  </tr>
  <tr>
    <td>Neo Geo</td><td>SNK</td><td>RA: <a href="https://docs.libretro.com/library/fbneo"><strong>(fbneo)</strong></a>, <a href="https://docs.libretro.com/library/mame2003_plus">mame2003_plus</a>, <a href="https://github.com/libretro/fbalpha2012">fbalpha2012</a>, <a href="https://github.com/libretro/fbalpha">fbalpha2019</a>, <a href="https://docs.libretro.com/library/mame_2010">mame2010</a>, <a href="https://github.com/libretro/mame2015-libretro">mame2015</a>, <a href="https://github.com/libretro/mame">mame</a></td><td>

```neogeo```</td><td>.7z .7Z .zip .ZIP</td><td><a href="https://docs.libretro.com/library/fbneo/#bios">fbneo, </a><a href="https://docs.libretro.com/library/mame2003_plus/#bios">mame2003 plus</a>, <a href="https://docs.libretro.com/library/mame_2010/#bios">mame2010</a></td>
  </tr>
</table>

## Consoles and Portables

<table>
  <tr>
    <th align="left">Manufacturer</th><th align="left">System</th><th align="left">Core</th><th>Rom Folder</th><th align="left">Extensions</th><th align="left">Bios</th>
  </tr>
  <tr>
    <td rowspan="4" valign="top">Atari</td><td>Atari 2600</td><td>RA: <a href="https://docs.libretro.com/library/stella/">stella</a>, <strong>(stella2014)</strong></td><td>

```atari2600```</td><td>.a26 .A26 .bin .BIN .zip .ZIP .7z .7Z</td><td></td>
  </tr>
  <tr>
    <td>Atari 5200</td><td>RA: <a href="https://docs.libretro.com/library/atari800"><strong>(atari800)</strong></a></td><td>

```atari5200```</td><td>.rom .ROM .xfd .XFD .atr .ATR .atx .ATX .cdm .CDM .cas .CAS .car .CAR .bin .BIN .a52 .A52 .xex .XEX .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/atari800/#bios">atari800</a></td>
  </tr>
  <tr>
    <td>Atari 7800</td><td>RA: <a href="https://docs.libretro.com/library/prosystem"><strong>(prosystem)</strong></a></td><td>

```atari7800```</td><td>.a78 .A78 .bin .BIN .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/prosystem/#bios">prosystem</a></td>
  </tr>
  <tr>
    <td>Lynx</td><td>RA: <a href="https://docs.libretro.com/library/handy"><strong>(handy)</strong></a>, <a href="https://docs.libretro.com/library/beetle_lynx">beetle_lynx</a></td><td>

```atarilynx```</td><td>.lnx .LNX .o .O .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/handy/#bios">handy</a>, <a href="https://docs.libretro.com/library/beetle_lynx/#bios">beetle_lynx</a></td>
  </tr>
  <tr>
    <td rowspan="3" valign="top">Bandai</td><td>SuFami Turbo</td><td>RA: <a href="https://docs.libretro.com/library/snes9x"><strong>(snes9x)</strong></a></td><td>

```sufami```</td><td>.st .ST .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/snes9x/#bios">snes9x</a></td>
  </tr>
  <tr>
    <td>Wonderswan</td><td>RA: <a href="https://docs.libretro.com/library/beetle_cygne"><strong>(beetle_wswan)</strong></a></td><td>

```wonderswan```</td><td>.ws .WS .zip .ZIP .7z .7Z</td><td></td>
  </tr>
  <tr>
    <td>Wonderswan Color</td><td>RA: <a href="https://docs.libretro.com/library/beetle_cygne"><strong>(beetle_wswan)</strong></a></td><td>

```wonderswancolor```</td><td>.wsc .WSC .zip .ZIP .7z .7Z</td><td></td>
  </tr>
  <tr>
    <td>belogic</td><td>Uzebox</td><td>RA: <a href="https://docs.libretro.com/library/uzem">uzem</a></td><td>

```uzebox```</td><td>.uze .UZE</td><td></td>
  </tr>
  <tr>
    <td>Coleco</td><td>ColecoVision</td><td>RA: <a href="https://docs.libretro.com/library/bluemsx"><strong>(bluemsx)</strong></a>, <a href="https://docs.libretro.com/library/gearcoleco">gearcoleco</a>, <a href="https://docs.libretro.com/library/smsplus">smsplus</a></td><td>

```coleco```</td><td>.bin .BIN .col .COL .rom .ROM .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/bluemsx/#bios">bluemsx</a>, <a href="https://docs.libretro.com/library/gearcoleco/#bios">gearcoleco</a>, <a href="https://docs.libretro.com/library/smsplus/#bios">smsplus</a></td>
  </tr>
  <tr>
    <td>Fairchild</td><td>Channel F</td><td>RA: <a href="https://github.com/libretro/FreeChaF"><strong>(freechaf)</strong></a></td><td>

```channelf```</td><td>.bin .BIN .chf .CHF .zip .ZIP .7z .7Z</td><td></td>
  </tr>
  <tr>
    <td>Magnavox</td><td>Odyssey 2</td><td>RA: <a href="https://docs.libretro.com/library/o2em"><strong>(o2em)</strong></a></td><td>

```odyssey```</td><td>.bin .BIN .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/o2em/#bios">o2em</a></td>
  </tr>
  <tr>
    <td>Mattel</td><td>Intellivision</td><td>RA: <a href="https://docs.libretro.com/library/freeintv"><strong>(freeintv)</strong></a></td><td>

```intellivision```</td><td>.int .INT .bin .BIN .rom .ROM .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/freeintv/#bios">freeintv</a></td>
  </tr>
  <tr>
    <td>Milton Bradley</td><td>Vectrex</td><td>RA: <a href="https://docs.libretro.com/library/vecx"><strong>(vecx)</strong></a></td><td>

```vectrex```</td><td>.bin .BIN .gam .GAM .vec .VEC .zip .ZIP .7z .7Z</td><td></td>
  </tr>
  <tr>
    <td rowspan="6" valign="top">NEC</td><td>PC Engine</td><td>RA: <a href="https://docs.libretro.com/library/beetle_pce_fast"><strong>(beetle_pce_fast)</strong></a>, <a href="https://docs.libretro.com/library/beetle_sgx">beetle_supergrafx</a></td><td>

```pcengine```</td><td>.pce .PCE .bin .BIN .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/beetle_pce_fast/#bios">beetle_pce_fast</a>, <a href="https://docs.libretro.com/library/beetle_sgx/#bios">beetle_supergrafx</a></td>
  </tr>
  <tr>
    <td>PC Engine CD</td><td>RA: <a href="https://docs.libretro.com/library/beetle_pce_fast"><strong>(beetle_pce_fast)</strong></a>, <a href="https://docs.libretro.com/library/beetle_sgx">beetle_supergrafx</a></td><td>

```pcenginecd```</td><td>.cue .CUE .ccd .CCD .chd .CHD .toc .TOC .m3u .M3U</td><td><a href="https://docs.libretro.com/library/beetle_pce_fast/#bios">beetle_pce_fast</a>, <a href="https://docs.libretro.com/library/beetle_sgx/#bios">beetle_supergrafx</a></td>
  </tr>
  <tr>
    <td>PC-FX</td><td>RA: <a href="https://docs.libretro.com/library/beetle_pc_fx"><strong>(beetle_pcfx)</strong></a></td><td>

```pcfx```</td><td>.chd .CHD .cue .CUE .ccd .CCD .toc .TOC</td><td><a href="https://docs.libretro.com/library/beetle_pc_fx/#bios">beetle_pcfx</a></td>
  </tr>
  <tr>
    <td>Super Grafx</td><td>RA: <a href="https://docs.libretro.com/library/beetle_sgx"><strong>(beetle_supergrafx)</strong></a></td><td>

```sgfx```</td><td>.pce .PCE .sgx .SGX .cue .CUE .ccd .CCD .chd .CHD .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/beetle_sgx/#bios">beetle_supergrafx</a></td>
  </tr>
  <tr>
    <td>TurboGrafx-16</td><td>RA: <a href="https://docs.libretro.com/library/beetle_pce_fast"><strong>(beetle_pce_fast)</strong></a>, <a href="https://docs.libretro.com/library/beetle_sgx">beetle_supergrafx</a></td><td>

```tg16```</td><td>.pce .PCE .bin .BIN .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/beetle_pce_fast/#bios">beetle_pce_fast</a>, <a href="https://docs.libretro.com/library/beetle_sgx/#bios">beetle_supergrafx</a></td>
  </tr>
  <tr>
    <td>TurboGrafx-CD</td><td>RA: <a href="https://docs.libretro.com/library/beetle_pce_fast"><strong>(beetle_pce_fast)</strong></a>, <a href="https://docs.libretro.com/library/beetle_sgx">beetle_supergrafx</a></td><td>

```tg16cd```</td><td>.cue .CUE .ccd .CCD .chd .CHD .toc .TOC .m3u .M3U</td><td><a href="https://docs.libretro.com/library/beetle_pce_fast/#bios">beetle_pce_fast</a>, <a href="https://docs.libretro.com/library/beetle_sgx/#bios">beetle_supergrafx</a></td>
  </tr>
  <tr>
    <td rowspan="20" valign="top">Nintendo</td><td>Famicom</td><td>RA: <a href="https://docs.libretro.com/library/fceumm">fceumm</a>, <a href="https://docs.libretro.com/library/nestopia_ue"><strong>(nestopia)</strong></a>, <a href="https://docs.libretro.com/library/quicknes/">quicknes</a></td><td>

```famicom```</td><td>.nes .NES .unif .UNIF .unf .UNF .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/nestopia_ue/#bios">nestopia</a>, <a href="https://docs.libretro.com/library/fceumm/#bios">fceumm</a></td>
  </tr>
  <tr>
    <td>Famicom Disk System</td><td>RA: <a href="https://docs.libretro.com/library/fceumm">fceumm</a>, <a href="https://docs.libretro.com/library/nestopia_ue"><strong>(nestopia)</strong></a>, <a href="https://docs.libretro.com/library/quicknes/">quicknes</a></td><td>

```fds```</td><td>.fds .FDS .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/nestopia_ue/#bios">nestopia</a>, <a href="https://docs.libretro.com/library/fceumm/#bios">fceumm</a></td>
  </tr>
  <tr>
    <td>Game and Watch</td><td>RA: <a href="https://docs.libretro.com/library/gw"><strong>(gw)</strong></a></td><td>

```gameandwatch```</td><td>.mgw .MGW .zip .ZIP .7z .7Z</td><td></td>
  </tr>
  <tr>
    <td>Game Boy</td><td>RA: <a href="https://docs.libretro.com/library/gambatte"><strong>(gambatte)</strong></a>, <a href="https://docs.libretro.com/library/sameboy">sameboy</a>, <a href="https://docs.libretro.com/library/gearboy">gearboy</a>, <a href="https://docs.libretro.com/library/tgb_dual">tgbdual</a>, <a href="https://docs.libretro.com/library/mgba">mgba</a>, <a href="https://docs.libretro.com/library/vba_m">vbam</a></td><td>

```gb```</td><td>.gb .GB .gbc .GBC .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/gambatte/#bios">gambatte</a>, <a href="https://docs.libretro.com/library/gearboy/#bios">gearboy</a>, <a href="https://docs.libretro.com/library/sameboy/#bios">sameboy</a>, <a href="https://docs.libretro.com/library/mgba/#bios">mgba</a>, <a href="https://docs.libretro.com/library/vba_m/#bios">vbam</a></td>
  </tr>
  <tr>
    <td>Game Boy (Hacks)</td><td>RA: <a href="https://docs.libretro.com/library/gambatte"><strong>(gambatte)</strong></a>, <a href="https://docs.libretro.com/library/sameboy">sameboy</a>, <a href="https://docs.libretro.com/library/gearboy">gearboy</a>, <a href="https://docs.libretro.com/library/tgb_dual">tgbdual</a>, <a href="https://docs.libretro.com/library/mgba">mgba</a>, <a href="https://docs.libretro.com/library/vba_m">vbam</a></td><td>

```gbh```</td><td>.gb .GB .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/gambatte/#bios">gambatte</a>, <a href="https://docs.libretro.com/library/gearboy/#bios">gearboy</a>, <a href="https://docs.libretro.com/library/sameboy/#bios">sameboy</a>, <a href="https://docs.libretro.com/library/mgba/#bios">mgba</a>, <a href="https://docs.libretro.com/library/vba_m/#bios">vbam</a></td>
  </tr>
  <tr>
    <td>Game Boy Advance</td><td>RA: <a href="https://docs.libretro.com/library/mgba"><strong>(mgba)</strong></a>, <a href="https://docs.libretro.com/library/gpsp">gpsp</a>, <a href="https://docs.libretro.com/library/vba_m">vbam</a>, <a href="https://docs.libretro.com/library/vba_next">vba_next</a>, <a href="https://docs.libretro.com/library/beetle_gba">beetle_gba</a></td><td>

```gba```</td><td>.gba .GBA .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/mgba/#bios">mgba</a><a href="https://docs.libretro.com/library/beetle_gba/#bios">beetle_gba</a>, <a href="https://docs.libretro.com/library/gpsp/#bios">gpsp</a>, <a href="https://docs.libretro.com/library/vba_m/#bios">vbam</a>, <a href="https://docs.libretro.com/library/vba_next/#bios">vba-next</a></td>
  </tr>
  <tr>
    <td>Game Boy Advance (Hacks)</td><td>RA: <a href="https://docs.libretro.com/library/mgba"><strong>(mgba)</strong></a>, <a href="https://docs.libretro.com/library/gpsp">gpsp</a>, <a href="https://docs.libretro.com/library/vba_m">vbam</a>, <a href="https://docs.libretro.com/library/vba_next">vba_next</a>, <a href="https://docs.libretro.com/library/beetle_gba">beetle_gba</a></td><td>

```gbah```</td><td>.gba .GBA .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/mgba/#bios">mgba</a><a href="https://docs.libretro.com/library/beetle_gba/#bios">beetle_gba</a>, <a href="https://docs.libretro.com/library/gpsp/#bios">gpsp</a>, <a href="https://docs.libretro.com/library/vba_m/#bios">vbam</a>, <a href="https://docs.libretro.com/library/vba_next/#bios">vba-next</a></td>
  </tr>
  <tr>
    <td>Game Boy Color</td><td>RA: <a href="https://docs.libretro.com/library/gambatte"><strong>(gambatte)</strong></a>, <a href="https://docs.libretro.com/library/sameboy>sameboy</a>, <a href="https://docs.libretro.com/library/gearboy">gearboy</a>, <a href="https://docs.libretro.com/library/tgb_dual">tgbdual</a>, <a href="https://docs.libretro.com/library/mgba">mgba</a>, <a href="https://docs.libretro.com/library/vba_m">vbam</a></td><td>

```gbc```</td><td>.gb .GB .gbc .GBC .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/gambatte/#bios">gambatte</a>, <a href="https://docs.libretro.com/library/gearboy/#bios">gearboy</a>, <a href="https://docs.libretro.com/library/sameboy/#bios">sameboy</a>, <a href="https://docs.libretro.com/library/mgba/#bios">mgba</a>, <a href="https://docs.libretro.com/library/vba_m/#bios">vbam</a></td>
  </tr>
  <tr>
    <td>Game Boy Color (Hacks)</td><td>RA: <a href="https://docs.libretro.com/library/gambatte"><strong>(gambatte)</strong></a>, <a href="https://docs.libretro.com/library/sameboy">sameboy</a>, <a href="https://docs.libretro.com/library/gearboy">gearboy</a>, <a href="https://docs.libretro.com/library/tgb_dual">tgbdual</a>, <a href="https://docs.libretro.com/library/mgba">mgba</a>, <a href="https://docs.libretro.com/library/vba_m">vbam</a></td><td>

```gbch```</td><td>.gb .GB .gbc .GBC .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/gambatte/#bios">gambatte</a>, <a href="https://docs.libretro.com/library/gearboy/#bios">gearboy</a>, <a href="https://docs.libretro.com/library/sameboy/#bios">sameboy</a>, <a href="https://docs.libretro.com/library/mgba/#bios">mgba</a>, <a href="https://docs.libretro.com/library/vba_m/#bios">vbam</a></td>
  </tr>
  <tr>
    <td>MSU-1</td><td>RA: <a href="https://docs.libretro.com/library/snes9x"><strong>(snes9x)</strong></a>, <a href="https://docs.libretro.com/library/beetle_bsnes/">beetle_supafaust</a></td><td>

```snesmsu1```</td><td>.smc .SMC .fig .FIG .sfc .SFC .swc .SWC .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/snes9x/#bios">snes9x</a></td>
  </tr>
  <tr>
    <td rowspan=2 valign="top">Nintendo 64</td><td>RA: <a href="https://github.com/libretro/parallel-n64"><strong>(parallel_n64)</strong></a>, parallel_n64_gln64, <a href="https://docs.libretro.com/library/mupen64plus">mupen64plus</a>, mupen64plus_next</td><td rowspan=2>

```n64```</td><td rowspan=2>.z64 .Z64 .n64 .N64 .v64 .V64 .zip .ZIP .7z .7Z</td><td rowspan=2></td>
  </tr>
  <tr>
    <td>SA: <a href="https://github.com/mupen64plus/mupen64plus-video-glide64mk2">m64p_gl64mk2</a>, <a href="https://github.com/mupen64plus/mupen64plus-video-rice">m64p_rice</a></td>
  </tr>
  <tr>
    <td>Nintendo Entertainment System</td><td>RA: <a href="https://docs.libretro.com/library/fceumm">fceumm</a>, <a href="https://docs.libretro.com/library/nestopia_ue"><strong>(nestopia)</strong></a>, <a href="https://docs.libretro.com/library/quicknes/">quicknes</a></td><td>

```nes```</td><td>.nes .NES .unif .UNIF .unf .UNF .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/nestopia_ue/#bios">nestopia</a>, <a href="https://docs.libretro.com/library/fceumm/#bios">fceumm</a></td>
  </tr>
  <tr>
    <td>Nintendo Entertainment System (Hacks)</td><td>RA: <a href="https://docs.libretro.com/library/fceumm">fceumm</a>, <a href="https://docs.libretro.com/library/nestopia_ue"><strong>(nestopia)</strong></a>, <a href="https://docs.libretro.com/library/quicknes/">quicknes</a></td><td>

```nesh```</td><td>.nes .NES .unif .UNIF .unf .UNF .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/nestopia_ue/#bios">nestopia</a>, <a href="https://docs.libretro.com/library/fceumm/#bios">fceumm</a></td>
  </tr>
  <tr>
    <td>Pokemon Mini</td><td>RA: <a href="https://docs.libretro.com/library/pokemini"><strong>(pokemini)</strong></a></td><td>

```pokemini```</td><td>.min .MIN .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/pokemini/#bios">pokemini</a></td>
  </tr>
  <tr>
    <td>Super Nintendo</td><td>RA: <a href="https://docs.libretro.com/library/snes9x"><strong>(snes9x)</strong></a>, <a href="https://docs.libretro.com/library/snes9x_2010">snes9x2010</a>, <a href="https://docs.libretro.com/library/snes9x_2002">snes9x2002</a>, <a href="https://docs.libretro.com/library/snes9x_2005_plus">snes9x2005_plus</a>, <a href="https://docs.libretro.com/library/beetle_bsnes/">beetle_supafaust</a></td><td>

```snes```</td><td>.smc .SMC .fig .FIG .sfc .SFC .swc .SWC .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/snes9x/#bios">snes9x</a></td>
  </tr>
  <tr>
    <td>Super Nintendo (Hacks)</td><td>RA: <a href="https://docs.libretro.com/library/snes9x"><strong>(snes9x)</strong></a>, <a href="https://docs.libretro.com/library/snes9x_2010">snes9x2010</a>, <a href="https://docs.libretro.com/library/snes9x_2002">snes9x2002</a>, <a href="https://docs.libretro.com/library/snes9x_2005_plus">snes9x2005_plus</a>, <a href="https://docs.libretro.com/library/beetle_bsnes/">beetle_supafaust</a></td><td>

```snesh```</td><td>.smc .SMC .fig .FIG .sfc .SFC .swc .SWC .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/snes9x/#bios">snes9x</a></td>
  </tr>
  <tr>
    <td>Super Famicom</td><td>RA: <a href="https://docs.libretro.com/library/snes9x"><strong>(snes9x)</strong></a>, <a href="https://docs.libretro.com/library/snes9x_2010">snes9x2010</a>, <a href="https://docs.libretro.com/library/snes9x_2002">snes9x2002</a>, <a href="https://docs.libretro.com/library/snes9x_2005_plus">snes9x2005_plus</a>, <a href="https://docs.libretro.com/library/beetle_bsnes/">beetle_supafaust</a></td><td>

```sfc```</td><td>.smc .SMC .fig .FIG .sfc .SFC .swc .SWC .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/snes9x/#bios">snes9x</a></td>
  </tr>
  <tr>
    <td>Satellaview</td><td>RA: <a href="https://docs.libretro.com/library/snes9x"><strong>(snes9x)</strong></a>, <a href="https://docs.libretro.com/library/snes9x_2010">snes9x2010</a>, <a href="https://docs.libretro.com/library/snes9x_2002">snes9x2002</a>, <a href="https://docs.libretro.com/library/snes9x_2005_plus">snes9x2005_plus</a></td><td>

```satellaview```</td><td>.smc .SMC .fig .FIG .bs .BS .sfc .SFC .bsx .BSX .swc .SWC .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/snes9x/#bios">snes9x</a></td>
  </tr>
  <tr>
    <td>Virtual Boy</td><td>RA: <a href="https://docs.libretro.com/library/beetle_vb"><strong>(beetle_vb)</strong></a></td><td>

```virtualboy```</td><td>.vb .VB .zip .ZIP .7z .7Z</td><td></td>
  </tr>
  <tr>
    <td>Panasonic</td><td>3DO</td><td>RA: <a href="https://docs.libretro.com/library/opera"><strong>(opera)</strong></a></td><td>

```3do```</td><td>.iso .ISO .bin .BIN .chd .CHD .cue .CUE</td><td><a href="https://docs.libretro.com/library/opera/#bios">opera</a></td>
  </tr>
  <tr>
    <td>Philips</td><td>VideoPac</td><td>RA: <a href="https://docs.libretro.com/library/o2em"><strong>(o2em)</strong></a></td><td>

```videopac```</td><td>.bin .BIN .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/o2em/#bios">o2em</a></td>
  </tr>
  <tr>
    <td rowspan="13" valign="top">Sega</td><td>Dreamcast</td><td>RA: <a href="https://docs.libretro.com/library/flycast"><strong>(flycast)</strong></a></td><td>

```dreamcast```</td><td>.cdi .CDI .gdi .GDI .chd .CHD .m3u .M3U</td><td><a href="https://docs.libretro.com/library/flycast/#bios">flycast</a></td>
  </tr>
  <tr>
    <td>Game Gear</td><td>RA: <a href="https://docs.libretro.com/library/gearsystem"><strong>(gearsystem)</strong></a>, <a href="https://docs.libretro.com/library/genesis_plus_gx">genesis_plus_gx</a>, <a href="https://docs.libretro.com/library/picodrive">picodrive</a>, <a href="https://docs.libretro.com/library/smsplus">smsplus</a></td><td>

```gamegear```</td><td>.bin .BIN .gg .GG .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/gearsystem/#bios">gearsystem</a>, <a href="https://docs.libretro.com/library/picodrive/#bios">picodrive</a>, <a href="https://docs.libretro.com/library/genesis_plus_gx/#bios">genesis_plus_gx</a>, <a href="https://docs.libretro.com/library/smsplus/#bios">smsplus</a></td>
  </tr>
  <tr>
    <td>Game Gear (Hacks)</td><td>RA: <a href="https://docs.libretro.com/library/gearsystem"><strong>(gearsystem)</strong></a>, <a href="https://docs.libretro.com/library/genesis_plus_gx">genesis_plus_gx</a>, <a href="https://docs.libretro.com/library/picodrive">picodrive</a>, <a href="https://docs.libretro.com/library/smsplus">smsplus</a></td><td>

```gamegearh```</td><td>.bin .BIN .gg .GG .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/gearsystem/#bios">gearsystem</a>, <a href="https://docs.libretro.com/library/picodrive/#bios">picodrive</a>, <a href="https://docs.libretro.com/library/genesis_plus_gx/#bios">genesis_plus_gx</a>, <a href="https://docs.libretro.com/library/smsplus/#bios">smsplus</a></td>
  </tr>
  <tr>
    <td>Sega Mega Drive</td><td>RA: <a href="https://docs.libretro.com/library/genesis_plus_gx"><strong>(genesis_plus_gx)</strong></a>, genesis_plus_gx_wide, <a href="https://docs.libretro.com/library/picodrive">picodrive</a></td><td>

```megadrive-japan```</td><td>.bin .BIN .gen .GEN .md .MD .sg .SG .smd .SMD .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/genesis_plus_gx/#bios">genesis_plus_gx</a>, <a href="https://docs.libretro.com/library/picodrive/#bios">picodrive</a></td>
  </tr>
  <tr>
    <td>Sega 32X</td><td>RA: <a href="https://docs.libretro.com/library/picodrive">picodrive</a></td><td>

```sega32x```</td><td>.32x .32X .smd .SMD .bin .BIN .md .MD .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/picodrive/#bios">picodrive</a></td>
  </tr>
  <tr>
    <td>Sega CD</td><td>RA: <a href="https://docs.libretro.com/library/genesis_plus_gx"><strong>(genesis_plus_gx)</strong></a>, <a href="https://docs.libretro.com/library/picodrive">picodrive</a></td><td>

```segacd```</td><td>.chd .CHD .cue .CUE .iso .ISO .m3u .M3U</td><td><a href="https://docs.libretro.com/library/genesis_plus_gx/#bios">genesis_plus_gx</a>, <a href="https://docs.libretro.com/library/picodrive/#bios">picodrive</a></td>
  </tr>
  <tr>
    <td>Sega Mega-CD</td><td>RA: <a href="https://docs.libretro.com/library/genesis_plus_gx"><strong>(genesis_plus_gx)</strong></a>, <a href="https://docs.libretro.com/library/picodrive">picodrive</a></td><td>

```megacd```</td><td>.chd .CHD .cue .CUE .iso .ISO .m3u .M3U</td><td><a href="https://docs.libretro.com/library/genesis_plus_gx/#bios">genesis_plus_gx</a>, <a href="https://docs.libretro.com/library/picodrive/#bios">picodrive</a></td>
  </tr>
  <tr>
    <td>Sega Genesis</td><td>RA: <a href="https://docs.libretro.com/library/genesis_plus_gx"><strong>(genesis_plus_gx)</strong></a>, genesis_plus_gx_wide, <a href="https://docs.libretro.com/library/picodrive">picodrive</a></td><td>

```genesis```</td><td>.bin .BIN .gen .GEN .md .MD .sg .SG .smd .SMD .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/genesis_plus_gx/#bios">genesis_plus_gx</a>, <a href="https://docs.libretro.com/library/picodrive/#bios">picodrive</a></td>
  </tr>
  <tr>
    <td>Sega Genesis (Hacks)</td><td>RA: <a href="https://docs.libretro.com/library/genesis_plus_gx"><strong>(genesis_plus_gx)</strong></a>, genesis_plus_gx_wide, <a href="https://docs.libretro.com/library/picodrive">picodrive</a></td><td>

```genh```</td><td>.bin .BIN .gen .GEN .md .MD .sg .SG .smd .SMD .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/genesis_plus_gx/#bios">genesis_plus_gx</a>, <a href="https://docs.libretro.com/library/picodrive/#bios">picodrive</a></td>
  </tr>
  <tr>
    <td>Sega Master System</td><td>RA: <a href="https://docs.libretro.com/library/gearsystem"><strong>(gearsystem)</strong></a>, <a href="https://docs.libretro.com/library/genesis_plus_gx">genesis_plus_gx</a>, <a href="https://docs.libretro.com/library/picodrive">picodrive</a>, <a href="https://docs.libretro.com/library/smsplus">smsplus</a></td><td>

```mastersystem```</td><td>.bin .BIN .sms .SMS .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/gearsystem/#bios">gearsystem</a>, <a href="https://docs.libretro.com/library/genesis_plus_gx/#bios">genesis_plus_gx</a>, <a href="https://docs.libretro.com/library/picodrive/#bios">picodrive</a>, <a href="https://docs.libretro.com/library/smsplus/#bios">smsplus</a></td>
  </tr>
  <tr>
    <td>Sega Mega Drive</td><td>RA: <a href="https://docs.libretro.com/library/genesis_plus_gx"><strong>(genesis_plus_gx)</strong></a>, genesis_plus_gx_wide, <a href="https://docs.libretro.com/library/picodrive">picodrive</a></td><td>

```megadrive```</td><td>.bin .BIN .gen .GEN .md .MD .sg .SG .smd .SMD .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/genesis_plus_gx/#bios">genesis_plus_gx</a>, <a href="https://docs.libretro.com/library/picodrive/#bios">picodrive</a></td>
  </tr>
  <tr>
    <td>Sega Saturn</td><td>RA: <strong>(yabasanshiro)</strong></td><td>

```saturn```</td><td>.cue .CUE .chd .CHD .iso .ISO</td><td><a href="https://docs.libretro.com/library/yabause/#bios">yabause</a></td>
  </tr>
  <tr>
    <td>SG-1000</td><td>RA: <a href="https://docs.libretro.com/library/gearsystem"><strong>(gearsystem)</strong></a>, <a href="https://docs.libretro.com/library/genesis_plus_gx">genesis_plus_gx</a>, <a href="https://docs.libretro.com/library/picodrive">picodrive</a></td><td>

```sg-1000```</td><td>.bin .BIN .sg .SG .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/gearsystem/#bios">gearsystem</a>, <a href="https://docs.libretro.com/library/genesis_plus_gx/#bios">genesis_plus_gx</a>, <a href="https://docs.libretro.com/library/picodrive/#bios">picodrive</a></td>
  </tr>
  <tr>
    <td rowspan="3" valign="top">SNK</td><td>Neo Geo CD</td><td>RA: <a href="https://github.com/libretro/neocd_libretro"><strong>(neocd)</strong></a>, <a href="https://docs.libretro.com/library/fbneo">fbneo</a></td><td>

```neocd```</td><td>.cue .CUE .iso .ISO .chd .CHD</td><td><a href="https://github.com/libretro/neocd_libretro#required-bios-files">neocd</a>, <a href="https://docs.libretro.com/library/fbneo/#bios">fbneo</a></td>
  </tr>
  <tr>
    <td>Neo Geo Pocket</td><td>RA: <a href="https://docs.libretro.com/library/beetle_neopop"><strong>(beetle_ngp)</strong></a>, race</td><td>

```ngp```</td><td>.ngc .NGC .ngp .NGP .zip .ZIP .7z .7Z</td><td></td>
  </tr>
  <tr>
    <td>Neo Geo Pocket Color</td><td>RA: <a href="https://docs.libretro.com/library/beetle_neopop"><strong>(beetle_ngp)</strong></a, race</td><td>

```ngpc```</td><td>.ngc .NGC .zip .ZIP .7z .7Z</td><td></td>
  </tr>
  <tr>
    <td rowspan="5" valign="top">Sony</td><td>PlayStation</td><td>RA: <a href="https://docs.libretro.com/library/pcsx_rearmed"><strong>(pcsx_rearmed)</strong></a>, <a href="https://github.com/libretro/swanstation">swanstation</a></td><td>

```psx```</td><td>.bin .BIN .cue .CUE .img .IMG .mdf .MDF .pbp .PBP .toc .TOC .cbn .CBN .m3u .M3U .ccd .CCD .chd .CHD .iso .ISO</td><td><a href="https://docs.libretro.com/library/pcsx_rearmed/#bios">pcsx_rearmed</a></td>
  </tr>
  <tr>
    <td rowspan="2" valign="top">PlayStation Portable</td><td>SA: <a href="https://github.com/hrydgard/ppsspp"><strong>(PPSSPPSDL)</strong></a></td><td rowspan=2>

```psp```</td><td rowspan="2">.iso .ISO .cso .CSO .pbp .PBP</td><td></td>
  </tr>
  <tr>
    <td>RA: <a href="https://docs.libretro.com/library/ppsspp">ppsspp</a></td><td><a href="https://docs.libretro.com/library/ppsspp/#bios">ppsspp</a></td>
  </tr>
  <tr>
    <td rowspan="2">PSP Minis</td><td>SA: <a href="https://github.com/hrydgard/ppsspp"><strong>(PPSSPPSDL)</strong></a></td><td rowspan=2>

```pspminis```</td><td rowspan="2">.iso .ISO .cso .CSO .pbp .PBP</td><td></td>
  </tr>
  <tr>
    <td>RA: <a href="https://docs.libretro.com/library/ppsspp">ppsspp</a></td><td><a href="https://docs.libretro.com/library/ppsspp/#bios">ppsspp</a></td>
  </tr>
  <tr>
    <td>Watara</td><td>Watara Supervision</td><td>RA: <a href="https://store.steampowered.com/app/1844930/RetroArch__Potator"><strong>(potator)</strong></a></td><td>

```supervision```</td><td>.sv .SV .zip .ZIP .7z .7Z</td><td></td>
  </tr>
  <tr>
    <td>Welback Holdings</td><td>Mega Duck</td><td>RA: <a href="https://github.com/libretro/libretro-core-info/blob/master/sameduck_libretro.info"><strong>(sameduck)</strong></a></td><td>

```megaduck```</td><td>.bin .BIN .zip .ZIP .7z .7Z</td><td></td>
  </tr>
</table>

## Computers

<table>
  <tr>
    <th align="left">Manufacturer</th><th align="left">System</th><th align="left">Core</th><th>Rom Folder</th><th align="left">Extensions</th><th align="left">Bios</th>
  </tr>
  <tr>
    <td>Amstrad</td><td>Amstrad CPC</td><td>RA: <a href="https://docs.libretro.com/library/crocods"<strong>(crocods)</strong></a>, <a href="https://docs.libretro.com/library/caprice32">cap32</a></td><td>

```amstradcpc```</td><td>.dsk .DSK .sna .SNA .tap .TAP .cdt .CDT .kcr .KCR .voc .VOC .m3u .M3U .zip .ZIP .7z .7Z</td><td></td>
  </tr>
  <tr>
    <td rowspan="3" valign="top">Atari</td><td>Atari 800</td><td>RA: <strong>(<a href="https://docs.libretro.com/library/atari800">atari800</a>)</strong></td><td>

```atari800```</td><td>.rom .ROM .xfd .XFD .atr .ATR .atx .ATX .cdm .CDM .cas .CAS .car .CAR .bin .BIN .a52 .A52 .xex .XEX .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/atari800/#bios">atari800</td>
  </tr>
  <tr>
    <td rowspan="2" valign="top">Atari ST</td><td>RA: <a href="https://docs.libretro.com/library/hatari"><strong>(hatari)</strong></a></td><td rowspan="2" valign="top">

```atarist```</td><td rowspan="2" valign="top">.st .ST .msa .MSA .stx .STX .dim .DIM .ipf .IPF .m3u .M3U .zip .ZIP .7z .7Z</td><td rowspan="2" valign="top"><a href="https://docs.libretro.com/library/hatari/#bios">hatari</a></td>
  </tr>
  <tr>
    <td>SA: <a href="https://git.tuxfamily.org/hatari/hatari.git">HATARISA</a></td>
  </tr>
  <tr>
    <td rowspan="7" valign="top">Commodore</td><td rowspan="2">Amiga</td><td>RA: <a href="https://docs.libretro.com/library/puae"><strong>(puae)</strong></a>, <a href="https://github.com/libretro/uae4arm-libretro">uae4arm</a></td><td rowspan=2>

```amiga```</td><td rowspan=2>.zip .ZIP .adf .ADF .uae .UAE .ipf .IPF .dms .DMS .adz .ADZ .lha .LHA .m3u .M3U .hdf .HDF .hdz .HDZ</td><td><a href="https://docs.libretro.com/library/puae/#bios">puae</a>, <a href="https://github.com/libretro/uae4arm-libretro#uae4arm-libretro">uae4arm</a></td>
  </tr>
  <tr>
    <td>SA: <a href="https://github.com/midwan/amiberry/wiki">AMIBERRY</a></td><td><a href="https://github.com/midwan/amiberry/wiki/Kickstart-ROMs-(BIOS)">amiberry</a></td>
  </tr>
  <tr>
    <td>Amiga CD32</td><td>RA: <a href="https://docs.libretro.com/library/puae"><strong>(puae)</strong></a>, <a href="https://github.com/libretro/uae4arm-libretro">uae4arm</a></td><td>

```amigacd32```</td><td>.iso .ISO .cue .CUE .lha .LHA .chd .CHD</td><td><a href="https://docs.libretro.com/library/puae/#bios">puae</a>, <a href="https://github.com/libretro/uae4arm-libretro#uae4arm-libretro">uae4arm</a></td>
  </tr>
  <tr>
    <td>Commodore 128</td><td>RA: <a href="https://docs.libretro.com/library/vice"><strong>(vice_x128)</strong></a></td><td>

```c128```</td><td>.d64 .D64 .d71 .D71 .d80 .D80 .d81 .D81 .d82 .D82 .g64 .G64 .g41 .G41 .x64 .X64 .t64 .T64 .tap .TAP .prg .PRG .p00 .P00 .crt .CRT .bin .BIN .d6z .D6Z .d7z .D7Z .d8z .D8Z .g6z .G6Z .g4z .G4Z .x6z .X6Z .cmd .CMD .m3u .M3U .vsf .VSF .nib .NIB .nbz .NBZ .zip .ZIP</td><td><a href="https://docs.libretro.com/library/vice/#c128">vice x128</a></td>
  </tr>
  <tr>
    <td>Commodore 16</td><td>RA: <a href="https://docs.libretro.com/library/vice"><strong>(vice_xplus4)</strong></a></td><td>

```c16```</td><td>.d64 .D64 .d71 .D71 .d80 .D80 .d81 .D81 .d82 .D82 .g64 .G64 .g41 .G41 .x64 .X64 .t64 .T64 .tap .TAP .prg .PRG .p00 .P00 .crt .CRT .bin .BIN .d6z .D6Z .d7z .D7Z .d8z .D8Z .g6z .G6Z .g4z .G4Z .x6z .X6Z .cmd .CMD .m3u .M3U .vsf .VSF .nib .NIB .nbz .NBZ .zip .ZIP</td><td></td>
  </tr>
  <tr>
    <td>Commodore 64</td><td>RA: <a href="https://docs.libretro.com/library/vice"><strong>(vice_x64)</strong></a></td><td>

```c64```</td><td>.d64 .D64 .d71 .D71 .d80 .D80 .d81 .D81 .d82 .D82 .g64 .G64 .g41 .G41 .x64 .X64 .t64 .T64 .tap .TAP .prg .PRG .p00 .P00 .crt .CRT .bin .BIN .d6z .D6Z .d7z .D7Z .d8z .D8Z .g6z .G6Z .g4z .G4Z .x6z .X6Z .cmd .CMD .m3u .M3U .vsf .VSF .nib .NIB .nbz .NBZ .zip .ZIP</td><td><a href="https://docs.libretro.com/library/vice/#c64-fastaccurate">vice x64</a></td>
  </tr>
  <tr>
    <td>Commodore VIC-20</td><td>RA: <a href="https://docs.libretro.com/library/vice"><strong>(vice_xvic)</strong></a></td><td>

```vic20```</td><td>.20 .40 .60 .a0 .A0 .b0 .B0 .d64 .D64 .d71 .D71 .d80 .D80 .d81 .D81 .d82 .D82 .g64 .G64 .g41 .G41 .x64 .X64 .t64 .T64 .tap .TAP .prg .PRG .p00 .P00 .crt .CRT .bin .BIN .gz .GZ .d6z .D6Z .d7z .D7Z .d8z .D8Z .g6z .G6Z .g4z .G4Z .x6z .X6Z .cmd .CMD .m3u .M3U .vsf .VSF .nib .NIB .nbz .NBZ .zip .ZIP</td><td></td>
  </tr>
  <tr>
    <td rowspan="3" valign="top">Microsoft</td><td>MS-DOS</td><td>RA: <a href="https://github.com/schellingb/dosbox-pure"><strong>(dosbox_pure)</strong></a>, <a href="https://github.com/libretro/dosbox-svn">dosbox_svn</a></td><td>

```pc```</td><td>.com .COM .bat .BAT .exe .EXE .dosz .DOSZ</td><td></td>
  </tr>
  <tr>
    <td>MSX</td><td>RA: <a href="https://docs.libretro.com/library/bluemsx"><strong>(bluemsx)</strong></a>, <a href="https://docs.libretro.com/library/fmsx">fmsx</a></td><td>

```msx```</td><td>.dsk .DSK .mx1 .MX1 .mx2 .MX2 .rom .ROM .zip .ZIP .7z .7Z .M3U .m3u</td><td><a href="https://docs.libretro.com/library/bluemsx/#bios">bluemsx</a>, <a href="https://docs.libretro.com/library/fmsx/#bios">fmsx</a></td>
  </tr>
  <tr>
    <td>MSX2</td><td>RA: <a href="https://docs.libretro.com/library/bluemsx"><strong>(bluemsx)</strong></a>, <a href="https://docs.libretro.com/library/fmsx">fmsx</a></td><td>

```msx2```</td><td>.dsk .DSK .mx1 .MX1 .mx2 .MX2 .rom .ROM .zip .ZIP .7z .7Z .M3U .m3u</td><td><a href="https://docs.libretro.com/library/bluemsx/#bios">bluemsx</a>, <a href="https://docs.libretro.com/library/fmsx/#bios">fmsx</a></td>
  </tr>
  <tr>
    <td rowspan="2" valign="top">NEC</td><td>PC-8800</td><td>RA: <a href="https://docs.libretro.com/library/quasi88"><strong>(quasi88)</strong></a></td><td>

```pc88```</td><td>.d88 .D88 .m3u .M3U</td><td><a href="https://docs.libretro.com/library/quasi88/#bios">quasi88</a></td>
  </tr>
  <tr>
    <td>PC-9800</td><td>RA: <a href="https://docs.libretro.com/library/neko_project_ii_kai"<strong>(np2kai)</strong></a>, <a href="https://github.com/libretro/libretro-meowPC98">nekop2</a></td><td>

```pc98```</td><td>.d98 .zip .98d .fdi .fdd .2hd .tfd .d88 .88d .hdm .xdf .dup .hdi .thd .nhd .hdd .hdn</td><td><a href="https://docs.libretro.com/library/neko_project_ii_kai/#bios">np2kai</a></td>
  </tr>
  <tr>
    <td>Sega</td><td>SC-3000</td><td>RA: <a href="https://docs.libretro.com/library/bluemsx"><strong>(bluemsx)</strong></a></td><td>

```sc-3000```</td><td>.bin .BIN .sg .SG .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/bluemsx/#bios">bluemsx</a></td>
  </tr>
  <tr>
    <td rowspan="2" valign="top">Sharp</td><td>Sharp X1</td><td>RA: <a href="https://github.com/r-type/xmil-libretro"><strong>(x1)</strong></a></td><td>

```x1```</td><td>.dx1 .DX1 .2d .2D .2hd .2HD .tfd .TFD .d88 .D88 .88d .88D .hdm .HDM .xdf .XDF .dup .DUP .tap .TAP .cmd .CMD .zip .ZIP .7z .7Z</td><td></td>
  </tr>
  <tr>
    <td>x68000</td><td>RA: <a href="https://docs.libretro.com/library/px68k"><strong>(px68k)</strong></a></td><td>

```x68000```</td><td>.dim .DIM .img .IMG .d88 .D88 .88d .88D .hdm .HDM .dup .DUP .2hd .2HD .xdf .XDF .hdf .HDF .cmd .CMD .m3u .M3U .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/px68k/#bios">px68k</a></td>
  </tr>
  <tr>
    <td rowspan="2" valign="top">Sinclair</td><td>Sinclair ZX Spectrum</td><td>RA: <a href="https://docs.libretro.com/library/fuse"><strong>(fuse)</strong></a></td><td>

```zxspectrum```</td><td>.tzx .TZX .tap .TAP .z80 .Z80 .rzx .RZX .scl .SCL .trd .TRD .dsk .DSK .zip .ZIP .7z .7Z</td><td><a href="https://docs.libretro.com/library/fuse/#bios">fuse</a></td>
  </tr>
  <tr>
    <td>Sinclair ZX81</td><td>RA: <a href="https://docs.libretro.com/library/eightyone"><strong>(81)</strong></a></td><td>

```zx81```</td><td>.tzx .TZX .p .P .zip .ZIP .7z .7Z</td><td></td>
  </tr>
</table>

## Game Engines and Ports

<table style="vertical-align:top">
  <tr>
    <th align="left">Game Engine</th><th align="left">Manufacturer</th><th align="left">Core</th><th align="left">Rom Folder</th><th align="left">Extensions</th><th>Game Data</th>
  </tr>
  <tr>
    <td>Build Engine</td><td>3D Realms</td><td>SA: <a href="https://raze.zdoom.org/about"><strong>(raze)</strong></a></td><td>

```build```</td><td><a href="https://351elec.de/System-Build-Engine#how-to-create-a-build-file">.build</a></td><td><a href="https://zdoom.org/wiki/Raze#Supported_games">Supported games</a></td>
  </tr>
  <tr>
    <td rowspan=3>Doom</td><td rowspan=3>id Software</td><td>SA: <a href="https://github.com/coelckers/gzdoom"><strong>(gzdoom)</strong></a></td><td rowspan=3>

```doom```</td><td rowspan=3><a href="https://351elec.de/System-Doom#how-to-create-a-doom-file">.doom</a></td><td rowspan=2><a href="https://zdoom.org/wiki/IWAD">IWAD</a></td>
  </tr>
  <tr>
    <td>SA: <a href="https://github.com/drfrag666/gzdoom">lzdoom</a></td>
  </tr>
  <tr>
    <td>RA: <a href="https://docs.libretro.com/library/prboom/">prboom</a></td><td><a href="https://docs.libretro.com/library/prboom/#bios">prboom</a></td>
  </tr>
  <tr>
    <td>EasyRPG</td><td>Various</td><td>RA: <a href="https://docs.libretro.com/library/easyrpg/"><strong>(easyrpg)</strong></a></td><td>

```easyrpg```</td><td>.zip .ZIP .easyrpg .EASYRPG .ldb .LDB</td><td><a href="https://itch.io/games/made-with-easyrpg">itch.io games</a></td>
  </tr>
  <tr>
    <td>J2ME</td><td>Sun Microsystems</td><td>RA: <a href="https://github.com/hex007/freej2me"><strong>(freej2me)</strong></a></td><td>

```j2me```</td><td>.jar .JAR</td><td><a href="https://github.com/hex007/freej2me/wiki">Game list</a></td>
  </tr>
  <tr>
    <td>OpenBOR</td><td>Various</td><td>SA: <a href="https://github.com/DCurrent/openbor"><strong>(OPENBOR)</strong></a></td><td>

```openbor```</td><td>.pak .PAK</td><td><a href="https://www.chronocrash.com/forum/index.php?resources/">ChronoCrash</a></td>
  </tr>
  <tr>
    <td>PICO-8</td><td>Lexaloffle</td><td></td><td>

```pico-8```</td><td>.sh .p8 .png .SH .P8 .PNG</td><td><a href="https://www.lexaloffle.com/bbs/?cat=7&carts_tab=1#mode=carts&sub=2">Carts</td>
  </tr>
  <tr>
    <td>Quake</td><td>id Software</td><td>RA: <a href="https://docs.libretro.com/library/tyrquake"><strong>(tyrquake)</strong></a></td><td>

```quake```</td><td>.pak</td><td><a href=https://docs.libretro.com/library/tyrquake/#loading-quake-and-expansion-paks>.pak</a></td>
  </tr>
  <tr>
    <td rowspan=2>ScummVM</td><td rowspan=2>Various</td><td>RA: <a href="https://docs.libretro.com/library/scummvm/">scummvm</a></td><td rowspan=2>

```scummvm```</td><td rowspan=2>.sh .SH .svm .SVM .scummvm</td><td rowspan=2><a href="https://www.scummvm.org/compatibility/">Compatibility</a></td>
  </tr>
  <tr>
    <td>SA: <a href="https://www.scummvm.org/"><strong>(SCUMMVMSA)</strong></a></td>
  </tr>
  <tr>
    <td>Solarus</td><td>Solarus</td><td>SA: <a href="https://www.solarus-games.org/"><strong>(solarus)</strong></a></td><td>

```solarus```</td><td>.solarus</td><td><a href="https://www.solarus-games.org/en/games">Games</a></td>
  </tr>
  <tr>
    <td>TIC-80</td><td>Nesbox</td><td>RA: <a href="https://docs.libretro.com/library/tic80/"><strong>(tic80)</strong></a></td><td>

```tic-80```</td><td>.tic .TIC</td><td><a href="https://tic80.com/play">tic-80 carts</a></td>
  </tr>
  <tr>
    <td>Wolfenstein 3D</td><td>id Software</td><td>SA: <a href="http://maniacsvault.net/ecwolf/wiki/Main_Page"><strong>(ecwolf)</strong></a></td><td>

```ecwolf```</td><td>.ecwolf</td><td><a href="http://maniacsvault.net/ecwolf/wiki/Game_data">Game data</a></td>
  </tr>
  <tr>
    <td><a href="https://github.com/christianhaitian/arkos/wiki/PortMaster">Port Master</a></td><td>Ports</td><td><a href="https://github.com/christianhaitian/arkos/wiki/ArkOS-Emulators-and-Ports-information#ports">various</a></td><td>
    
```ports```</td><td>.sh</td><td><a href="https://github.com/christianhaitian/arkos/wiki/ArkOS-Emulators-and-Ports-information#ports">various</a></td>
  </tr>
</table>

### Retrieving emulator and core details from JELOS

<a href="https://github.com/JustEnoughLinuxOS/distribution/blob/main/packages/jelos/package.mk#L23">JELOS package list</a> 
  
List of all cores
```
ls -l /tmp/cores/*so
```
List of all core info files
```
ls -l /tmp/cores/*info
```
Retrieve details of selected core by viewing core info file (e.g. yabasanshiro)
```
cat /tmp/cores/yabasanshiro_libretro.info  
```  
