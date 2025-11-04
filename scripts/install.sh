#!/usr/bin/env bash
set -euo pipefail

log() {
	printf '[install] %s\n' "$1"
}

log 'Updating apt package index'
sudo apt update -y

log 'Installing chktex, shellcheck, and texlive-full'
sudo apt install -y chktex shellcheck texlive-full

# Install gdrive
URL_TO_GDRIVE_BINARY="https://github.com/glotlabs/gdrive/releases/download/3.9.1/gdrive_linux-x64.tar.gz"
INSTALL_PATH="/usr/local/bin/gdrive"
TMP_DIR="$(mktemp -d)"

cleanup() {
	rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

log 'Downloading gdrive binary'
ARCHIVE_PATH="${TMP_DIR}/gdrive.tar.gz"
wget "${URL_TO_GDRIVE_BINARY}" -O "${ARCHIVE_PATH}"

log 'Extracting gdrive archive'
tar -xzf "${ARCHIVE_PATH}" -C "${TMP_DIR}"

log "Installing gdrive to ${INSTALL_PATH}"
sudo install -m 0755 "${TMP_DIR}/gdrive" "${INSTALL_PATH}"

if command -v gdrive >/dev/null && [[ "$(command -v gdrive)" == "${INSTALL_PATH}" ]]; then
	log "gdrive installed to ${INSTALL_PATH}."
	log "Run 'gdrive about' to verify setup or 'gdrive help' for usage information."
else
	log 'gdrive installation check failed'
	exit 1
fi
