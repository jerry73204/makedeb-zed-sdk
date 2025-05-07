# ZED SDK Debian Package

<p align="center">
  <a href="https://github.com/jerry73204/zed-sdk-debian-package/releases/tag/4.2-1">
    <strong>Download Debian Packages »</strong>
  </a>
</p>


This repository contains a makedeb PKGBUILD script to create a Debian package for the StereoLabs ZED SDK. It extracts the content from the ZED SDK run file and re-package into a Debian package file.

**This is not an official release. Use at your own risk.**

## Build the Debian Package

You need to install `makedeb` to build this package. Please visit [makedeb.org](https://www.makedeb.org/) to install this command. Then, clone this repository and run `makedeb` in the repo directory.

```bash
makedeb -s
```
