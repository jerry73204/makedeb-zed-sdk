#!/bin/sh

# Run ldconfig to update the library cache
ldconfig

# Trigger udev rules
udevadm control --reload-rules && udevadm trigger

# Remove zed group
# getent group zed > /dev/null && sudo groupdel zed

# Enable and start zed_media_server_cli.service
if command -v systemctl >/dev/null && systemctl list-units >/dev/null 2>&1; then
    systemctl daemon-reload
fi
