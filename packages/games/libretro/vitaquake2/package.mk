PKG_NAME="vitaquake2"
PKG_VERSION="9d67254dd549a72f6aad8d202eff7fe007361422"
PKG_SHA256="a25c0566741131feed926b2246697194a1bb7ad8c5681d8d999aae61fcc43f75"
PKG_ARCH="any"
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

  if [[ "${DEVICE}" =~ RG351 ]]
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
