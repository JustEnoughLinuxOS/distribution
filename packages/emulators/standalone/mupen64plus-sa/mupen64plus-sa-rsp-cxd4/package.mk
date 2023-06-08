PKG_NAME="mupen64plus-sa-rsp-cxd4"
PKG_VERSION="b69e7de60c634619c27aa785e9f59f7b1602818e"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/mupen64plus/mupen64plus-rsp-cxd4"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain libpng SDL2 SDL2_net zlib freetype nasm:host mupen64plus-sa-core mupen64plus-sa-simplecore"
PKG_SHORTDESC="mupen64plus-rsp-cxd4"
PKG_LONGDESC="Mupen64Plus Standalone RSP CXD4"
PKG_TOOLCHAIN="manual"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

PKG_MAKE_OPTS_TARGET+="cxd4VIDEO=1"

make_target() {
  case ${ARCH} in
    arm|aarch64)
      export HOST_CPU=aarch64
      BINUTILS="$(get_build_dir binutils)/.aarch64-libreelec-linux-gnueabi"
      export USE_GLES=1
      CPPFLAGS="-DUSE_SSE2NEON"
    ;;
    x86_64)
      export HOST_CPU=x86_64
      PKG_MAKE_OPTS_TARGET+="USE_GLES=0"
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
  if [ "${DEVICE}" = "AMD64" ]; then
    SUFFIX="-sse2"
  else
    SUFFIX=""
  fi
  cp ${PKG_BUILD}/projects/unix/mupen64plus-rsp-cxd4${SUFFIX}.so ${PKG_BUILD}/projects/unix/mupen64plus-rsp-cxd4-base.so
  APIDIR=$(get_build_dir mupen64plus-sa-simplecore)/.install_pkg/usr/local/include/mupen64plus
  make -C projects/unix clean
  make -C projects/unix all ${PKG_MAKE_OPTS_TARGET}
  cp {PKG_BUILD}/projects/unix/mupen64plus-rsp-cxd4${SUFFIX}.so ${PKG_BUILD}/projects/unix/mupen64plus-rsp-cxd4-simple.so
}

makeinstall_target() {
  UPREFIX=${INSTALL}/usr/local
  ULIBDIR=${UPREFIX}/lib
  UPLUGINDIR=${ULIBDIR}/mupen64plus
  mkdir -p ${UPLUGINDIR}
  cp ${PKG_BUILD}/projects/unix/mupen64plus-rsp-cxd4-base.so ${UPLUGINDIR}/mupen64plus-rsp-cxd4.so
  #${STRIP} ${UPLUGINDIR}/mupen64plus-rsp-cxd4.so
  chmod 0644 ${UPLUGINDIR}/mupen64plus-rsp-cxd4.so
    cp ${PKG_BUILD}/projects/unix/mupen64plus-rsp-cxd4-simple.so ${UPLUGINDIR}
  #${STRIP} ${UPLUGINDIR}/mupen64plus-rsp-cxd4-simple.so
  chmod 0644 ${UPLUGINDIR}/mupen64plus-rsp-cxd4-simple.so
}

