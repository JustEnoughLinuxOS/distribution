PKG_NAME="mupen64plus-sa-rsp-cxd4"
PKG_VERSION="b69e7de60c634619c27aa785e9f59f7b1602818e"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/mupen64plus/mupen64plus-rsp-cxd4"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain libpng SDL2 SDL2_net zlib freetype nasm:host mupen64plus-sa-core"
PKG_SHORTDESC="mupen64plus-rsp-cxd4"
PKG_LONGDESC="Mupen64Plus Standalone RSP CXD4"
PKG_TOOLCHAIN="manual"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

PKG_MAKE_OPTS_TARGET+="HLEVIDEO=1"
# Temporary until we get a vulkan core or simple64
#
# if [ "${VULKAN_SUPPORT}" = "no" ]; then
#   PKG_MAKE_OPTS_TARGET+="HLEVIDEO=1"
# else
#   PKG_MAKE_OPTS_TARGET+="HLEVIDEO=0"
# fi

make_target() {
  case ${DEVICE} in
    AMD64)
      PKG_MAKE_OPTS_TARGET+="USE_GLES=0"
    ;;
  esac

  case ${ARCH} in
    arm|aarch64)
      export HOST_CPU=aarch64
      BINUTILS="$(get_build_dir binutils)/.aarch64-libreelec-linux-gnueabi"
      export USE_GLES=1
      CPPFLAGS="-DUSE_SSE2NEON"
    ;;
  esac
  export APIDIR=$(get_build_dir mupen64plus-sa-core)/.install_pkg/usr/local/include/mupen64plus
  export SDL_CFLAGS="-I${SYSROOT_PREFIX}/usr/include/SDL2 -pthread"
  export SDL_LDLIBS="-lSDL2_net -lSDL2"
  export CROSS_COMPILE="${TARGET_PREFIX}"
  export V=1
  export VC=0
  make -C projects/unix clean
  make -C projects/unix all ${PKG_MAKE_OPTS_TARGET}
}

makeinstall_target() {
  UPREFIX=${INSTALL}/usr/local
  ULIBDIR=${UPREFIX}/lib
  UPLUGINDIR=${ULIBDIR}/mupen64plus
  mkdir -p ${UPLUGINDIR}
  if [ "${DEVICE}" = "AMD64" ]; then
    cp ${PKG_BUILD}/projects/unix/mupen64plus-rsp-cxd4-sse2.so ${UPLUGINDIR}/mupen64plus-rsp-cxd4.so
  else
    cp ${PKG_BUILD}/projects/unix/mupen64plus-rsp-cxd4.so ${UPLUGINDIR}
  fi
  #${STRIP} ${UPLUGINDIR}/mupen64plus-rsp-cxd4.so
  chmod 0644 ${UPLUGINDIR}/mupen64plus-rsp-cxd4.so
}

