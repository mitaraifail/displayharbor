#!/bin/zsh
set -euo pipefail

project_dir="${0:A:h}"
cd "$project_dir"

app_dir="$project_dir/dist/DisplayHarbor.app"
app_binary="$app_dir/Contents/MacOS/DisplayHarbor"
running_pid="$(pgrep -f "^${app_binary}$" | head -n 1 || true)"
if [[ -n "$running_pid" ]]; then
    echo "Stopping running DisplayHarbor ($running_pid)"
    kill "$running_pid"
    for _ in {1..100}; do
        kill -0 "$running_pid" 2>/dev/null || break
        sleep 0.1
    done
    if kill -0 "$running_pid" 2>/dev/null; then
        echo "DisplayHarbor did not stop gracefully; sending SIGKILL" >&2
        kill -KILL "$running_pid"
    fi
fi

swift build -c release

swift "$project_dir/Scripts/generate-app-icon.swift" "$project_dir/Resources/AppIcon.icns"

rm -rf "$app_dir"
mkdir -p "$app_dir/Contents/MacOS"
mkdir -p "$app_dir/Contents/Resources"
cp "$project_dir/.build/arm64-apple-macosx/release/DisplayHarbor" "$app_dir/Contents/MacOS/DisplayHarbor"
cp "$project_dir/Resources/Info.plist" "$app_dir/Contents/Info.plist"
app_version="${DISPLAYHARBOR_VERSION:-0.1.1}"
app_version="${app_version#v}"
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $app_version" "$app_dir/Contents/Info.plist"
cp "$project_dir/Resources/AppIcon.icns" "$app_dir/Contents/Resources/AppIcon.icns"
cp -R "$project_dir/Resources/"*.lproj "$app_dir/Contents/Resources/"

signing_identity="${DISPLAYHARBOR_SIGNING_IDENTITY:-DisplayHarbor Development}"
if security find-identity -v -p codesigning 2>/dev/null | grep -Fq "\"$signing_identity\""; then
    codesign --force --deep --sign "$signing_identity" "$app_dir" >/dev/null
    echo "Signed with $signing_identity"
else
    echo "Warning: stable signing identity not found; using ad hoc signing." >&2
    echo "Run ./setup-dev-signing.sh once to preserve Accessibility permission across builds." >&2
    codesign --force --deep --sign - "$app_dir" >/dev/null
fi
echo "Built $app_dir"
