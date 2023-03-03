# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)
# Copyright (C) 2022-present BrooksyTech (https://github.com/brooksytech)

PKG_NAME="rpcs3sa"
PKG_VERSION="f9142a1c56028794c51ec58b9493193f7616ec07"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://rpcs3.net"
PKG_URL="https://github.com/RPCS3/rpcs3.git"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain linux glibc systemd pulseaudio mesa xorg-server libevdev curl ffmpeg libpng zlib glew-cmake libSM SDL2 enet qt5 rpcs3sa:host vulkan-headers vulkan-loader vulkan-tools libp11-kit yamlcpp openal-soft"
PKG_LONGDESC="RPCS3 is an experimental open-source Sony PlayStation 3 emulator and debugger."
GET_HANDLER_SUPPORT="git"
PKG_GIT_CLONE_BRANCH="master"
PKG_GIT_CLONE_SINGLE="yes"

pre_configure_host() {
  PKG_CMAKE_SCRIPT="${PKG_BUILD}/llvm/CMakeLists.txt"
  PKG_CMAKE_OPTS_HOST="-DLLVM_TARGETS_TO_BUILD="X86" \
                       -DLLVM_BUILD_RUNTIME=OFF \
                       -DLLVM_BUILD_TOOLS=OFF \
                       -DLLVM_INCLUDE_BENCHMARKS=OFF \
                       -DLLVM_INCLUDE_DOCS=OFF \
                       -DLLVM_INCLUDE_EXAMPLES=OFF \
                       -DLLVM_INCLUDE_TESTS=OFF \
                       -DLLVM_INCLUDE_TOOLS=OFF \
                       -DLLVM_INCLUDE_UTILS=OFF \
                       -DLLVM_CCACHE_BUILD=ON \
                       -Wno-dev"
}

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET=(-DUSE_NATIVE_INSTRUCTIONS=OFF \
                         -DBUILD_LLVM_SUBMODULE=ON \
                         -DCMAKE_C_FLAGS="${CFLAGS}" \
                         -DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
                         -DLLVM_TARGET_ARCH="${TARGET_ARCH}" \
                         -DLLVM_TABLEGEN=${PKG_BUILD}/.${HOST_NAME}/bin/llvm-tblgen \
                         -DUSE_DISCORD_RPC=OFF \
                         -DCMAKE_SKIP_RPATH=ON \
                         -DUSE_SYSTEM_FFMPEG=ON \
                         -DUSE_SYSTEM_LIBPNG=ON \
                         -DUSE_SYSTEM_ZLIB=ON \
                         -DUSE_SYSTEM_CURL=ON \
                         -DUSE_VULKAN=ON \
                         -Wno-dev)
}

configure_target() {
  echo "Executing (target): cmake ${CMAKE_GENERATOR_NINJA} ${TARGET_CMAKE_OPTS} "${PKG_CMAKE_OPTS_TARGET[@]}" $(dirname ${PKG_CMAKE_SCRIPT})" | tr -s " "
  cmake ${CMAKE_GENERATOR_NINJA} ${TARGET_CMAKE_OPTS} "${PKG_CMAKE_OPTS_TARGET[@]}" $(dirname ${PKG_CMAKE_SCRIPT})
}

make_host() {
  ninja ${NINJA_OPTS} llvm-tblgen
}

makeinstall_host() {
 :
}

pre_make_target() {
  # fix cross compiling
  find ${PKG_BUILD} -name flags.make  -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

post_makeinstall_target() {
  # Copy scripts
  mkdir -p ${INSTALL}/usr/bin/
   cp ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin/

  # Copy config & resources
  mkdir -p ${INSTALL}/usr/config/rpcs3
   cp -PR ${PKG_DIR}/config/rpcs3                           ${INSTALL}/usr/config/rpcs3/
   cp -PR ${INSTALL}/usr/share/rpcs3/{GuiConfigs,Icons} ${INSTALL}/usr/config/rpcs3/ 

  # Clean up
  safe_remove ${INSTALL}/usr/share
}
