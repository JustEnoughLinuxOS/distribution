PKG_NAME="libp11-kit"
PKG_VERSION="0.24.1"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/p11-glue/p11-kit"
PKG_URL="https://github.com/p11-glue/p11-kit/releases/download/${PKG_VERSION}/p11-kit-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="p11-kit aims to solve problems with coordinating the use of PKCS 11 by different components or libraries. "

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib
  cp -rf ${PKG_BUILD}/.${TARGET_NAME}/p11-kit/libp11-kit.so* ${INSTALL}/usr/lib/
}
