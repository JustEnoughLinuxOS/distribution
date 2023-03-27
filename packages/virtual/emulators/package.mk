# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2022 - Fewtarius

PKG_NAME="emulators"
PKG_LICENSE="Apache-2.0"
PKG_SITE="www.jelos.org"
PKG_SECTION="virtual"
PKG_LONGDESC="Emulation metapackage."

PKG_EMUS="flycast-sa hatarisa hypseus-singe hypseus-singe moonlight openbor pico-8 PPSSPPSDL scummvmsa vicesa"

PKG_RETROARCH="core-info libretro-database retroarch retroarch-assets retroarch-joypads retroarch-overlays     \
              slang-shaders"

LIBRETRO_CORES="2048-lr 81-lr a5200-lr atari800-lr beetle-gba-lr beetle-lynx-lr beetle-ngp-lr beetle-pce-lr    \
                beetle-pce-fast-lr beetle-pcfx-lr bsnes-lr bsnes-mercury-performance-lr beetle-supafaust-lr    \
                beetle-supergrafx-lr beetle-vb-lr beetle-wswan-lr beetle-saturn-lr bluemsx-lr cannonball-lr    \
                cap32-lr crocods-lr daphne-lr dinothawr-lr dosbox-svn-lr dosbox-pure-lr duckstation-lr         \
                easyrpg-lr fake08-lr fbalpha2012-lr fbalpha2019-lr fbneo-lr fceumm-lr fmsx-lr flycast-lr       \
                freechaf-lr freeintv-lr freej2me-lr fuse-lr gambatte-lr gearboy-lr gearcoleco-lr gearsystem-lr \
                genesis-plus-gx-lr genesis-plus-gx-wide-lr gme-lr gw-lr handy-lr hatari-lr mame2000-lr         \
                mame2003-plus-lr mame2010-lr mame2015-lr melonds-lr meowpc98-lr mesen-lr mgba-lr mrboom-lr     \
                mupen64plus-lr mupen64plus-nx-lr neocd_lr nestopia-lr np2kai-lr nxengine-lr o2em-lr opera-lr   \
                parallel-n64-lr pcsx_rearmed-lr picodrive-lr pokemini-lr potator-lr prboom-lr prosystem-lr     \
                ppsspp-lr puae-lr px68k-lr quasi88-lr quicknes-lr race-lr reminiscence-lr sameboy-lr           \
                sameduck-lr scummvm-lr smsplus-gx-lr snes9x-lr snes9x2002-lr snes9x2005_plus-lr snes9x2010-lr  \
                stella-lr stella-2014-lr swanstation-lr TIC-80-lr tgbdual-lr tyrquake-lr uzem-lr vba-next-lr   \
                vbam-lr vecx-lr vice-lr yabasanshiro-lr virtualjaguar-lr xmil-lr xrick-lr"

### Emulators or cores for specific devices
case "${DEVICE}" in
  handheld)
    PKG_EMUS+=" duckstation-sa dolphin-sa cemu-sa citra-sa melonds-sa minivmacsa mupen64plus-sa pcsx2-sa          \
               primehack rpcs3-sa ryujinx-sa xemu-sa yuzu-sa"
    LIBRETRO_CORES+=" beetle-psx-lr bsnes-hd-lr citra-lr desmume-lr dolphin-lr lrps2-lr mame-lr minivmac-lr    \
                     play-lr"
  ;;
  RK3588)
    PKG_EMUS+=" aethersx2-sa duckstation-sa pcsx_rearmed-lr box86 box64 yabasanshiro-sa"
    LIBRETRO_CORES+=" beetle-psx-lr bsnes-hd-lr dolphin-lr mame-lr pcsx_rearmed-lr"
  ;;
  RK3566)
    PKG_DEPENDS_TARGET+=" common-shaders glsl-shaders pcsx_rearmed-lr box86 box64"
    PKG_EMUS+=" yabasanshiro-sa"
  ;;
  OGU)
    PKG_EMUS+=" aethersx2-sa dolphin-sa duckstation-sa"
    LIBRETRO_CORES+=" beetle-psx-lr dolphin-lr"
esac

PKG_DEPENDS_TARGET+=" ${PKG_EMUS} ${PKG_RETROARCH} ${LIBRETRO_CORES}"
