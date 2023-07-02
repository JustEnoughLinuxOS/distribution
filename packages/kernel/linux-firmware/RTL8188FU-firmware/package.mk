PKG_NAME="RTL8188FU-firmware"
PKG_VERSION="751882b3d8925b72ed796f40e38c0232ccc24785"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kelebek333/rtl8188fu"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain linux kernel-firmware"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="Realtek RTL81xxFU Linux firmware"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/kernel-overlays/base/lib/firmware/rtlwifi
  cp firmware/rtl8188fufw.bin ${INSTALL}/usr/lib/kernel-overlays/base/lib/firmware/rtlwifi
}
