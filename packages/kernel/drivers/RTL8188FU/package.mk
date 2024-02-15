PKG_NAME="RTL8188FU"
PKG_VERSION="0ede0794073495da694aeb52cdd748c6ba2ff21c"
PKG_ARCH="aarch64 x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kelebek333/rtl8188fu"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain linux kernel-firmware"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="Realtek RTL81xxFU Linux firmware"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="make"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  make V=1 \
       ARCH=${TARGET_KERNEL_ARCH} \
       KSRC=$(kernel_path) \
       CROSS_COMPILE=${TARGET_KERNEL_PREFIX} \
       CONFIG_POWER_SAVING=y \
       USER_EXTRA_CFLAGS="-Wno-error=date-time"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/kernel/drivers/net/wireless/
  cp *.ko ${INSTALL}/$(get_full_module_dir)/kernel/drivers/net/wireless/
  mkdir -p ${INSTALL}/usr/lib/kernel-overlays/base/lib/firmware/rtlwifi
  cp firmware/rtl8188fufw.bin ${INSTALL}/usr/lib/kernel-overlays/base/lib/firmware/rtlwifi
}
