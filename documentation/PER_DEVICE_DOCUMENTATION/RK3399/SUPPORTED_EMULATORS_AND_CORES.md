&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#

# Supported Systems Emulators and Cores
This document describes all available systems emulators and cores available for the device.

|Manufacturer|System|Release Date|Games Path|Supported Extensions|Emulator / Core|
|----|----|----|----|----|----|
|Amstrad|CPC (amstradcpc)|1984|`amstradcpc`|.dsk .sna .tap .cdt .kcr .voc .m3u .zip .7z|**retroarch:** crocods (default)<br>**retroarch:** cap32<br>|
|Arcade|Arcade (arcade)|1984|`arcade`|.zip .7z|**retroarch:** mame2003_plus (default)<br>**retroarch:** mame2000<br>**retroarch:** mame2010<br>**retroarch:** mame2015<br>**retroarch:** fbneo<br>**retroarch:** fbalpha2012<br>**retroarch:** fbalpha2019<br>**retroarch:** mame<br>|
|Arcade|Daphne (daphne)|1996|`daphne`|.daphneHNE .zip|**hypseus:** hypseus (default)<br>**retroarch:** daphne<br>|
|Arcade|Final Burn Neo (fbn)|1986|`fbneo`|.7z .zip|**retroarch:** fbneo (default)<br>**retroarch:** mame2003_plus<br>**retroarch:** mame2010<br>**retroarch:** mame2015<br>**retroarch:** mame<br>**retroarch:** fbalpha2012<br>**retroarch:** fbalpha2019<br>|
|Arcade|MAME (mame)|1948|`mame`|.7z .zip|**retroarch:** mame2003_plus (default)<br>**retroarch:** mame2010<br>**retroarch:** mame2015<br>**retroarch:** mame<br>**retroarch:** fbneo<br>**retroarch:** fbalpha2012<br>**retroarch:** fbalpha2019<br>|
|Arduboy|Arduboy (arduboy)|2014|`arduboy`|.hex|**retroarch:** arduous (default)<br>|
|Atari|2600 (atari2600)|1977|`atari2600`|.a26 .bin .zip .7z|**retroarch:** stella (default)<br>|
|Atari|5200 (atari5200)|1982|`atari5200`|.rom .xfd .atr .atx .cdm .cas .car .bin .a52 .xex .zip .7z|**retroarch:** a5200 (default)<br>**retroarch:** atari800<br>|
|Atari|7800 (atari7800)|1986|`atari7800`|.a78 .bin .zip .7z|**retroarch:** prosystem (default)<br>|
|Atari|Atari 800 (atari800)|1979|`atari800`|.rom .xfd .atr .atx .cdm .cas .car .bin .a52 .xex .zip .7z|**retroarch:** atari800 (default)<br>|
|Atari|Atari ST (atarist)|1985|`atarist`|.st .msa .stx .dim .ipf .m3u .zip .7z|**retroarch:** hatari (default)<br>**hatarisa:** hatarisa<br>|
|Atari|Jaguar (atarijaguar)|1993|`atarijaguar`|.j64 .jag .rom .abs .cof .bin .prg|**retroarch:** virtualjaguar (default)<br>|
|Atari|Lynx (atarilynx)|1989|`atarilynx`|.lnx .o .O .zip .7z|**retroarch:** handy (default)<br>**retroarch:** beetle_lynx<br>|
|Bandai|SuFami Turbo (sufami)|1996|`sufami`|.st .zip .7z|**retroarch:** snes9x (default)<br>|
|Bandai|Wonderswan (wonderswan)|1999|`wonderswan`|.ws .zip .7z|**retroarch:** beetle_wswan (default)<br>|
|Bandai|Wonderswan Color (wonderswancolor)|2000|`wonderswancolor`|.wsc .zip .7z|**retroarch:** beetle_wswan (default)<br>|
|belogic|Uzebox (uzebox)|2008|`uzebox`|.uze|**retroarch:** uzem (default)<br>|
|Capcom|PlaySystem 1 (cps1)|1988|`cps1`|.zip .7z|**retroarch:** fbneo (default)<br>**retroarch:** mame2003_plus<br>**retroarch:** mame2010<br>**retroarch:** fbalpha2012<br>**retroarch:** mba_mini<br>**AdvanceMame:** AdvanceMame<br>|
|Capcom|PlaySystem 2 (cps2)|1993|`cps2`|.zip .7z|**retroarch:** fbneo (default)<br>**retroarch:** mame2003_plus<br>**retroarch:** mame2010<br>**retroarch:** fbalpha2012<br>**retroarch:** mba_mini<br>**AdvanceMame:** AdvanceMame<br>|
|Capcom|PlaySystem 3 (cps3)|1996|`cps3`|.zip .7z|**retroarch:** fbneo (default)<br>**retroarch:** mame2003_plus<br>**retroarch:** mame2010<br>**retroarch:** fbalpha2012<br>**retroarch:** mba_mini<br>**AdvanceMame:** AdvanceMame<br>|
|Coleco|ColecoVision (colecovision)|1982|`coleco`|.bin .col .rom .zip .7z|**retroarch:** bluemsx (default)<br>**retroarch:** gearcoleco<br>**retroarch:** smsplus<br>|
|Commodore|Amiga (amiga)|1985|`amiga`|.zip .adf .uae .ipf .dms .adz .lha .m3u .hdf .hdz|**retroarch:** puae (default)<br>**amiberry:** amiberry<br>**retroarch:** uae4arm<br>|
|Commodore|Amiga CD32 (amigacd32)|1994|`amigacd32`|.iso .cue .lha .chd|**retroarch:** puae (default)<br>**retroarch:** uae4arm<br>|
|Commodore|C128 (c128)|1985|`c128`|.d64 .d71 .d80 .d81 .d82 .g64 .g41 .x64 .t64 .tap .prg .p00 .crt .bin .d6z .d7z .d8z .g6z .g4z .x6z .cmd .m3u .vsf .nib .nbz .zip|**retroarch:** vice_x128 (default)<br>**vicesa:** x128<br>|
|Commodore|C16 (c16)|1984|`c16`|.d64 .d71 .d80 .d81 .d82 .g64 .g41 .x64 .t64 .tap .prg .p00 .crt .bin .d6z .d7z .d8z .g6z .g4z .x6z .cmd .m3u .vsf .nib .nbz .zip|**retroarch:** vice_xplus4 (default)<br>**vicesa:** xplus4<br>|
|Commodore|C64 (c64)|1982|`c64`|.d64 .d71 .d80 .d81 .d82 .g64 .g41 .x64 .t64 .tap .prg .p00 .crt .bin .d6z .d7z .d8z .g6z .g4z .x6z .cmd .m3u .vsf .nib .nbz .zip|**retroarch:** vice_x64 (default)<br>**vicesa:** x64sc<br>|
|Commodore|Commodore PET (pet)|1977|`pet`|.20 .a0 .b0 .d64 .d71 .d80 .d81 .d82 .g64 .g41 .x64 .t64 .tap .prg .p00 .crt .bin .gz .d6z .d7z .d8z .g6z .g4z .x6z .cmd .m3u .vsf .nib .nbz .zip|**retroarch:** vice_xpet (default)<br>|
|Commodore|VIC-20 (vic20)|1980|`vic20`|.20 .a0 .b0 .d64 .d71 .d80 .d81 .d82 .g64 .g41 .x64 .t64 .tap .prg .p00 .crt .bin .gz .d6z .d7z .d8z .g6z .g4z .x6z .cmd .m3u .vsf .nib .nbz .zip|**retroarch:** vice_xvic (default)<br>**vicesa:** vice_xvic<br>|
|Fairchild|Channel F (channelf)|1976|`channelf`|.bin .chf .zip .7z|**retroarch:** freechaf (default)<br>|
|id Software|Doom (doom)|1993|`doom`|.doom|**gzdoom:** gzdoom-sa (default)<br>|
|Infocom|Z-Machine (zmachine)|1979|`zmachine`|.dat .z1 .z2 .z3 .z4 .z5 .z6 .zip|**retroarch:** mojozork (default)<br>|
|JELOS|Moonlight Game Streaming (moonlight)|2021|`moonlight`|.sh||
|JELOS|MPlayer (mplayer)|unknown|`mplayer`|.mp4 .mkv .avi .mov .wmv .m3u .mpg .ytb .twi .sh .mp3 .aac .mka .dts .flacC .ogg .m4a .ac3 .opusS .wav .wv .eac33 .thd|**mplayer:** mplayer (default)<br>|
|JELOS|Music Player (music)|unknown|`playlists`|.m3u .sh|**gmu:** gmu (default)<br>|
|JELOS|Ports (ports)|2021|`ports`|.sh||
|JELOS|Screenshots (imageviewer)|2021|`screenshots`|.jpg .jpeg .png .bmp .psd .tga .gif .hdr .pic .ppm .pgm .mkv .pdf .mp4 .avi||
|JELOS|Tools (tools)|2021|`modules`|.sh||
|Lexaloffle|PICO-8 (pico-8)|2015|`pico-8`|.sh .p8 .png|**pico-8:** pico8 (default)<br>**retroarch:** fake08<br>|
|Magnavox|Odyssey (odyssey2)|1979|`odyssey`|.bin .zip .7z|**retroarch:** o2em (default)<br>|
|Mattel|Intellivision (intellivision)|1979|`intellivision`|.int .bin .rom .zip .7z|**retroarch:** freeintv (default)<br>|
|Microsoft|MS-DOS (pc)|1981|`pc`|.com .bat .exe .dosz|**retroarch:** dosbox_pure<br>**retroarch:** dosbox_svn<br>|
|Microsoft|MSX (msx)|1983|`msx`|.dsk .mx1 .mx2 .rom .zip .7z .m3u|**retroarch:** bluemsx (default)<br>**retroarch:** fmsx<br>|
|Microsoft|MSX2 (msx2)|1988|`msx2`|.dsk .mx1 .mx2 .rom .zip .7z .m3u|**retroarch:** bluemsx (default)<br>**retroarch:** fmsx<br>|
|Milton Bradley|Vectrex (vectrex)|1982|`vectrex`|.bin .gam .vec .zip .7z|**retroarch:** vecx (default)<br>|
|NEC|PC Engine (pcengine)|1987|`pcengine`|.pce .bin .zip .7z|**retroarch:** beetle_pce_fast (default)<br>**retroarch:** beetle_pce<br>**retroarch:** beetle_supergrafx<br>|
|NEC|PC Engine CD (pcenginecd)|1988|`pcenginecd`|.cue .ccd .chd .toc .m3u|**retroarch:** beetle_pce_fast (default)<br>**retroarch:** beetle_pce<br>**retroarch:** beetle_supergrafx<br>|
|NEC|PC-8800 (pc-8800)|1981|`pc88`|.d88 .m3u|**retroarch:** quasi88 (default)<br>|
|NEC|PC-9800 (pc-9800)|1983|`pc98`|.d98 .zipd .fdi .fdd .2hd .tfd .d88d .hdm .xdf .dup .hdi .thd .nhd .hdd .hdn|**retroarch:** np2kai (default)<br>|
|NEC|PC-FX (pcfx)|1994|`pcfx`|.chd .cue .ccd .toc|**retroarch:** beetle_pcfx (default)<br>|
|NEC|Super Grafx (supergrafx)|1989|`sgfx`|.pce .sgx .cue .ccd .chd .zip .7z|**retroarch:** beetle_supergrafx<br>**retroarch:** beetle_pce<br>|
|NEC|TurboGrafx-16 (tg16)|1989|`tg16`|.pce .bin .zip .7z|**retroarch:** beetle_pce_fast (default)<br>**retroarch:** beetle_pce<br>**retroarch:** beetle_supergrafx<br>|
|NEC|TurboGrafx-CD (tg16cd)|1989|`tg16cd`|.cue .ccd .chd .toc .m3u|**retroarch:** beetle_pce_fast (default)<br>**retroarch:** beetle_pce<br>**retroarch:** beetle_supergrafx<br>|
|Nesbox|TIC-80 (tic-80)|2017|`tic-80`|.tic|**retroarch:** tic80 (default)<br>|
|Nintendo|DS (nds)|2005|`nds`|.nds .zip .7z|**drastic:** drastic-sa (default)<br>**retroarch:** melonds<br>**melonds:** melonds-sa<br>**retroarch:** desmume<br>|
|Nintendo|Famicom (famicom)|1983|`famicom`|.nes .unifF .unf .zip .7z|**retroarch:** nestopia (default)<br>**retroarch:** fceumm<br>**retroarch:** quicknes<br>**retroarch:** mesen<br>|
|Nintendo|Famicom Disk System (fds)|1986|`fds`|.fds .zip .7z|**retroarch:** nestopia (default)<br>**retroarch:** fceumm<br>**retroarch:** quicknes<br>|
|Nintendo|Game and Watch (gameandwatch)|1980|`gameandwatch`|.mgw .zip .7z|**retroarch:** gw<br>|
|Nintendo|Game Boy (gb)|1989|`gb`|.gb .gbc .zip .7z|**retroarch:** gambatte (default)<br>**retroarch:** sameboy<br>**retroarch:** gearboy<br>**retroarch:** tgbdual<br>**retroarch:** mgba<br>**retroarch:** vbam<br>|
|Nintendo|Game Boy (Hacks) (gbh)|1989|`gbh`|.gb .zip .7z|**retroarch:** gambatte (default)<br>**retroarch:** sameboy<br>**retroarch:** gearboy<br>**retroarch:** tgbdual<br>**retroarch:** mgba<br>**retroarch:** vbam<br>|
|Nintendo|Game Boy Advance (gba)|2001|`gba`|.gba .zip .7z|**retroarch:** mgba (default)<br>**retroarch:** gbsp<br>**retroarch:** vbam<br>**retroarch:** vba_next<br>**retroarch:** beetle_gba<br>**retroarch:** gpsp<br>|
|Nintendo|Game Boy Advance (Hacks) (gbah)|2001|`gbah`|.gba .zip .7z|**retroarch:** mgba (default)<br>**retroarch:** gbsp<br>**retroarch:** vbam<br>**retroarch:** vba_next<br>**retroarch:** beetle_gba<br>|
|Nintendo|Game Boy Color (gbc)|1998|`gbc`|.gb .gbc .zip .7z|**retroarch:** gambatte (default)<br>**retroarch:** sameboy<br>**retroarch:** gearboy<br>**retroarch:** tgbdual<br>**retroarch:** mgba<br>**retroarch:** vbam<br>|
|Nintendo|Game Boy Color (Hacks) (gbch)|1998|`gbch`|.gb .gbc .zip .7z|**retroarch:** gambatte (default)<br>**retroarch:** sameboy<br>**retroarch:** gearboy<br>**retroarch:** tgbdual<br>**retroarch:** mgba<br>**retroarch:** vbam<br>|
|Nintendo|GameCube (gamecube)|2001|`gamecube`|.gcm .iso .gcz .cisoO .wbfsS .rvz .dol|**dolphin:** dolphin-sa-gc (default)<br>**retroarch:** dolphin<br>|
|Nintendo|MSU-1 (snesmsu1)|2012|`snesmsu1`|.smc .fig .sfc .swc .zip .7z|**retroarch:** snes9x (default)<br>**retroarch:** beetle_supafaust<br>|
|Nintendo|N64 (n64)|1996|`n64`|.z64 .n64 .v64 .zip .7z|**retroarch:** mupen64plus_next (default)<br>**retroarch:** mupen64plus<br>**retroarch:** parallel_n64<br>**mupen64plus-sa:** m64p_gliden64<br>**mupen64plus-sa:** m64p_gl64mk2<br>**mupen64plus-sa:** m64p_rice<br>|
|Nintendo|NES (Hacks) (nesh)|1985|`nesh`|.nes .unifF .unf .zip .7z|**retroarch:** nestopia (default)<br>**retroarch:** fceumm<br>**retroarch:** quicknes<br>**retroarch:** mesen<br>|
|Nintendo|NES (nes)|1985|`nes`|.nes .unifF .unf .zip .7z|**retroarch:** nestopia (default)<br>**retroarch:** fceumm<br>**retroarch:** quicknes<br>**retroarch:** mesen<br>|
|Nintendo|Pokémon Mini (pokemini)|2001|`pokemini`|.min .zip .7z|**retroarch:** pokemini (default)<br>|
|Nintendo|Satellaview (satellaview)|1995|`satellaview`|.smc .fig .bs .sfc .bsx .swc .zip .7z|**retroarch:** snes9x (default)<br>**retroarch:** snes9x2010<br>**retroarch:** snes9x2002<br>**retroarch:** snes9x2005_plus<br>|
|Nintendo|Super Famicom (sfc)|1990|`sfc`|.smc .fig .sfc .swc .zip .7z|**retroarch:** snes9x (default)<br>**retroarch:** snes9x2010<br>**retroarch:** snes9x2002<br>**retroarch:** snes9x2005_plus<br>**retroarch:** beetle_supafaust<br>**retroarch:** bsnes<br>**retroarch:** bsnes_mercury_performance<br>**retroarch:** bsnes_hd_beta<br>|
|Nintendo|Super Nintendo (Hacks) (snesh)|1991|`snesh`|.smc .fig .sfc .swc .zip .7z|**retroarch:** snes9x (default)<br>**retroarch:** snes9x2010<br>**retroarch:** snes9x2002<br>**retroarch:** snes9x2005_plus<br>**retroarch:** beetle_supafaust<br>**retroarch:** bsnes<br>**retroarch:** bsnes_mercury_performance<br>**retroarch:** bsnes_hd_beta<br>|
|Nintendo|Super Nintendo (snes)|1991|`snes`|.smc .fig .sfc .swc .zip .7z|**retroarch:** snes9x (default)<br>**retroarch:** snes9x2010<br>**retroarch:** snes9x2002<br>**retroarch:** snes9x2005_plus<br>**retroarch:** beetle_supafaust<br>**retroarch:** bsnes<br>**retroarch:** bsnes_mercury_performance<br>**retroarch:** bsnes_hd_beta<br>|
|Nintendo|Virtual Boy (virtualboy)|1995|`virtualboy`|.vb .zip .7z|**retroarch:** beetle_vb (default)<br>|
|Nintendo|Wii (wii)|2006|`wii`|.gcm .iso .gcz .cisoO .wbfsS .rvz .dol .wad|**dolphin:** dolphin-sa-wii (default)<br>**retroarch:** dolphin<br>|
|Panasonic|3DO (3do)|1993|`3do`|.iso .bin .chd .cue|**retroarch:** opera (default)<br>|
|Philips|VideoPac (videopac)|1978|`videopac`|.bin .zip .7z|**retroarch:** o2em (default)<br>|
|Sammy|Atomiswave (atomiswave)|2003|`atomiswave`|.lst .bin .dat .zip .7z|**flycast:** flycast-sa<br>**retroarch:** flycast (default)<br>|
|Sega|32X (sega32x)|1994|`sega32x`|.32x .smd .bin .md .zip .7z|**retroarch:** picodrive (default)<br>|
|Sega|CD (segacd)|1991|`segacd`|.chd .cue .iso .m3u|**retroarch:** genesis_plus_gx (default)<br>**retroarch:** picodrive<br>|
|Sega|Dreamcast (dreamcast)|1998|`dreamcast`|.cdi .gdi .chd .m3u|**flycast:** flycast-sa<br>**retroarch:** flycast (default)<br>|
|Sega|Game Gear (gamegear)|1990|`gamegear`|.bin .gg .zip .7z|**retroarch:** gearsystem (default)<br>**retroarch:** genesis_plus_gx<br>**retroarch:** picodrive<br>**retroarch:** smsplus<br>|
|Sega|Game Gear (Hacks) (ggh)|1990|`gamegearh`|.bin .gg .zip .7z|**retroarch:** gearsystem (default)<br>**retroarch:** genesis_plus_gx<br>**retroarch:** picodrive<br>**retroarch:** smsplus<br>|
|Sega|Genesis (genesis)|1989|`genesis`|.bin .gen .md .sg .smd .zip .7z|**retroarch:** genesis_plus_gx (default)<br>**retroarch:** genesis_plus_gx_wide<br>**retroarch:** picodrive<br>|
|Sega|Genesis (Hacks) (genh)|1989|`genh`|.bin .gen .md .sg .smd .zip .7z|**retroarch:** genesis_plus_gx (default)<br>**retroarch:** genesis_plus_gx_wide<br>**retroarch:** picodrive<br>|
|Sega|Master System (mastersystem)|1985|`mastersystem`|.bin .sms .zip .7z|**retroarch:** gearsystem (default)<br>**retroarch:** genesis_plus_gx<br>**retroarch:** picodrive<br>**retroarch:** smsplus<br>|
|Sega|Mega Drive (megadrive)|1990|`megadrive`|.bin .gen .md .sg .smd .zip .7z|**retroarch:** genesis_plus_gx (default)<br>**retroarch:** genesis_plus_gx_wide<br>**retroarch:** picodrive<br>|
|Sega|Mega Drive (megadrive-japan)|1988|`megadrive-japan`|.bin .gen .md .sg .smd .zip .7z|**retroarch:** genesis_plus_gx (default)<br>**retroarch:** genesis_plus_gx_wide<br>**retroarch:** picodrive<br>|
|Sega|Mega-CD (megacd)|1991|`megacd`|.chd .cue .iso .m3u|**retroarch:** genesis_plus_gx (default)<br>**retroarch:** picodrive<br>|
|Sega|Naomi (naomi)|1998|`naomi`|.lst .bin .dat .zip .7z|**flycast:** flycast-sa<br>**retroarch:** flycast (default)<br>|
|Sega|Saturn (saturn)|1994|`saturn`|.cue .chd .iso|**yabasanshiro:** yabasanshiro-sa (default)<br>**retroarch:** yabasanshiro<br>**retroarch:** beetle_saturn<br>|
|Sega|SG-1000 (sg-1000)|1983|`sg-1000`|.bin .sg .zip .7z|**retroarch:** gearsystem (default)<br>**retroarch:** genesis_plus_gx<br>**retroarch:** picodrive<br>|
|Sharp|X1 (x1)|1982|`x1`|.dx1 .2d .2hd .tfd .d88d .hdm .xdf .dup .tap .cmd .zip .7z|**retroarch:** x1 (default)<br>|
|Sharp|x68000 (x68000)|1987|`x68000`|.dim .img .d88d .hdm .dup .2hd .xdf .hdf .cmd .m3u .zip .7z|**retroarch:** px68k (default)<br>|
|Sinclair|ZX Spectrum (zxspectrum)|1982|`zxspectrum`|.tzx .tap .z80 .rzx .scl .trd .dsk .zip .7z|**retroarch:** fuse<br>|
|Sinclair|ZX81 (zx81)|1981|`zx81`|.tzx .p .P .zip .7z|**retroarch:** 81 (default)<br>|
|SNK|Neo Geo (neogeo)|1990|`neogeo`|.7z .zip|**retroarch:** fbneo (default)<br>**retroarch:** mame2003_plus<br>**retroarch:** fbalpha2012<br>**retroarch:** fbalpha2019<br>**retroarch:** mame2010<br>**retroarch:** mame2015<br>**retroarch:** mame<br>|
|SNK|Neo Geo CD (neocd)|1990|`neocd`|.cue .iso .chd|**retroarch:** neocd (default)<br>**retroarch:** fbneo<br>|
|SNK|Neo Geo Pocket (ngp)|1998|`ngp`|.ngc .ngp .zip .7z|**retroarch:** beetle_ngp (default)<br>**retroarch:** race<br>|
|SNK|Neo Geo Pocket Color (ngpc)|1999|`ngpc`|.ngc .zip .7z|**retroarch:** beetle_ngp (default)<br>**retroarch:** race<br>|
|Sony|PlayStation (psx)|1994|`psx`|.bin .cue .img .mdf .pbp .toc .cbn .m3u .ccd .chd .iso|**retroarch:** pcsx_rearmed32 (default)<br>**retroarch:** pcsx_rearmed<br>**retroarch:** beetle_psx<br>**Duckstation:** duckstation-sa<br>**retroarch:** duckstation<br>**retroarch:** swanstation<br>|
|Sony|PlayStation 2 (ps2)|2000|`ps2`|.iso .mdf .nrg .bin .img .dumpP .gz .cso .chd|**aethersx2:** aethersx2-sa (default)<br>|
|Sony|PlayStation Portable (psp)|2004|`psp`|.iso .cso .pbp|**ppsspp:** ppsspp-sa (default)<br>|
|Sony|PSP Minis (pspminis)|2004|`pspminis`|.iso .cso .pbp|**ppsspp:** ppsspp-sa (default)<br>**retroarch:** ppsspp<br>|
|Sun Microsystems|J2ME (j2me)|2002|`j2me`|.jar|**retroarch:** freej2me (default)<br>|
|Various|EasyRPG (easyrpg)|2003|`easyrpg`|.zip .easyrpgYRPG .ldb|**retroarch:** easyrpg (default)<br>|
|Various|OpenBOR (openbor)|2008|`openbor`|.pak|**OpenBOR:** OpenBOR (default)<br>|
|Various|ScummVM (scummvm)|2001|`games`|.sh .svm .scummvm|**scummvmsa:** scummvm (default)<br>**retroarch:** scummvm<br>|
|Watara|Supervision (supervision)|1992|`supervision`|.sv .zip .7z|**retroarch:** potator (default)<br>|
|Welback Holdings|Mega Duck (megaduck)|1993|`megaduck`|.bin .zip .7z|**retroarch:** sameduck (default)<br>|
