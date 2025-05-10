# Maintainer: Hsiang-Jui Lin <jerry73204@gmail.com>
pkgname=zed-sdk
pkgver=4.2
pkgrel=1
pkgdesc="StereoLabs ZED SDK"
arch=('amd64' 'arm64')
url="https://www.stereolabs.com/developers/release/"
license=('custom')

_arch="$(dpkg --print-architecture)"

_common_depends=(
  'libjpeg-turbo8'
  'libturbojpeg'
  'libusb-1.0-0'
  'libusb-1.0-0-dev'
  'libopenblas-dev'
  'libarchive-dev'
  'libv4l-0'
  'curl'
  'unzip'
  'zlib1g'
  'mesa-utils'
  # dev
  'libpng-dev'
  #
  'qtbase5-dev'
  'qtchooser'
  'qt5-qmake'
  'qtbase5-dev-tools'
  'libqt5opengl5'
  'libqt5svg5'
  # samples
  'libglew-dev'
  'freeglut3-dev'
  # python
  'python3-numpy'
  'python3-requests'
  'python3-pyqt5'
)
_jetson_depends=(
  'nvidia-l4t-camera'
)
depends_x86_64=(
  ${_common_depends[@]}
)
depends_aarch64=(
  x${_common_depends[@]}
  'nvidia-l4t-camera'
)

if [[ "$_arch" == "arm64" && -f /etc/nv_tegra_release ]]; then
  depends_aarch64+=(${_jetson_depends[@]})
fi

makedepends=(
  'zstd'
  'tar'
  # python
  'python3-dev'
  'python3-pip'
  'python3-setuptools'
)
options=('!strip')
postinst='postinst.sh'
prerm='prerm.sh'
postrm='postrm.sh'

CARCH=$(dpkg --print-architecture)

if [ "${CARCH}" = "amd64" ]; then
    run_file="ZED_SDK_Ubuntu22_cuda12_v${pkgver}.run"
    whl_file="pyzed-${pkgver}-cp310-cp310-linux_x86_64.whl"
else
    run_file="ZED_SDK_Tegra_L4T36.3_v${pkgver}.run"
    whl_file="pyzed-${pkgver}-cp310-cp310-linux_aarch64.whl"
fi

source_amd64=(
    "${run_file}::https://download.stereolabs.com/zedsdk/${pkgver}/cu12/ubuntu22"
    "${whl_file}::https://stereolabs.sfo2.digitaloceanspaces.com/zedsdk/${pkgver}/whl/linux_x86_64/pyzed-${pkgver}-cp310-cp310-linux_x86_64.whl"
    "python_shebang.patch"
    "zed_download_ai_models"
)
source_arm64=(
    "${run_file}::https://download.stereolabs.com/zedsdk/${pkgver}/l4t36.3/jetsons"
    "${whl_file}::https://download.stereolabs.com/zedsdk/${pkgver}/whl/linux_aarch64/pyzed-${pkgver}-cp310-cp310-linux_aarch64.whl"
    "python_shebang.patch"
    "zed_download_ai_models"
)

noextract=(
    "${whl_file}"
)

sha256sums_amd64=(
    'c03f3e0a91512182a42a52e77d9b7ad76a044e3899b55b267c334cd6effe5844'
    '13cd739ea3510bc15a1fcf3fc22fcd485df42c95453eaff0a9658b6cd1b5293a'
    '1eed77b1cb24af3e58ecffde7a6bd1524215efeb9bafdc9364a2add2bc911fcd'
    'f4bff6ceb6de242615ddb2c305d70b35f7935adee4bbdda1d5d980a960efa09b'
)
sha256sums_arm64=(
    '34ede11ba659a9b501f55ad262885cafb1c320cfc5cfba8da0407f7c6d84a2ed'
    'c22dfbb15790928f5a1d7179b61317549c91edf1311aface4d12cb413f395e99'
    '1eed77b1cb24af3e58ecffde7a6bd1524215efeb9bafdc9364a2add2bc911fcd'
    'f4bff6ceb6de242615ddb2c305d70b35f7935adee4bbdda1d5d980a960efa09b'
)


prepare() {
  cd "${srcdir}"

  # Extract content from the self-extracting archive
  # The number 718 is the line where the binary data starts in the run file
  mkdir -p extract
  tail -n +718 "../${run_file}" | zstdcat -d | tar -xf - -C extract

  cd extract
  patch -Np1< "${srcdir}/python_shebang.patch"
}

package() {
  cd "${srcdir}/extract"

  # Create target directories
  mkdir -p "${pkgdir}/usr/local/zed"
  mkdir -p "${pkgdir}/usr/local/lib/python3.10/dist-packages"
  mkdir -p "${pkgdir}/etc/udev/rules.d"
  mkdir -p "${pkgdir}/etc/ld.so.conf.d"
  mkdir -p "${pkgdir}/usr/local/bin"
  mkdir -p "${pkgdir}/usr/share/licenses/${pkgname}"

  # Install license
  install -Dm644 "doc/license/LICENSE.txt" "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"

  # Install ZED libraries and includes
  cp -a -t "${pkgdir}/usr/local/zed" lib
  cp -a -t "${pkgdir}/usr/local/zed" include

  # Install firmware and resources
  cp -a -t "${pkgdir}/usr/local/zed" firmware
  # cp -a -t "${pkgdir}/usr/local/zed" resources

  # Install cmake files
  install -Dm644 "zed-config.cmake" "${pkgdir}/usr/local/zed/zed-config.cmake"
  install -Dm644 "zed-config-version.cmake" "${pkgdir}/usr/local/zed/zed-config-version.cmake"

  # Install Python API script
  install -Dm755 "get_python_api.py" "${pkgdir}/usr/local/zed/get_python_api.py"

  # Install Python API script
  install -Dm755 "${srcdir}/zed_download_ai_models" "${pkgdir}/usr/local/bin/zed_download_ai_models"

  # Install tools
  cp -a -t "${pkgdir}/usr/local/zed" tools

  # Create symlinks for tools
  find "${pkgdir}/usr/local/zed/tools/" -type f -executable | while read tool_exe; do
      name="$(basename $tool_exe)"
      ln -s "/usr/local/zed/tools/$name" "${pkgdir}/usr/local/bin/$(basename $tool_exe)"
  done

  # Install samples if available (optional)
  cp -a -t "${pkgdir}/usr/local/zed" samples

  # Install udev rules
  install -Dm644 "99-slabs.rules" "${pkgdir}/etc/udev/rules.d/99-slabs.rules"

  # Install ld.so.conf.d file
  install -Dm644 "zed.conf" "${pkgdir}/etc/ld.so.conf.d/zed.conf"

  # Install ZEDMediaServer service
  if [ "${CARCH}" = "arm64" ]; then
      install -Dm644 "zed_media_server_cli.service" "${pkgdir}/etc/systemd/system/zed_media_server_cli.service"
  fi

  # Create the doc directory
  cp -a -t "${pkgdir}/usr/local/zed" doc

  # Install the wheel into the package directory
  PYTHONUSERBASE="$pkgdir/usr" \
		python3 -m pip install --no-deps --root="${pkgdir}" --prefix=/usr --ignore-installed \
		"${srcdir}/${whl_file}"
}
