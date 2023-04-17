#UzuCore

PKG_NAME="es-theme-anbernic-dc"
PKG_VERSION="053f5a73f5db09537c0fca1fdd9fb1c58c2e1f10"
PKG_ARCH="any"
PKG_LICENSE="CUSTOM"
PKG_SITE="https://github.com/UzuCore/es-theme-anbernic-dc"
PKG_URL="${PKG_SITE}.git"
PKG_SHORTDESC="Anbernic Epic Noir"
PKG_LONGDESC="Anbernic Epic Noir"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
    mkdir -p ${INSTALL}/usr/config/emulationstation/themes/${PKG_NAME}
    cp -rf * ${INSTALL}/usr/config/emulationstation/themes/${PKG_NAME}
}
