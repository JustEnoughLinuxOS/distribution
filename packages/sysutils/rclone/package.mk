# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Xargon (https://github.com/XargonWan)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="rclone"
PKG_VERSION="1.60.0"
PKG_DEPENDS_TARGET="toolchain fuse rsync"
PKG_SECTION="tools"
PKG_SHORTDESC="rsync for cloud storage"
PKG_TOOLCHAIN="manual"

case ${ARCH} in
    aarch64)
      RCLONE_ARCH="arm64"
    ;;
    *)
      RCLONE_ARCH="amd64"
    ;;
esac

PKG_URL="https://downloads.rclone.org/v${PKG_VERSION}/rclone-v${PKG_VERSION}-linux-${RCLONE_ARCH}.zip"
PKG_RCLONE="rclone-v${PKG_VERSION}-linux-${RCLONE_ARCH}/rclone"

pre_unpack() {
  # Will need to figure out why unpack isn't handling this correctly.
  cd ${SOURCES_DIR}/rclone
  if [ ! -e "rclone-${PKG_VERSION}-${RCLONE_ARCH}.zip" ]
  then
    mv rclone-${PKG_VERSION}.zip rclone-${PKG_VERSION}-${RCLONE_ARCH}.zip
  fi
}

unpack() {
  unzip rclone-${PKG_VERSION}-${RCLONE_ARCH}.zip -d ${PKG_BUILD}/
  rm -f rclone-${PKG_VERSION}.*
  cd -
}


makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin/
  mkdir -p ${INSTALL}/usr/config/
  cp ${PKG_DIR}/sources/rclonectl ${INSTALL}/usr/bin/
  cp ${PKG_DIR}/sources/cloud_backup ${INSTALL}/usr/bin/
  cp ${PKG_DIR}/sources/cloud_restore ${INSTALL}/usr/bin/
  cp ${PKG_BUILD}/${PKG_RCLONE} ${INSTALL}/usr/bin/
  chmod 0755 ${INSTALL}/usr/bin/*
  cp ${PKG_DIR}/sources/rsync-rules.conf ${INSTALL}/usr/config/
  cp ${PKG_DIR}/sources/rsync.conf ${INSTALL}/usr/config/
  chmod 755 ${INSTALL}/usr/bin/rclone
  mkdir -p ${INSTALL}/usr/config/modules
  ln -sf /usr/bin/cloud_backup ${INSTALL}/usr/config/modules/cloud_backup.sh
  ln -sf /usr/bin/cloud_restore ${INSTALL}/usr/config/modules/cloud_restore.sh
}
