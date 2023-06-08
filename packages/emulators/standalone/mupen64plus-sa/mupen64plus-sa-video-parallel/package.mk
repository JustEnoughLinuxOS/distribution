# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present RiShooty (https://github.com/rishooty)

PKG_NAME="mupen64plus-sa-video-parallel"
PKG_VERSION="8da2be35abbbf503a485993c717e4917a1560324"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/Themaister/parallel-rdp-standalone.git"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain mupen64plus-sa-core mupen64plus-sa-simplecore"
PKG_LONGDESC="Mupen64Plus Standalone Parallel64 Video Driver"
PKG_TOOLCHAIN="manual"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi
if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

pre_configure_target() {
  
}

# make_target() {
#   case ${ARCH} in
#     aarch64|arm)
#       export HOST_CPU=aarch64
#     ;;
#     x86_64)
#       export HOST_CPU=x86_64
# 	  PKG_MAKE_OPTS_TARGET+="USE_GLES=0"
#     ;;
#   esac
#   rm -rf ${PKG_BUILD}/build
#   mkdir ${PKG_BUILD}/build
#   cd ${PKG_BUILD}/build
#   cmake ..
#   cmake --build . --parallel
# }

# makeinstall_target() {
# 	UPREFIX=${INSTALL}/usr/local
# 	ULIBDIR=${UPREFIX}/lib
# 	USHAREDIR=${UPREFIX}/share/mupen64plus
# 	UPLUGINDIR=${ULIBDIR}/mupen64plus
# 	mkdir -p ${UPLUGINDIR}
# 	cp ${PKG_BUILD}/projects/cmake/plugin/Release/mupen64plus-video-GLideN64.so ${UPLUGINDIR} 
# 	#${STRIP} ${UPLUGINDIR}/mupen64plus-video-GLideN64.so
# 	chmod 0644 ${UPLUGINDIR}/mupen64plus-video-GLideN64.so
# 	mkdir -p ${USHAREDIR}
# 	cp ${PKG_BUILD}/ini/GLideN64.ini ${USHAREDIR}
# 	chmod 0644 ${USHAREDIR}/GLideN64.ini
# }