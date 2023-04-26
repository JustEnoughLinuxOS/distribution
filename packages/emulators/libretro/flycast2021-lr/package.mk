#UzuCore

PKG_NAME="flycast2021-lr"
PKG_VERSION="4c293f306bc16a265c2d768af5d0cea138426054"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/flycast"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Flycast is a multiplatform Sega Dreamcast emulator "
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-gold"
PKG_PATCH_DIRS+="${DEVICE}"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_MAKE_OPTS_TARGET+=" FORCE_GLES=1"
fi

pre_configure_target() {
  sed -i 's/define CORE_OPTION_NAME "reicast"/define CORE_OPTION_NAME "flycast"/g' core/libretro/libretro_core_option_defines.h 
  PKG_MAKE_OPTS_TARGET="${PKG_MAKE_OPTS_TARGET} ARCH=${TARGET_ARCH} HAVE_OPENMP=1 GIT_VERSION=${PKG_VERSION:0:7}  HAVE_LTCG=0"

}

pre_make_target() {
  export BUILD_SYSROOT=${SYSROOT_PREFIX}
  PKG_MAKE_OPTS_TARGET+=" platform=RK3566"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp flycast_libretro.so ${INSTALL}/usr/lib/libretro/flycast2021_libretro.so
}
