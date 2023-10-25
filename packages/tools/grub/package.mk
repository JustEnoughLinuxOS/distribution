# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)

PKG_NAME="grub"
PKG_VERSION="4fdcb339bbcfbf5c234c764c83813ab8de9c9657"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv3"
PKG_SITE="https://www.gnu.org/software/grub/index.html"
PKG_URL="http://git.savannah.gnu.org/cgit/grub.git/snapshot/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host gnulib"
PKG_DEPENDS_TARGET="toolchain flex freetype:host gettext:host grub:host gnulib"
PKG_DEPENDS_UNPACK="gnulib"
PKG_LONGDESC="GRUB is a Multiboot boot loader."
PKG_TOOLCHAIN="configure"

pre_configure_host() {
  PKG_CONFIGURE_OPTS_HOST+=" --disable-werror"
  unset CFLAGS
  unset CPPFLAGS
  unset CXXFLAGS
  unset LDFLAGS
  unset CPP

  cd ${PKG_BUILD}
    # keep grub synced with gnulib
    ./bootstrap --gnulib-srcdir=$(get_build_dir gnulib) --no-git --skip-po

  mkdir -p .${HOST_NAME}
    cd .${HOST_NAME}
}

pre_configure_target() {
  PKG_CONFIGURE_OPTS_TARGET+="--target=i386-pc-linux \
                              --disable-nls \
-disable-silent-rules \
			      --disable-werror \
                              --with-platform=efi"

  unset CFLAGS
  unset CPPFLAGS
  unset CXXFLAGS
  unset LDFLAGS
  unset CPP

  cd ${PKG_BUILD}
    # keep grub synced with gnulib
    ./bootstrap --gnulib-srcdir=$(get_build_dir gnulib) --copy --skip-po

  mkdir -p .${TARGET_NAME}
    cd .${TARGET_NAME}

  # configure requires explicit TARGET_PREFIX binaries when cross compiling.
  export TARGET_CC="${TARGET_PREFIX}gcc"
  export TARGET_OBJCOPY="${TARGET_PREFIX}objcopy"
  export TARGET_STRIP="${TARGET_PREFIX}strip"
  export TARGET_NM="${TARGET_PREFIX}nm"
  export TARGET_RANLIB="${TARGET_PREFIX}ranlib"
}

make_target() {
  make CC=${CC} \
       AR=${AR} \
       RANLIB=${RANLIB} \
       CFLAGS="-I${SYSROOT_PREFIX}/usr/include -fomit-frame-pointer -D_FILE_OFFSET_BITS=64" \
       LDFLAGS="-L${SYSROOT_PREFIX}/usr/lib"
}

makeinstall_target() {
  ${PKG_BUILD}/.${HOST_NAME}/grub-mkimage -d grub-core -o bootia32.efi -O i386-efi -p /EFI/BOOT \
    boot chain configfile ext2 fat linux search efi_gop \
    efi_uga part_gpt gzio gettext loadenv loadbios memrw

  mkdir -p ${INSTALL}/usr/share/grub
     cp -P bootia32.efi ${INSTALL}/usr/share/grub

  mkdir -p ${TOOLCHAIN}/share/grub
     cp -P bootia32.efi ${TOOLCHAIN}/share/grub
}
