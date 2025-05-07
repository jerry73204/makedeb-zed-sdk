# ZED SDK Debian Package

This repository contains a makedeb PKGBUILD script to create a Debian package for the StereoLabs ZED SDK. It properly extracts the content from the official ZED SDK run file and packages it with correct permissions.

## Prerequisites

You need to install `makedeb` to build this package. Please visit [makedeb.org](https://www.makedeb.org/) to install this command.


## Build the Debian Package

```bash
makedeb -s
```
