#!/bin/zsh
set -euo pipefail

app_path="/Applications/DisplayHarbor.app"

if [[ ! -d "$app_path" ]]; then
    echo "DisplayHarbor.app was not found in /Applications."
    echo "Please drag DisplayHarbor.app there first, then run this file again."
    read -r "?Press Return to close..."
    exit 1
fi

echo "This removes the macOS quarantine marker from:"
echo "$app_path"
echo "Only continue after verifying the matching GitHub Release checksum."
read -r "?Press Return to continue, or press Control-C to cancel..."

xattr -dr com.apple.quarantine "$app_path"
open "$app_path"
