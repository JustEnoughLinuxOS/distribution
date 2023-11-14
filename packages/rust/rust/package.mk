# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rust"
PKG_VERSION="1.73.0"
PKG_SHA256="96d62e6d1f2d21df7ac8acb3b9882411f9e7c7036173f7f2ede9e1f1f6b1bb3a"
PKG_LICENSE="MIT"
PKG_SITE="https://www.rust-lang.org"
PKG_URL="https://static.rust-lang.org/dist/rustc-${PKG_VERSION}-src.tar.gz"
PKG_DEPENDS_HOST="toolchain llvm:host"
PKG_DEPENDS_UNPACK="rustc-snapshot rust-std-snapshot cargo-snapshot"
PKG_LONGDESC="A systems programming language that prevents segfaults, and guarantees thread safety."
PKG_TOOLCHAIN="manual"

pre_configure_host() {
  "$(get_build_dir rustc-snapshot)/install.sh" --prefix="${PKG_BUILD}/rust-snapshot" --disable-ldconfig
  "$(get_build_dir rust-std-snapshot)/install.sh" --prefix="${PKG_BUILD}/rust-snapshot" --disable-ldconfig
  "$(get_build_dir cargo-snapshot)/install.sh" --prefix="${PKG_BUILD}/rust-snapshot" --disable-ldconfig
}

configure_host() {

  mkdir -p ${PKG_BUILD}/targets

  case "${TARGET_ARCH}" in
    "arm")
      # the arm target is special because we specify the subarch. ie armv8a
      cp -a ${PKG_DIR}/targets/arm-libreelec-linux-gnueabihf.json ${PKG_BUILD}/targets/${TARGET_NAME}.json
      ;;
    "aarch64"|"x86_64")
      cp -a ${PKG_DIR}/targets/${TARGET_NAME}.json ${PKG_BUILD}/targets/${TARGET_NAME}.json
      ;;
  esac

  cat > ${PKG_BUILD}/config.toml <<END
changelog-seen = 2

[target.${TARGET_NAME}]
llvm-config = "${TOOLCHAIN}/bin/llvm-config"
cxx = "${TARGET_PREFIX}g++"
cc = "${TARGET_PREFIX}gcc"

[target.${RUST_HOST}]
llvm-config = "${TOOLCHAIN}/bin/llvm-config"
cxx = "${CXX}"
cc = "${CC}"

[rust]
rpath = true
channel = "stable"
codegen-tests = false
optimize = true

[build]
submodules = false
docs = false
profiler = true
vendor = true

rustc = "${PKG_BUILD}/rust-snapshot/bin/rustc"
cargo = "${PKG_BUILD}/rust-snapshot/bin/cargo"

target = [
  "${TARGET_NAME}",
  "${RUST_HOST}"
]

host = [
  "${RUST_HOST}"
]

build = "${RUST_HOST}"

[install]
prefix = "${TOOLCHAIN}"
bindir = "${TOOLCHAIN}/bin"
libdir = "${TOOLCHAIN}/lib"
datadir = "${TOOLCHAIN}/share"
mandir = "${TOOLCHAIN}/share/man"

END

CARGO_HOME="${PKG_BUILD}/cargo_home"
mkdir -p "${CARGO_HOME}"

cat > ${CARGO_HOME}/config << END
[target.${TARGET_NAME}]
linker = "${TARGET_PREFIX}gcc"

[target.${RUST_HOST}]
linker = "${CC}"
rustflags = ["-C", "link-arg=-Wl,-rpath,${TOOLCHAIN}/lib"]

[build]
target-dir = "${PKG_BUILD}/target"

[term]
progress.when = 'always'
progress.width = 80

END

}

make_host() {
  cd ${PKG_BUILD}

  unset CFLAGS
  unset CXXFLAGS
  unset CPPFLAGS
  unset LDFLAGS

  export RUST_TARGET_PATH="${PKG_BUILD}/targets/"

  python3 src/bootstrap/bootstrap.py -j ${CONCURRENCY_MAKE_LEVEL} build --stage 2 --verbose
}

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/bin
    cp -a build/${RUST_HOST}/stage2/bin/* ${TOOLCHAIN}/bin

  mkdir -p ${TOOLCHAIN}/lib/rustlib
    cp -a build/${RUST_HOST}/stage2/lib/* ${TOOLCHAIN}/lib

    cp -a ${PKG_BUILD}/targets/*.json ${TOOLCHAIN}/lib/rustlib/
}
