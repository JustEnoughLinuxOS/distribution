PKG_NAME="ruby"
PKG_VERSION="2.4"
PKG_MINOR="0"
PKG_LICENSE="Ruby or BSD-2-Clause, BSD-3-Clause, others"
PKG_SITE="http://cache.ruby-lang.org/pub/ruby/"
PKG_URL="${PKG_SITE}/${PKG_VERSION}/ruby-${PKG_VERSION}.${PKG_MINOR}.tar.xz"
PKG_DEPENDS_TARGET="toolchain sqlite expat zlib bzip2 openssl libffi ncurses readline"
PKG_LONGDESC="Ruby is an object-oriented programming language."

PKG_TOOLCHAIN="autotools"
pre_configure_target() {
}

make_target() {
}

makeinstall_target() {
}

post_makeinstall_target() {
}
