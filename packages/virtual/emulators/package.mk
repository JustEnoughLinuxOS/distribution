# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2022 - Fewtarius

PKG_NAME="emulators"
PKG_LICENSE="Apache-2.0"
PKG_SITE="www.jelos.org"
PKG_SECTION="virtual"
PKG_LONGDESC="Emulation metapackage."

PKG_EMUS="hatarisa openbor hypseus-singe moonlight hypseus-singe pico-8 flycastsa   \
          scummvmsa PPSSPPSDL yabasanshiroSA vicesa mupen64plussa-audio-sdl         \
          mupen64plussa-input-sdl mupen64plussa-ui-console mupen64plussa-video-rice \
          mupen64plussa-core mupen64plussa-rsp-hle mupen64plussa-video-glide64mk2   \
          lzdoom gzdoom ecwolf amiberry raze drastic"

PKG_RETROARCH="retroarch retroarch-overlays retroarch-assets common-shaders glsl-shaders \
               libretro-database core-info"

LIBRETRO_CORES="2048 81 a5200 atari800 beetle-gba beetle-lynx beetle-ngp beetle-pce beetle-pce-fast beetle-pcfx      \
                beetle-supafaust beetle-supergrafx beetle-vb beetle-wswan bluemsx cannonball cap32   \
                crocods daphne dinothawr dosbox-svn dosbox-pure duckstation easyrpg fbalpha2012      \
                fbalpha2019 fbneo fceumm fmsx flycast flycast_libretro freechaf freeintv             \
                freej2me fuse-libretro gambatte gearboy gearcoleco gearsystem genesis-plus-gx        \
                genesis-plus-gx-wide gme gpsp gw-libretro handy hatari mame2000 mame2003-plus        \
                mame2010 mame2015 mame melonds meowpc98 mgba mrboom mupen64plus mupen64plus-nx       \
                neocd_libretro nestopia np2kai nxengine o2em opera parallel-n64_rice                 \
                parallel-n64_gln64 parallel-n64_glide64 pcsx_rearmed picodrive pokemini potator      \
                ppsspp prboom prosystem puae px68k quasi88 quicknes race reminiscence sameboy        \
                sameduck scummvm smsplus-gx snes9x snes9x2002 snes9x2005_plus snes9x2010 stella      \
                stella-2014 swanstation TIC-80 tgbdual tyrquake xrick uae4arm uzem vba-next vbam     \
                vecx vice yabasanshiro xmil mesen virtualjaguar ecwolf_libretro vitaquake2           \
                bsnes-mercury-performance"

PKG_DEPENDS_TARGET="${PKG_EMUS} ${PKG_RETROARCH} ${LIBRETRO_CORES}"

### Emulators or cores for specific devices
case "${DEVICE}" in
  RG552)
    PKG_DEPENDS_TARGET+=" duckstationsa"
  ;;
  RG503|RG353P)
    PKG_DEPENDS_TARGET+=" duckstationsa dolphinsa"
  ;;
esac
