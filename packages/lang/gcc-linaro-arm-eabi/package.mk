PKG_NAME="gcc-linaro-arm-eabi"
PKG_VERSION="4.9.4-2017.01"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="https://releases.linaro.org/components/toolchain/binaries/4.9-2017.01/arm-eabi/gcc-linaro-${PKG_VERSION}-x86_64_arm-eabi.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="Linaro ARM GNU Linux Binary Toolchain"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/lib/gcc-linaro-arm-eabi/
    cp -a * $TOOLCHAIN/lib/gcc-linaro-arm-eabi
}
