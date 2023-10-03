#!/usr/bin/env bash
set -e

source_path="Assignment 2 on Free Groups/paper.pdf"
destination_path="paper.pdf"
echo "Checking if the file ${destination_path} exists in Google Drive..."
check=$(gdrive files list --query "name = '${destination_path}'" --skip-header | wc -l)
echo "Found ${check} instance(s) of the file named ${destination_path}."
if [ "${check}" -gt 0 ]; then
  echo "It exists. We'll fetch the file ID..."
  # TODO: We should exit if we find two of the same file. There's no knowing which one is being updated.
  samefileID=$(gdrive files list --query "name = '${destination_path}'" --skip-header | sed 's/|/ /' | awk '{print $1}' | head -n 1)
  echo "Fetched the file ID. It's ${samefileID}. We'll attempt to update the file..."
  gdrive files update "${samefileID}" "${source_path}"
  echo "Done updating."
else
  echo "It doesn't exist. We'll upload the file."
  gdrive files upload "${source_path}"
  echo "Done uploading."
fi
