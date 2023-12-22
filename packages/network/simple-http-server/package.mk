# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2023 JELOS (https://github.com/JustEnoughLinuxOS)
# Copyright (C) 2023-present NeoTheFox (https://github.com/NeoTheFox)

PKG_NAME="simple-http-server"
PKG_VERSION="0.6.7"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/TheWaWaR/simple-http-server"
PKG_URL_ARM="https://github.com/TheWaWaR/simple-http-server/releases/download/v${PKG_VERSION}/armv7-unknown-linux-musleabihf-simple-http-server"
PKG_URL_AARCH64="https://github.com/TheWaWaR/simple-http-server/releases/download/v${PKG_VERSION}/aarch64-unknown-linux-musl-simple-http-server"
PKG_URL_X86_64="https://github.com/TheWaWaR/simple-http-server/releases/download/v${PKG_VERSION}/x86_64-unknown-linux-musl-simple-http-server"
PKG_LONGDESC="Simple http server in Rust"
PKG_TOOLCHAIN="manual"

unpack() {
	case $ARCH in
	x86_64)
		PKG_URL=$PKG_URL_X86_64
		;;
	arm)
		PKG_URL=$PKG_URL_ARM
		;;
	aarch64)
		PKG_URL=$PKG_URL_AARCH64
		;;
	esac

	curl -L $PKG_URL -o ${PKG_DIR}/simple-http-server
}

makeinstall_target() {
	mkdir -p ${INSTALL}/usr/bin
	install -Dm755 ${PKG_DIR}/simple-http-server ${INSTALL}/usr/bin/
}
