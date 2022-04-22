# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present 351ELEC (https://github.com/351ELEC)

PKG_NAME="lib32"
PKG_VERSION="$(date +%Y%m%d)"
PKG_ARCH="aarch64"
PKG_LICENSE="GPLv2"
PKG_DEPENDS_TARGET="toolchain retroarch SDL2 libsndfile libmodplug"
PKG_SHORTDESC="ARM 32bit bundle for aarch64"
PKG_PRIORITY="optional"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  cd ${PKG_BUILD}
  LIBROOT="${PKG_BUILD}/../../build.${DISTRO}-${DEVICE}.arm/image/system/"
  if [ "${ARCH}" = "aarch64" ]; then
      mkdir -p ${INSTALL}/usr/lib32
      LIBS="ld-2 \
		ld-linux-armhf \
		libarmmem-v7l \
		librt \
		libass \
		libasound \
		libopenal \
		libpulse \
		libfreetype \
		libpthread \
		libudev.so \
		libusb-1.0 \
		libSDL2 \
		libmodplug \
		libsndfile \
		libavcodec \
		libavformat \
		libavutil \
		libswscale \
		libswresample \
		libstdc++ \
		libm \
		libgcc_s \
		libc \
		libfontconfig \
		libexpat \
		libbz2 \
		libz \
		libpulsecommon-12 \
		libdbus-1 \
		libdav1d \
		libFLAC \
		libvorbis \
		libspeex \
		libssl \
		libcrypt \
		libsystemd \
		libncurses \
		libdl \
		libdrm \
		librga \
		libpng \
		libgo2 \
		libevdev \
		librockchip_mpp \
		libxkbcommon \
		libresolv \
		libnss_dns \
		libpthread \
		libGLES \
		libgnutls \
		libgbm \
		libidn2 \
		libnettle \
		libhogweed \
		libgmp \
		libuuid.so \
		libMaliOpenCL \
		libEG"

    for lib in ${LIBS}
    do
      find ${LIBROOT}/usr/lib -name ${lib}* -exec cp -vP \{} ${INSTALL}/usr/lib32 \;
    done
    cp ${PKG_BUILD}/../../build.${DISTRONAME}-${DEVICE}.arm/libmali*/.install_pkg/usr/lib/* ${INSTALL}/usr/lib32

    chmod -f +x ${INSTALL}/usr/lib32/* || :
  fi
  mkdir -p ${INSTALL}/usr/lib
  ln -s /usr/lib32/ld-linux-armhf.so.3 ${INSTALL}/usr/lib/ld-linux-armhf.so.3
}
