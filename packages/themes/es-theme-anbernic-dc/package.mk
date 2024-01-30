#UzuCore

PKG_NAME="es-theme-anbernic-dc"
PKG_VERSION="2990893002d091e070c02391d3be0d85e83f345f"
PKG_ARCH="any"
PKG_LICENSE="CUSTOM"
PKG_SITE="https://github.com/UzuCore/es-theme-anbernic-dc"
PKG_URL="${PKG_SITE}.git"
GET_HANDLER_SUPPORT="git"
PKG_SHORTDESC="Epic Noir"
PKG_LONGDESC="Anbernic Epic Noir"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/themes/${PKG_NAME}
  cp -rf * ${INSTALL}/usr/share/themes/${PKG_NAME}
}
