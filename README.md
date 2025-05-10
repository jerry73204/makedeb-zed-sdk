# ZED SDK Debian Package

<p align="center">
  <a href="https://github.com/jerry73204/zed-sdk-debian-package/releases/tag/4.2-1">
    <strong>Download Debian Packages »</strong>
  </a>
</p>


This repository contains a makedeb PKGBUILD script to create a Debian package for the StereoLabs ZED SDK. It extracts the content from the ZED SDK run file and re-package into a Debian package file.

**This is not an official release. Use at your own risk.**

## Important Notes for Jetson Users

1. **DO NOT** install the `libv4l-dev` package on Jetson devices as it will break hardware encoding/decoding support.
2. The package automatically modifies the `nvargus-daemon.service` to enable infinite timeout for camera connections, improving stability with multiple cameras.
3. The `zed_media_server_cli.service` is automatically configured on Jetson devices.

## Build the Debian Package

You need to install `makedeb` to build this package. Please visit [makedeb.org](https://www.makedeb.org/) to install this command. Then, clone this repository and run `makedeb` in the repo directory.

```bash
makedeb -s
```
