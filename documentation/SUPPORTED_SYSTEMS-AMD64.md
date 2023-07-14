&nbsp;&nbsp;<img src="https://raw.githubusercontent.com/JustEnoughLinuxOS/distribution/dev/distributions/JELOS/logos/jelos-logo.png" width=192>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Latest Version](https://img.shields.io/github/release/JustEnoughLinuxOS/distribution.svg?color=5998FF&label=latest%20version&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/releases/latest) [![Activity](https://img.shields.io/github/commit-activity/m/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/commits) [![Pull Requests](https://img.shields.io/github/issues-pr-closed/JustEnoughLinuxOS/distribution?color=5998FF&style=flat-square)](https://github.com/JustEnoughLinuxOS/distribution/pulls) [![Discord Server](https://img.shields.io/discord/948029830325235753?color=5998FF&label=chat&style=flat-square)](https://discord.gg/seTxckZjJy)
#

# Supported Systems Emulators and Cores
This document describes all available systems emulators and cores available for the device.

|Manufacturer|System|Release Date|Games Path|Supported Extensions|Emulator / Core|
|----|----|----|----|----|----|
|Panasonic|3DO (3do)|1993|/storage/roms/3do|.iso .ISO .bin .BIN .chd .CHD .cue .CUE|<p>retroarch: opera</p>|
|Nintendo|3DS (3ds)|2010|/storage/roms/3ds|.3ds .3DS .3dsx .3DSX .elf .ELF .axf .AXF .cci .CCI .cxi .CXI .app .APP|<p>retroarch: citra</p><p>citra: citra-sa</p>|
|Commodore|Amiga (amiga)|1985|/storage/roms/amiga|.zip .ZIP .adf .ADF .uae .UAE .ipf .IPF .dms .DMS .adz .ADZ .lha .LHA .m3u .M3U .hdf .HDF .hdz .HDZ|<p>retroarch: puae</p>|
|Commodore|Amiga CD32 (amigacd32)|1994|/storage/roms/amigacd32|.iso .ISO .cue .CUE .lha .LHA .chd .CHD|<p>retroarch: puae</p>|
|Amstrad|CPC (amstradcpc)|1984|/storage/roms/amstradcpc|.dsk .DSK .sna .SNA .tap .TAP .cdt .CDT .kcr .KCR .voc .VOC .m3u .M3U .zip .ZIP .7z .7Z|<p>retroarch: crocods</p><p>retroarch: cap32</p>|
|Arcade|Arcade (arcade)|1984|/storage/roms/arcade|.zip .ZIP .7z .7Z|<p>retroarch: mame2003_plus</p><p>retroarch: mame2000</p><p>retroarch: mame2010</p><p>retroarch: mame2015</p><p>retroarch: fbneo</p><p>retroarch: fbalpha2012</p><p>retroarch: fbalpha2019</p><p>retroarch: mame</p>|
|Atari|2600 (atari2600)|1977|/storage/roms/atari2600|.a26 .A26 .bin .BIN .zip .ZIP .7z .7Z|<p>retroarch: stella</p>|
|Atari|5200 (atari5200)|1982|/storage/roms/atari5200|.rom .ROM .xfd .XFD .atr .ATR .atx .ATX .cdm .CDM .cas .CAS .car .CAR .bin .BIN .a52 .A52 .xex .XEX .zip .ZIP .7z .7Z|<p>retroarch: a5200</p><p>retroarch: atari800</p>|
|Atari|7800 (atari7800)|1986|/storage/roms/atari7800|.a78 .A78 .bin .BIN .zip .ZIP .7z .7Z|<p>retroarch: prosystem</p>|
|Atari|Atari 800 (atari800)|1979|/storage/roms/atari800|.rom .ROM .xfd .XFD .atr .ATR .atx .ATX .cdm .CDM .cas .CAS .car .CAR .bin .BIN .a52 .A52 .xex .XEX .zip .ZIP .7z .7Z|<p>retroarch: atari800</p>|
|Atari|Jaguar (atarijaguar)|1993|/storage/roms/atarijaguar|.j64 .J64 .jag .JAG .rom .ROM .abs .ABS .cof .COF .bin .BIN .prg .PRG|<p>retroarch: virtualjaguar</p>|
|Atari|Lynx (atarilynx)|1989|/storage/roms/atarilynx|.lnx .LNX .o .O .zip .ZIP .7z .7Z|<p>retroarch: handy</p><p>retroarch: beetle_lynx</p>|
|Atari|Atari ST (atarist)|1985|/storage/roms/atarist|.st .ST .msa .MSA .stx .STX .dim .DIM .ipf .IPF .m3u .M3U .zip .ZIP .7z .7Z|<p>retroarch: hatari</p><p>hatarisa: hatarisa</p>|
|Sammy|Atomiswave (atomiswave)|2003|/storage/roms/atomiswave|.lst .LST .bin .BIN .dat .DAT .zip .ZIP .7z .7Z|<p>retroarch: flycast</p><p>flycast: flycast-sa</p>|
|Commodore|C128 (c128)|1985|/storage/roms/c128|.d64 .D64 .d71 .D71 .d80 .D80 .d81 .D81 .d82 .D82 .g64 .G64 .g41 .G41 .x64 .X64 .t64 .T64 .tap .TAP .prg .PRG .p00 .P00 .crt .CRT .bin .BIN .d6z .D6Z .d7z .D7Z .d8z .D8Z .g6z .G6Z .g4z .G4Z .x6z .X6Z .cmd .CMD .m3u .M3U .vsf .VSF .nib .NIB .nbz .NBZ .zip .ZIP|<p>retroarch: vice_x128</p><p>vicesa: x128</p>|
|Commodore|C16 (c16)|1984|/storage/roms/c16|.d64 .D64 .d71 .D71 .d80 .D80 .d81 .D81 .d82 .D82 .g64 .G64 .g41 .G41 .x64 .X64 .t64 .T64 .tap .TAP .prg .PRG .p00 .P00 .crt .CRT .bin .BIN .d6z .D6Z .d7z .D7Z .d8z .D8Z .g6z .G6Z .g4z .G4Z .x6z .X6Z .cmd .CMD .m3u .M3U .vsf .VSF .nib .NIB .nbz .NBZ .zip .ZIP|<p>retroarch: vice_xplus4</p><p>vicesa: xplus4</p>|
|Commodore|C64 (c64)|1982|/storage/roms/c64|.d64 .D64 .d71 .D71 .d80 .D80 .d81 .D81 .d82 .D82 .g64 .G64 .g41 .G41 .x64 .X64 .t64 .T64 .tap .TAP .prg .PRG .p00 .P00 .crt .CRT .bin .BIN .d6z .D6Z .d7z .D7Z .d8z .D8Z .g6z .G6Z .g4z .G4Z .x6z .X6Z .cmd .CMD .m3u .M3U .vsf .VSF .nib .NIB .nbz .NBZ .zip .ZIP|<p>retroarch: vice_x64</p><p>vicesa: x64sc</p>|
|Fairchild|Channel F (channelf)|1976|/storage/roms/channelf|.bin .BIN .chf .CHF .zip .ZIP .7z .7Z|<p>retroarch: freechaf</p>|
|Coleco|ColecoVision (colecovision)|1982|/storage/roms/coleco|.bin .BIN .col .COL .rom .ROM .zip .ZIP .7z .7Z|<p>retroarch: bluemsx</p><p>retroarch: gearcoleco</p><p>retroarch: smsplus</p>|
|Capcom|PlaySystem 1 (cps1)|1988|/storage/roms/cps1|.zip .ZIP .7z .7Z|<p>retroarch: fbneo</p><p>retroarch: mame2003_plus</p><p>retroarch: mame2010</p><p>retroarch: fbalpha2012</p><p>retroarch: mba_mini</p>|
|Capcom|PlaySystem 2 (cps2)|1993|/storage/roms/cps2|.zip .ZIP .7z .7Z|<p>retroarch: fbneo</p><p>retroarch: mame2003_plus</p><p>retroarch: mame2010</p><p>retroarch: fbalpha2012</p><p>retroarch: mba_mini</p>|
|Capcom|PlaySystem 3 (cps3)|1996|/storage/roms/cps3|.zip .ZIP .7z .7Z|<p>retroarch: fbneo</p><p>retroarch: mame2003_plus</p><p>retroarch: mame2010</p><p>retroarch: fbalpha2012</p><p>retroarch: mba_mini</p>|
|Arcade|Daphne (daphne)|1996|/storage/roms/daphne|.daphne .DAPHNE .zip .ZIP|<p>hypseus: hypseus</p><p>retroarch: daphne</p>|
|id Software|Doom (doom)|1993|/storage/roms/doom|.doom|<p>gzdoom: gzdoom-sa</p>|
|Sega|Dreamcast (dreamcast)|1998|/storage/roms/dreamcast|.cdi .CDI .gdi .GDI .chd .CHD .m3u .M3U|<p>retroarch: flycast2021</p><p>retroarch: flycast</p><p>flycast: flycast-sa</p>|
|Various|EasyRPG (easyrpg)|2003|/storage/roms/easyrpg|.zip .ZIP .easyrpg .EASYRPG .ldb .LDB|<p>retroarch: easyrpg</p>|
|Nintendo|Famicom (famicom)|1983|/storage/roms/famicom|.nes .NES .unif .UNIF .unf .UNF .zip .ZIP .7z .7Z|<p>retroarch: nestopia</p><p>retroarch: fceumm</p><p>retroarch: quicknes</p><p>retroarch: mesen</p>|
|Arcade|Final Burn Neo (fbn)|1986|/storage/roms/fbneo|.7z .zip .7Z .ZIP|<p>retroarch: fbneo</p><p>retroarch: mame2003_plus</p><p>retroarch: mame2010</p><p>retroarch: mame2015</p><p>retroarch: mame</p><p>retroarch: fbalpha2012</p><p>retroarch: fbalpha2019</p>|
|Nintendo|Famicom Disk System (fds)|1986|/storage/roms/fds|.fds .FDS .zip .ZIP .7z .7Z|<p>retroarch: nestopia</p><p>retroarch: fceumm</p><p>retroarch: quicknes</p>|
|Nintendo|Game and Watch (gameandwatch)|1980|/storage/roms/gameandwatch|.mgw .MGW .zip .ZIP .7z .7Z|<p>retroarch: gw</p>|
|Nintendo|GameCube (gamecube)|2001|/storage/roms/gamecube|.gcm .GCM .iso .ISO .gcz .GCZ .ciso .CISO .wbfs .WBFS .rvz .RVZ .dol .DOL|<p>dolphin: dolphin-sa-gc</p><p>primehack: primehack</p><p>retroarch: dolphin</p>|
|Sega|Game Gear (gamegear)|1990|/storage/roms/gamegear|.bin .BIN .gg .GG .zip .ZIP .7z .7Z|<p>retroarch: gearsystem</p><p>retroarch: genesis_plus_gx</p><p>retroarch: picodrive</p><p>retroarch: smsplus</p>|
|Nintendo|Game Boy (gb)|1989|/storage/roms/gb|.gb .GB .gbc .GBC .zip .ZIP .7z .7Z|<p>retroarch: gambatte</p><p>retroarch: sameboy</p><p>retroarch: gearboy</p><p>retroarch: tgbdual</p><p>retroarch: mgba</p><p>retroarch: vbam</p>|
|Nintendo|Game Boy Advance (gba)|2001|/storage/roms/gba|.gba .GBA .zip .ZIP .7z .7Z|<p>retroarch: mgba</p><p>retroarch: gbsp</p><p>retroarch: vbam</p><p>retroarch: vba_next</p><p>retroarch: beetle_gba</p>|
|Nintendo|Game Boy Advance (Hacks) (gbah)|2001|/storage/roms/gbah|.gba .GBA .zip .ZIP .7z .7Z|<p>retroarch: mgba</p><p>retroarch: gbsp</p><p>retroarch: vbam</p><p>retroarch: vba_next</p><p>retroarch: beetle_gba</p>|
|Nintendo|Game Boy Color (gbc)|1998|/storage/roms/gbc|.gb .GB .gbc .GBC .zip .ZIP .7z .7Z|<p>retroarch: gambatte</p><p>retroarch: sameboy</p><p>retroarch: gearboy</p><p>retroarch: tgbdual</p><p>retroarch: mgba</p><p>retroarch: vbam</p>|
|Nintendo|Game Boy Color (Hacks) (gbch)|1998|/storage/roms/gbch|.gb .GB .gbc .GBC .zip .ZIP .7z .7Z|<p>retroarch: gambatte</p><p>retroarch: sameboy</p><p>retroarch: gearboy</p><p>retroarch: tgbdual</p><p>retroarch: mgba</p><p>retroarch: vbam</p>|
|Nintendo|Game Boy (Hacks) (gbh)|1989|/storage/roms/gbh|.gb .GB .zip .ZIP .7z .7Z|<p>retroarch: gambatte</p><p>retroarch: sameboy</p><p>retroarch: gearboy</p><p>retroarch: tgbdual</p><p>retroarch: mgba</p><p>retroarch: vbam</p>|
|Sega|Genesis (genesis)|1989|/storage/roms/genesis|.bin .BIN .gen .GEN .md .MD .sg .SG .smd .SMD .zip .ZIP .7z .7Z|<p>retroarch: genesis_plus_gx</p><p>retroarch: genesis_plus_gx_wide</p><p>retroarch: picodrive</p>|
|Sega|Genesis (Hacks) (genh)|1989|/storage/roms/genh|.bin .BIN .gen .GEN .md .MD .sg .SG .smd .SMD .zip .ZIP .7z .7Z|<p>retroarch: genesis_plus_gx</p><p>retroarch: genesis_plus_gx_wide</p><p>retroarch: picodrive</p>|
|Sega|Game Gear (Hacks) (ggh)|1990|/storage/roms/gamegearh|.bin .BIN .gg .GG .zip .ZIP .7z .7Z|<p>retroarch: gearsystem</p><p>retroarch: genesis_plus_gx</p><p>retroarch: picodrive</p><p>retroarch: smsplus</p>|
|JELOS|Screenshots (imageviewer)|2021|/storage/roms/screenshots|.jpg .jpeg .png .bmp .psd .tga .gif .hdr .pic .ppm .pgm .mkv .pdf .mp4 .avi||
|Mattel|Intellivision (intellivision)|1979|/storage/roms/intellivision|.int .INT .bin .BIN .rom .ROM .zip .ZIP .7z .7Z|<p>retroarch: freeintv</p>|
|Sun Microsystems|J2ME (j2me)|2002|/storage/roms/j2me|.jar .JAR|<p>retroarch: freej2me</p>|
|Arcade|MAME (mame)|1989|/storage/roms/mame|.7z .7Z .zip .ZIP|<p>retroarch: mame2003_plus</p><p>retroarch: mame2010</p><p>retroarch: mame2015</p><p>retroarch: mame</p><p>retroarch: fbneo</p><p>retroarch: fbalpha2012</p><p>retroarch: fbalpha2019</p>|
|Sega|Master System (mastersystem)|1985|/storage/roms/mastersystem|.bin .BIN .sms .SMS .zip .ZIP .7z .7Z|<p>retroarch: gearsystem</p><p>retroarch: genesis_plus_gx</p><p>retroarch: picodrive</p><p>retroarch: smsplus</p>|
|Sega|Mega-CD (megacd)|1991|/storage/roms/megacd|.chd .CHD .cue .CUE .iso .ISO .m3u .M3U|<p>retroarch: genesis_plus_gx</p><p>retroarch: picodrive</p>|
|Sega|Mega Drive (megadrive)|1990|/storage/roms/megadrive|.bin .BIN .gen .GEN .md .MD .sg .SG .smd .SMD .zip .ZIP .7z .7Z|<p>retroarch: genesis_plus_gx</p><p>retroarch: genesis_plus_gx_wide</p><p>retroarch: picodrive</p>|
|Sega|Mega Drive (megadrive-japan)|1988|/storage/roms/megadrive-japan|.bin .BIN .gen .GEN .md .MD .sg .SG .smd .SMD .zip .ZIP .7z .7Z|<p>retroarch: genesis_plus_gx</p><p>retroarch: genesis_plus_gx_wide</p><p>retroarch: picodrive</p>|
|Welback Holdings|Mega Duck (megaduck)|1993|/storage/roms/megaduck|.bin .BIN .zip .ZIP .7z .7Z|<p>retroarch: sameduck</p>|
|JELOS|Moonlight Game Streaming (moonlight)|2021|/storage/roms/moonlight/|.sh .SH||
|JELOS|MPlayer (mplayer)|unknown|/storage/roms/mplayer|.mp4 .MP4 .mkv .MKV .avi .AVI .mov .MOV .wmv .WMV .m3u .M3U .mpg .MPG .ytb .YTB .twi .TWI .sh .SH .mp3 .MP3 .aac .AAC .mka .MKA .dts .DTS .flac .FLAC .ogg .OGG .m4a .M4A .ac3 .AC3 .opus .OPUS .wav .WAV .wv .WV .eac3 .EAC3 .thd .THD|<p>mplayer: mplayer</p>|
|Microsoft|MSX (msx)|1983|/storage/roms/msx|.dsk .DSK .mx1 .MX1 .mx2 .MX2 .rom .ROM .zip .ZIP .7z .7Z .M3U .m3u|<p>retroarch: bluemsx</p><p>retroarch: fmsx</p>|
|Microsoft|MSX2 (msx2)|1988|/storage/roms/msx2|.dsk .DSK .mx1 .MX1 .mx2 .MX2 .rom .ROM .zip .ZIP .7z .7Z .M3U .m3u|<p>retroarch: bluemsx</p><p>retroarch: fmsx</p>|
|Nintendo|N64 (n64)|1996|/storage/roms/n64|.z64 .Z64 .n64 .N64 .v64 .V64 .zip .ZIP .7z .7Z|<p>retroarch: mupen64plus_next</p><p>retroarch: mupen64plus</p><p>retroarch: parallel_n64</p><p>mupen64plus-sa: m64p_gliden64</p><p>mupen64plus-sa: m64p_gl64mk2</p><p>mupen64plus-sa: m64p_rice</p>|
|Sega|Naomi (naomi)|1998|/storage/roms/naomi|.lst .LST .bin .BIN .dat .DAT .zip .ZIP .7z .7Z|<p>retroarch: flycast2021</p><p>retroarch: flycast</p><p>flycast: flycast-sa</p>|
|Nintendo|DS (nds)|2005|/storage/roms/nds|.nds .zip .NDS .ZIP .7z|<p>retroarch: melonds</p><p>retroarch: desmume</p><p>melonds: melonds-sa</p>|
|SNK|Neo Geo CD (neocd)|1990|/storage/roms/neocd|.cue .CUE .iso .ISO .chd .CHD|<p>retroarch: neocd</p><p>retroarch: fbneo</p>|
|SNK|Neo Geo (neogeo)|1990|/storage/roms/neogeo|.7z .7Z .zip .ZIP|<p>retroarch: fbneo</p><p>retroarch: mame2003_plus</p><p>retroarch: fbalpha2012</p><p>retroarch: fbalpha2019</p><p>retroarch: mame2010</p><p>retroarch: mame2015</p><p>retroarch: mame</p>|
|Nintendo|NES (nes)|1985|/storage/roms/nes|.nes .NES .unif .UNIF .unf .UNF .zip .ZIP .7z .7Z|<p>retroarch: nestopia</p><p>retroarch: fceumm</p><p>retroarch: quicknes</p><p>retroarch: mesen</p>|
|Nintendo|NES (Hacks) (nesh)|1985|/storage/roms/nesh|.nes .NES .unif .UNIF .unf .UNF .zip .ZIP .7z .7Z|<p>retroarch: nestopia</p><p>retroarch: fceumm</p><p>retroarch: quicknes</p><p>retroarch: mesen</p>|
|SNK|Neo Geo Pocket (ngp)|1998|/storage/roms/ngp|.ngc .NGC .ngp .NGP .zip .ZIP .7z .7Z|<p>retroarch: beetle_ngp</p><p>retroarch: race</p>|
|SNK|Neo Geo Pocket Color (ngpc)|1999|/storage/roms/ngpc|.ngc .NGC .zip .ZIP .7z .7Z|<p>retroarch: beetle_ngp</p><p>retroarch: race</p>|
|Magnavox|Odyssey (odyssey2)|1979|/storage/roms/odyssey|.bin .BIN .zip .ZIP .7z .7Z|<p>retroarch: o2em</p>|
|Various|OpenBOR (openbor)|2008|/storage/roms/openbor|.pak .PAK|<p>OpenBOR: OpenBOR</p>|
|Microsoft|MS-DOS (pc)|1981|/storage/roms/pc|.com .COM .bat .BAT .exe .EXE .dosz .DOSZ|<p>retroarch: dosbox_pure</p><p>retroarch: dosbox_svn</p>|
|NEC|PC-8800 (pc-8800)|1981|/storage/roms/pc88|.d88 .D88 .m3u .M3U|<p>retroarch: quasi88</p>|
|NEC|PC-9800 (pc-9800)|1983|/storage/roms/pc98|.d98 .zip .98d .fdi .fdd .2hd .tfd .d88 .88d .hdm .xdf .dup .hdi .thd .nhd .hdd .hdn|<p>retroarch: np2kai</p>|
|NEC|PC Engine (pcengine)|1987|/storage/roms/pcengine|.pce .PCE .bin .BIN .zip .ZIP .7z .7Z|<p>retroarch: beetle_pce_fast</p><p>retroarch: beetle_pce</p><p>retroarch: beetle_supergrafx</p>|
|NEC|PC Engine CD (pcenginecd)|1988|/storage/roms/pcenginecd|.cue .CUE .ccd .CCD .chd .CHD .toc .TOC .m3u .M3U|<p>retroarch: beetle_pce_fast</p><p>retroarch: beetle_pce</p><p>retroarch: beetle_supergrafx</p>|
|NEC|PC-FX (pcfx)|1994|/storage/roms/pcfx|.chd .CHD .cue .CUE .ccd .CCD .toc .TOC|<p>retroarch: beetle_pcfx</p>|
|Commodore|Commodore PET (pet)|1977|/storage/roms/pet|.20 .40 .60 .a0 .b0 .d64 .d71 .d80 .d81 .d82 .g64 .g41 .x64 .t64 .tap .prg .p00 .crt .bin .gz .d6z .d7z .d8z .g6z .g4z .x6z .cmd .m3u .vsf .nib .nbz .zip|<p>retroarch: vice_xpet</p>|
|Lexaloffle|PICO-8 (pico-8)|2015|/storage/roms/pico-8|.sh .p8 .png .SH .P8 .PNG|<p>pico-8: pico8</p><p>retroarch: fake08</p>|
|Nintendo|Pokémon Mini (pokemini)|2001|/storage/roms/pokemini|.min .MIN .zip .ZIP .7z .7Z|<p>retroarch: pokemini</p>|
|JELOS|Ports (ports)|2021|/storage/roms/ports|.sh .SH||
|Sony|PlayStation 2 (ps2)|2000|/storage/roms/ps2|.iso .ISO .mdf .MDF .nrg .NRG .bin .BIN .img .IMG .dump .DUMP .gz .GZ .cso .CSO .chd .CHD|<p>retroarch: pcsx2</p><p>pcsx2: pcsx2-sa</p>|
|Sony|PlayStation 3 (ps3)|2006|/storage/roms/ps3|.ps3 .PS3 .bin .BIN|<p>rpcs3: rpcs3-sa</p>|
|Sony|PlayStation Portable (psp)|2004|/storage/roms/psp|.iso .ISO .cso .CSO .pbp .PBP|<p>ppsspp: ppsspp-sa</p><p>retroarch: ppsspp</p>|
|Sony|PSP Minis (pspminis)|2004|/storage/roms/pspminis|.iso .ISO .cso .CSO .pbp .PBP|<p>ppsspp: ppsspp-sa</p><p>retroarch: ppsspp</p>|
|Sony|PlayStation (psx)|1994|/storage/roms/psx|.bin .BIN .cue .CUE .img .IMG .mdf .MDF .pbp .PBP .toc .TOC .cbn .CBN .m3u .M3U .ccd .CCD .chd .CHD .iso .ISO|<p>retroarch: beetle_psx</p><p>Duckstation: duckstation-sa</p><p>retroarch: duckstation</p><p>retroarch: swanstation</p>|
|Nintendo|Satellaview (satellaview)|1995|/storage/roms/satellaview|.smc .SMC .fig .FIG .bs .BS .sfc .SFC .bsx .BSX .swc .SWC .zip .ZIP .7z .7Z|<p>retroarch: snes9x</p><p>retroarch: snes9x2010</p><p>retroarch: snes9x2002</p><p>retroarch: snes9x2005_plus</p>|
|Sega|Saturn (saturn)|1994|/storage/roms/saturn|.cue .CUE .chd .CHD .iso .ISO|<p>retroarch: yabasanshiro</p><p>retroarch: beetle_saturn</p>|
|Various|ScummVM (scummvm)|2001|/storage/.config/scummvm/games|.sh .SH .svm .SVM .scummvm|<p>scummvmsa: scummvm</p><p>retroarch: scummvm</p>|
|Sega|32X (sega32x)|1994|/storage/roms/sega32x|.32x .32X .smd .SMD .bin .BIN .md .MD .zip .ZIP .7z .7Z|<p>retroarch: picodrive</p>|
|Sega|CD (segacd)|1991|/storage/roms/segacd|.chd .CHD .cue .CUE .iso .ISO .m3u .M3U|<p>retroarch: genesis_plus_gx</p><p>retroarch: picodrive</p>|
|Nintendo|Super Famicom (sfc)|1990|/storage/roms/sfc|.smc .SMC .fig .FIG .sfc .SFC .swc .SWC .zip .ZIP .7z .7Z|<p>retroarch: snes9x</p><p>retroarch: snes9x2010</p><p>retroarch: snes9x2002</p><p>retroarch: snes9x2005_plus</p><p>retroarch: beetle_supafaust</p><p>retroarch: bsnes</p><p>retroarch: bsnes_mercury_performance</p><p>retroarch: bsnes_hd_beta</p>|
|Sega|SG-1000 (sg-1000)|1983|/storage/roms/sg-1000|.bin .BIN .sg .SG .zip .ZIP .7z .7Z|<p>retroarch: gearsystem</p><p>retroarch: genesis_plus_gx</p><p>retroarch: picodrive</p>|
|Nintendo|Super Nintendo (snes)|1991|/storage/roms/snes|.smc .SMC .fig .FIG .sfc .SFC .swc .SWC .zip .ZIP .7z .7Z|<p>retroarch: snes9x</p><p>retroarch: snes9x2010</p><p>retroarch: snes9x2002</p><p>retroarch: snes9x2005_plus</p><p>retroarch: beetle_supafaust</p><p>retroarch: bsnes</p><p>retroarch: bsnes_mercury_performance</p><p>retroarch: bsnes_hd_beta</p>|
|Nintendo|Super Nintendo (Hacks) (snesh)|1991|/storage/roms/snesh|.smc .SMC .fig .FIG .sfc .SFC .swc .SWC .zip .ZIP .7z .7Z|<p>retroarch: snes9x</p><p>retroarch: snes9x2010</p><p>retroarch: snes9x2002</p><p>retroarch: snes9x2005_plus</p><p>retroarch: beetle_supafaust</p><p>retroarch: bsnes</p><p>retroarch: bsnes_mercury_performance</p><p>retroarch: bsnes_hd_beta</p>|
|Nintendo|MSU-1 (snesmsu1)|2012|/storage/roms/snesmsu1|.smc .SMC .fig .FIG .sfc .SFC .swc .SWC .zip .ZIP .7z .7Z|<p>retroarch: snes9x</p><p>retroarch: beetle_supafaust</p>|
|Bandai|SuFami Turbo (sufami)|1996|/storage/roms/sufami|.st .ST .zip .ZIP .7z .7Z|<p>retroarch: snes9x</p>|
|NEC|Super Grafx (supergrafx)|1989|/storage/roms/sgfx|.pce .PCE .sgx .SGX .cue .CUE .ccd .CCD .chd .CHD .zip .ZIP .7z .7Z|<p>retroarch: beetle_supergrafx</p><p>retroarch: beetle_pce</p>|
|Watara|Supervision (supervision)|1992|/storage/roms/supervision|.sv .SV .zip .ZIP .7z .7Z|<p>retroarch: potator</p>|
|Nintendo|switch (switch)|2017|/storage/roms/switch|.xci .XCI .nsp .NSP .nca .NCA .nso .NSO .nro .NRO|<p>yuzu: yuzu-sa</p><p>ryujinx: ryujinx-sa</p>|
|NEC|TurboGrafx-16 (tg16)|1989|/storage/roms/tg16|.pce .PCE .bin .BIN .zip .ZIP .7z .7Z|<p>retroarch: beetle_pce_fast</p><p>retroarch: beetle_pce</p><p>retroarch: beetle_supergrafx</p>|
|NEC|TurboGrafx-CD (tg16cd)|1989|/storage/roms/tg16cd|.cue .CUE .ccd .CCD .chd .CHD .toc .TOC .m3u .M3U|<p>retroarch: beetle_pce_fast</p><p>retroarch: beetle_pce</p><p>retroarch: beetle_supergrafx</p>|
|Nesbox|TIC-80 (tic-80)|2017|/storage/roms/tic-80|.tic .TIC|<p>retroarch: tic80</p>|
|JELOS|Tools (tools)|2021|/storage/.config/modules|.sh||
|belogic|Uzebox (uzebox)|2008|/storage/roms/uzebox|.uze .UZE|<p>retroarch: uzem</p>|
|Milton Bradley|Vectrex (vectrex)|1982|/storage/roms/vectrex|.bin .BIN .gam .GAM .vec .VEC .zip .ZIP .7z .7Z|<p>retroarch: vecx</p>|
|Commodore|VIC-20 (vic20)|1980|/storage/roms/vic20|.20 .40 .60 .a0 .A0 .b0 .B0 .d64 .D64 .d71 .D71 .d80 .D80 .d81 .D81 .d82 .D82 .g64 .G64 .g41 .G41 .x64 .X64 .t64 .T64 .tap .TAP .prg .PRG .p00 .P00 .crt .CRT .bin .BIN .gz .GZ .d6z .D6Z .d7z .D7Z .d8z .D8Z .g6z .G6Z .g4z .G4Z .x6z .X6Z .cmd .CMD .m3u .M3U .vsf .VSF .nib .NIB .nbz .NBZ .zip .ZIP|<p>retroarch: vice_xvic</p><p>vicesa: vice_xvic</p>|
|Philips|VideoPac (videopac)|1978|/storage/roms/videopac|.bin .BIN .zip .ZIP .7z .7Z|<p>retroarch: o2em</p>|
|Nintendo|Virtual Boy (virtualboy)|1995|/storage/roms/virtualboy|.vb .VB .zip .ZIP .7z .7Z|<p>retroarch: beetle_vb</p>|
|Nintendo|Wii (wii)|2006|/storage/roms/wii|.gcm .GCM .iso .ISO .gcz .GCZ .ciso .CISO .wbfs .WBFS .rvz .RVZ .dol .DOL .wad .WAD|<p>dolphin: dolphin-sa-wii</p><p>primehack: primehack</p><p>retroarch: dolphin</p>|
|Nintendo|Wii U (wiiu)|2012|/storage/roms/wiiu|.wud .WUD .wux .WUX .wua .WUA|<p>cemu: cemu-sa</p>|
|Bandai|Wonderswan (wonderswan)|1999|/storage/roms/wonderswan|.ws .WS .zip .ZIP .7z .7Z|<p>retroarch: beetle_wswan</p>|
|Bandai|Wonderswan Color (wonderswancolor)|2000|/storage/roms/wonderswancolor|.wsc .WSC .zip .ZIP .7z .7Z|<p>retroarch: beetle_wswan</p>|
|Sharp|X1 (x1)|1982|/storage/roms/x1|.dx1 .DX1 .2d .2D .2hd .2HD .tfd .TFD .d88 .D88 .88d .88D .hdm .HDM .xdf .XDF .dup .DUP .tap .TAP .cmd .CMD .zip .ZIP .7z .7Z|<p>retroarch: x1</p>|
|Sharp|x68000 (x68000)|1987|/storage/roms/x68000|.dim .DIM .img .IMG .d88 .D88 .88d .88D .hdm .HDM .dup .DUP .2hd .2HD .xdf .XDF .hdf .HDF .cmd .CMD .m3u .M3U .zip .ZIP .7z .7Z|<p>retroarch: px68k</p>|
|Microsoft|Xbox (xbox)|2001|/storage/roms/xbox|.iso .ISO|<p>xemu: xemu-sa</p>|
|Sinclair|ZX81 (zx81)|1981|/storage/roms/zx81|.tzx .TZX .p .P .zip .ZIP .7z .7Z|<p>retroarch: 81</p>|
|Sinclair|ZX Spectrum (zxspectrum)|1982|/storage/roms/zxspectrum|.tzx .TZX .tap .TAP .z80 .Z80 .rzx .RZX .scl .SCL .trd .TRD .dsk .DSK .zip .ZIP .7z .7Z|<p>retroarch: fuse</p>|
