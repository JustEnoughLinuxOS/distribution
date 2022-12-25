PKG_NAME="vitaquake2"
PKG_VERSION="59053244a03ed0f0976956365e60ca584fa6f162"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/vitaquake2"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Libretro port of VitaQuakeII (Quake 2 engine)"

PKG_IS_ADDON="no"
PKG_TOOLCHAIN="make"
PKG_AUTORECONF="no"

pre_make_target() {
  export BUILD_SYSROOT=${SYSROOT_PREFIX}

  if [[ "${DEVICE}" =~ RG351 ]] || [[ "${DEVICE}" =~ RGB20S ]]
  then
    PKG_MAKE_OPTS_TARGET+=" platform=RK3326"
  elif [[ "${DEVICE}" =~ RG503 ]] || [[ "${DEVICE}" =~ RG353P ]]
  then
    PKG_MAKE_OPTS_TARGET+=" platform=RK3566"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=${DEVICE}"
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp vitaquake2_libretro.so $INSTALL/usr/lib/libretro/
}
