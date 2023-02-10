#!/bin/bash
# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2021-present Fewtarius (https://github.com/fewtarius)

. /etc/profile

ROOTPASS=$(get_setting root.password)
# Set the root user and password for SyncThing
syncthing generate --gui-user root --gui-password ${ROOTPASS}
xmlstarlet ed --inplace -u "//configuration/gui/address" -v ":8384" /storage/.config/syncthing/config.xml

syncthing -no-browser -no-restart
