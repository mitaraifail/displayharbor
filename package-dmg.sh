#!/bin/zsh
set -euo pipefail

project_dir="${0:A:h}"
cd "$project_dir"

app_dir="$project_dir/dist/DisplayHarbor.app"
version="${DISPLAYHARBOR_VERSION:-0.1.1}"
version="${version#v}"
staging_dir="$project_dir/dist/dmg-root"
dmg_path="$project_dir/dist/DisplayHarbor-v${version}-macos-arm64.dmg"

if [[ ! -d "$app_dir" ]]; then
    echo "Missing $app_dir. Run build-app.sh first." >&2
    exit 1
fi

rm -rf "$staging_dir" "$dmg_path" "${dmg_path}.sha256"
mkdir -p "$staging_dir"
ditto "$app_dir" "$staging_dir/DisplayHarbor.app"
ln -s /Applications "$staging_dir/Applications"
cp "$project_dir/Resources/DMG/README.txt" "$staging_dir/README.txt"
launcher_app="$staging_dir/Open DisplayHarbor (Advanced).app"
ditto "$project_dir/Resources/DMG/Open DisplayHarbor (Advanced).app" "$launcher_app"
mkdir -p "$launcher_app/Contents/Resources"
cp "$project_dir/Resources/AppIcon.icns" "$launcher_app/Contents/Resources/AppIcon.icns"
chmod +x "$launcher_app/Contents/MacOS/DisplayHarborAdvancedLauncher"

hdiutil create \
    -volname "DisplayHarbor v${version}" \
    -srcfolder "$staging_dir" \
    -ov \
    -format UDZO \
    "$dmg_path" >/dev/null

(cd "$(dirname "$dmg_path")" && shasum -a 256 "$(basename "$dmg_path")" > "$(basename "$dmg_path").sha256")
rm -rf "$staging_dir"
echo "Packaged $dmg_path"
