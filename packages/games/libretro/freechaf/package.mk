PKG_NAME="freechaf"
PKG_VERSION="4d1d5cb83b93728a63f03454e472a23055d9bbfc"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/FreeChaF"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="FreeChaF is a libretro emulation core for the Fairchild ChannelF / Video Entertainment System designed to be compatible with joypads from the SNES era forward."
PKG_LONGDESC="FreeChaF is a libretro emulation core for the Fairchild ChannelF / Video Entertainment System designed to be compatible with joypads from the SNES era forward."
PKG_TOOLCHAIN="make"
GET_HANDLER_SUPPORT="git"

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp freechaf_libretro.so $INSTALL/usr/lib/libretro/
}
