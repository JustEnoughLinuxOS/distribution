PKG_NAME="RTL8188FU"
PKG_VERSION="2614aaf4ee0420f2e3efd62d7de19f7bc719ff66"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lwfinger/rtl8188fu"
PKG_URL="https://github.com/lwfinger/rtl8188fu/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux kernel-firmware"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="Realtek RTL81xxFU Linux firmware"
PKG_IS_KERNEL_PKG="yes"

make_target() {
 echo
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/kernel-overlays/base/lib/firmware/rtlwifi
  cp firmware/rtl8188fufw.bin ${INSTALL}/usr/lib/kernel-overlays/base/lib/firmware/rtlwifi
}
