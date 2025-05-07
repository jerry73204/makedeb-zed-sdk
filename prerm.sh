#!/bin/sh
if command -v systemctl >/dev/null && systemctl list-units >/dev/null 2>&1; then
    systemctl disable zed_media_server_cli.service
    systemctl stop zed_media_server_cli.service
fi
