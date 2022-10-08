# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Xargon (https://github.com/XargonWan)
# Copyright (C) 2022-present Fewtarius

PKG_NAME="rclone"
PKG_VERSION="1.58.0"
PKG_URL="https://downloads.rclone.org/v${PKG_VERSION}/rclone-v${PKG_VERSION}-linux-arm64.zip"
PKG_DEPENDS_TARGET="toolchain fuse rsync"
PKG_SECTION="tools"
PKG_SHORTDESC="rsync for cloud storage"
PKG_TOOLCHAIN="manual"

pre_unpack() {
  unzip sources/rclone/rclone-${PKG_VERSION}.zip -d ${PKG_BUILD}/
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin/
  mkdir -p ${INSTALL}/usr/config/
  cp ${PKG_DIR}/sources/rclonectl ${INSTALL}/usr/bin/
  cp ${PKG_DIR}/sources/cloud_backup ${INSTALL}/usr/bin/
  cp ${PKG_DIR}/sources/cloud_restore ${INSTALL}/usr/bin/
  cp ${PKG_BUILD}/rclone-v${PKG_VERSION}-linux-arm64/rclone ${INSTALL}/usr/bin/
  chmod 0755 ${INSTALL}/usr/bin/*
  cp ${PKG_DIR}/sources/rsync-rules.conf ${INSTALL}/usr/config/
  cp ${PKG_DIR}/sources/rsync.conf ${INSTALL}/usr/config/
  chmod 755 ${INSTALL}/usr/bin/rclone
  mkdir -p ${INSTALL}/usr/config/modules
  ln -sf /usr/bin/cloud_backup ${INSTALL}/usr/config/modules/cloud_backup.sh
  ln -sf /usr/bin/cloud_restore ${INSTALL}/usr/config/modules/cloud_restore.sh
}
