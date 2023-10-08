#!/usr/bin/env bash
sudo apt update -y
sudo apt install -y chktex shellcheck texlive-full

# install gdrive
URL_TO_GDRIVE_BINARY="https://github.com/glotlabs/gdrive/releases/download/3.9.0/gdrive_linux-x64.tar.gz"
DOWNLOAD_FILE="gdrive"
INSTALL_PATH="/usr/local/bin/gdrive"
wget "${URL_TO_GDRIVE_BINARY}" -O "${DOWNLOAD_FILE}"
tar -xzf "${DOWNLOAD_FILE}"
chmod +x "${DOWNLOAD_FILE}"
sudo cp "${DOWNLOAD_FILE}" "${INSTALL_PATH}"
command -v "${DOWNLOAD_FILE}" | grep "${INSTALL_PATH}"
rm -f "${DOWNLOAD_FILE}"
