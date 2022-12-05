# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="parallel-n64_rice"
PKG_VERSION="a03fdcba6b2e9993f050b50112f597ce2f44fa2c"
PKG_REV="2"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/parallel-n64"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain core-info"
PKG_SECTION="libretro"
PKG_SHORTDESC="Optimized/rewritten Nintendo 64 emulator made specifically for Libretro. Originally based on Mupen64 Plus."
PKG_LONGDESC="Optimized/rewritten Nintendo 64 emulator made specifically for Libretro. Originally based on Mupen64 Plus."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-lto"
PKG_PATCH_DIRS+="${DEVICE}"

if [ ! "${OPENGL}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL} glu libglvnd"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

case ${ARCH} in
  arm)
    case ${DEVICE} in
      RG351P|RG351V|RG351MP|RGB20S)
        PKG_MAKE_OPTS_TARGET=" platform=RG351x"
      ;;
      RG503|RG353P)
        PKG_MAKE_OPTS_TARGET+=" platform=RK3566"
      ;;
      RG552)
        PKG_MAKE_OPTS_TARGET=" platform=${DEVICE}"
      ;;
    esac
  ;;
  aarch64)
    make_target() {
      :
    }
  ;;
esac

pre_configure_target() {
  sed -i 's/info->library_name = "ParaLLEl N64";/info->library_name = "ParaLLEl N64 Rice";/g' ${PKG_BUILD}/libretro/libretro.c
  sed -i 's/"GFX Plugin; auto|glide64|gln64|rice/"GFX Plugin; rice|auto|glide64|gln64/g' ${PKG_BUILD}/libretro/libretro.c
  #sed -i 's/"Resolution (restart); 320x240|640x480|960x720/"Resolution (restart); 640x480|320x240|960x720/g' ${PKG_BUILD}/libretro/libretro.c
  sed -i 's/"Framerate (restart); original|fullspeed"/"Framerate (restart); fullspeed|original"/g' ${PKG_BUILD}/libretro/libretro.c
  sed -i 's/"GFX Accuracy (restart); veryhigh|high|medium|low"/"GFX Accuracy (restart); low|veryhigh|high|medium"/g' ${PKG_BUILD}/libretro/libretro.c
  sed -i 's/"(Glide64) Texture Filtering; automatic|N64 3-point|bilinear|nearest"/"(Glide64) Texture Filtering; nearest|automatic|N64 3-point|bilinear"/g' ${PKG_BUILD}/libretro/libretro.c
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  case ${ARCH} in
    arm|x86_64)
      cp parallel_n64_libretro.so ${INSTALL}/usr/lib/libretro/parallel_n64_rice_libretro.so
    ;;
    aarch64)
      cp -vP ${ROOT}/build.${DISTRO}-${DEVICE}.arm/parallel-n64_rice-*/.install_pkg/usr/lib/libretro/parallel_n64_rice_libretro.so ${INSTALL}/usr/lib/libretro/parallel_n64_rice_libretro.so
      cp -vP ${PKG_BUILD}/../core-info-*/parallel_n64_libretro.info ${INSTALL}/usr/lib/libretro/parallel_n64_rice_libretro.info
      sed -i 's/ParaLLEl N64/ParaLLEl N64 Rice/g' ${INSTALL}/usr/lib/libretro/parallel_n64_rice_libretro.info
   ;;
  esac
}
