#!/usr/bin/env bash
set -euo pipefail

log() {
	printf '[install] %s\n' "$1"
}

DO_LINT=false
DO_BUILD=false

while (($#)); do
	case "$1" in
		--lint)
			DO_LINT=true
			;;
		--build)
			DO_BUILD=true
			;;
		*)
			echo "Usage: $0 [--lint] [--build]" >&2
			exit 1
			;;
	esac
	shift
done

# Default to installing everything if no flags are provided to maintain previous behaviour.
if ! $DO_LINT && ! $DO_BUILD; then
	DO_LINT=true
	DO_BUILD=true
fi

PACKAGES=()
if $DO_LINT; then
	PACKAGES+=(chktex shellcheck)
fi
if $DO_BUILD; then
	PACKAGES+=(texlive-full)
fi

if ((${#PACKAGES[@]})); then
	log 'Updating apt package index'
	sudo apt update -y

	log "Installing packages: ${PACKAGES[*]}"
	sudo apt install -y "${PACKAGES[@]}"
else
	log 'No packages requested via flags; skipping apt installation.'
fi

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
