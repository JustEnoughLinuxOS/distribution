PKG_NAME="gcc-linaro-aarch64-elf"
PKG_VERSION="4.9.4-2017.01"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="https://releases.linaro.org/components/toolchain/binaries/4.9-2017.01/aarch64-elf/gcc-linaro-${PKG_VERSION}-x86_64_aarch64-elf.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="Linaro Aarch64 GNU Linux Binary Toolchain"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/lib/gcc-linaro-aarch64-elf/
    cp -a * $TOOLCHAIN/lib/gcc-linaro-aarch64-elf
}
