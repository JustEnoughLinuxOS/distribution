# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2022 - Fewtarius

PKG_NAME="emulators"
PKG_LICENSE="Apache-2.0"
PKG_SITE="www.jelos.org"
PKG_SECTION="virtual"
PKG_LONGDESC="Emulation metapackage."

PKG_EMUS="hatarisa openbor hypseus-singe moonlight hypseus-singe pico-8 flycastsa   \
          scummvmsa PPSSPPSDL vicesa lzdoom gzdoom ecwolf raze"

PKG_RETROARCH="retroarch retroarch-overlays retroarch-joypads retroarch-assets libretro-database core-info"

LIBRETRO_CORES="2048 81 a5200 atari800 beetle-gba beetle-lynx beetle-ngp beetle-pce beetle-pce-fast beetle-pcfx      \
                beetle-supafaust beetle-supergrafx beetle-vb beetle-wswan bluemsx cannonball cap32   \
                crocods daphne dinothawr dosbox-svn dosbox-pure easyrpg fbalpha2012                  \
                fbalpha2019 fbneo fceumm fmsx flycast flycast_libretro freechaf freeintv             \
                freej2me fuse-libretro gambatte gearboy gearcoleco gearsystem genesis-plus-gx        \
                genesis-plus-gx-wide gme gw-libretro handy hatari mame2000 mame2003-plus        \
                mame2010 mame2015 mame melonds meowpc98 mgba mrboom mupen64plus mupen64plus-nx       \
                neocd_libretro nestopia np2kai nxengine o2em opera parallel-n64                      \
                picodrive pokemini potator                                              \
                ppsspp prboom prosystem puae px68k quasi88 quicknes race reminiscence sameboy        \
                sameduck scummvm smsplus-gx snes9x snes9x2002 snes9x2005_plus snes9x2010 stella      \
                stella-2014 swanstation TIC-80 tgbdual tyrquake xrick uzem vba-next vbam     \
                vecx vice yabasanshiro xmil mesen virtualjaguar ecwolf_libretro \
                bsnes-mercury-performance duckstation fake08"

PKG_DEPENDS_TARGET="${PKG_EMUS} ${PKG_RETROARCH} ${LIBRETRO_CORES}"

### Emulators or cores for specific devices
case "${DEVICE}" in
  handheld)
    PKG_DEPENDS_TARGET+=" duckstationsa dolphinsa dolphin pcsx2sa lrps2 desmume bsnes citra slang-shaders minivmac minivmacsa play beetle-saturn yuzusa primehack citrasa"
  ;;
esac
