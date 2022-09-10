#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2020-present Fewtarius

. /etc/profile

clear >/dev/console
echo "Scanning for games..." >/dev/console
bash /usr/bin/start_scummvm.sh add >/dev/console
echo "Adding games..." >/dev/console
bash /usr/bin/start_scummvm.sh create >/dev/console
systemctl restart ${UI_SERVICE}
clear >/dev/console
