#!/usr/bin/env bash
sudo apt update -y
sudo apt install -y chktex shellcheck texlive-full

# install gdrive
URL_TO_GDRIVE_BINARY="https://github.com/glotlabs/gdrive/releases/download/3.9.0/gdrive_linux-x64.tar.gz"
wget "${URL_TO_GDRIVE_BINARY}" -O gdrive
tar -xzf gdrive
chmod +x gdrive
sudo cp gdrive /usr/local/bin
