#!/bin/sh

# Run ldconfig to update the library cache
ldconfig

# Trigger udev rules
udevadm control --reload-rules && udevadm trigger

# Create a zed group for USB access
# getent group zed || groupadd zed

# Enable and start zed_media_server_cli.service
if command -v systemctl >/dev/null && systemctl list-units >/dev/null 2>&1; then
    systemctl daemon-reload
    systemctl enable zed_media_server_cli.service
    systemctl restart zed_media_server_cli.service
fi

echo "ZED SDK installation complete. To use the SDK, add your user to the video and zed groups with:"
echo "  sudo usermod -a -G video,zed $(whoami)"
echo "and then log out and back in."
echo ''
echo "To download all AI models and optimize them,"
echo "  zed_download_ai_models"
