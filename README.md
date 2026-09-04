# DisplayHarbor

[简体中文](README.zh-CN.md)

DisplayHarbor is a native macOS menu bar utility that remembers where your app windows belong. It detects the current display setup, stores per-app window rules, and restores those rules when an app launches or your connected displays change.

## Features

- Detect the active app and its standard windows from the menu bar.
- Save window display, position, size, and full-screen state.
- Restore multiple windows for the same app in one operation.
- Keep rules separate for different physical display setups.
- Create named workspaces (scenarios) inside each display setup.
- Fork, rename, switch, and delete workspaces.
- Automatically re-apply rules after displays connect, disconnect, or change arrangement.
- Open and restore all currently unopened apps in the active workspace.
- Inspect and maintain display setups and app rules in the management window.
- Follow the macOS preferred language (English and Simplified Chinese are included).

## Requirements

- macOS 14 or later.
- Apple Silicon (the current release workflow produces an arm64 build).
- Accessibility permission for DisplayHarbor.

On first launch, allow DisplayHarbor to control your windows in:

`System Settings → Privacy & Security → Accessibility`

## Install from GitHub Release (recommended)

For normal use, download the latest arm64 build from the [GitHub Releases page](https://github.com/mitaraifail/displayharbor/releases/latest). Do not use `swift run` or `build-app.sh` unless you are developing DisplayHarbor.

1. Download the `.zip` asset. The `.sha256` file is only a checksum, not an installer.
2. Verify the archive from Terminal:

   ```bash
   archive="DisplayHarbor-v0.1.1-macos-arm64.zip"
   shasum -a 256 -c "$archive.sha256"
   ```

3. Extract it and move the app to `/Applications`:

   ```bash
   ditto -x -k "$archive" .
   mv DisplayHarbor.app /Applications/
   ```

4. This release is not notarized. The first time, Control-click `DisplayHarbor.app` in Finder, choose **Open**, and confirm. If **Open** is not offered, go to **System Settings → Privacy & Security** and click **Open Anyway** for DisplayHarbor, then try again.
5. If macOS still blocks the app after the checksum passes, and you trust the download source, remove the quarantine flag from this app bundle only:

   ```bash
   xattr -dr com.apple.quarantine /Applications/DisplayHarbor.app
   open /Applications/DisplayHarbor.app
   ```

If Finder shows a generic placeholder icon, relaunch Finder after installation. If macOS reports that the app is damaged, download the Release again and verify its checksum before trying anything else.

## Updating

The current release uses manual updates: download the newer archive from the [GitHub Releases page](https://github.com/mitaraifail/displayharbor/releases/latest), quit DisplayHarbor, replace `/Applications/DisplayHarbor.app`, and launch it again. Your rules stay in `~/Library/Application Support/DisplayHarbor/environments.json` and are not removed when the app is replaced.

An in-app update flow is not included yet. When Developer ID signing and notarization are enabled, Sparkle 2 can provide signed, user-confirmed updates through an appcast feed.

## Run from source

```bash
swift run
```

To build a double-clickable app bundle:

```bash
zsh build-app.sh
open dist/DisplayHarbor.app
```

For local development, create a stable development signing identity once before rebuilding:

```bash
zsh setup-dev-signing.sh
zsh build-app.sh
open dist/DisplayHarbor.app
```

The development identity is local-only. GitHub Release artifacts are ad-hoc signed and are not notarized. On first launch of a downloaded release, Control-click the app and choose **Open** if macOS asks for confirmation.

## Usage

1. Launch DisplayHarbor and grant Accessibility permission.
2. Arrange your app windows on the desired displays.
3. Open DisplayHarbor from the menu bar.
4. Save the current layout for the active app.
5. Open **Manage Setups & App Rules** to inspect rules and workspaces.
6. Use **Apply Current Workspace** to open unopened apps and restore their saved windows.

Rules are stored at:

`~/Library/Application Support/DisplayHarbor/environments.json`

User-defined display setup names, workspace names, and app rule data are preserved as entered. Built-in labels are localized at runtime, so changing the macOS preferred language takes effect after restarting the app.

## GitHub Releases

Releases are built automatically by [`.github/workflows/release.yml`](.github/workflows/release.yml) whenever a `v*` tag is pushed:

```bash
git tag v0.1.1
git push origin v0.1.1
```

The workflow builds, verifies, and uploads:

- `DisplayHarbor-<version>-macos-arm64.zip`
- the matching `.sha256` checksum file

## Display setups and workspaces

DisplayHarbor identifies a display setup from the connected physical displays, their arrangement, resolutions, and main-display relationship. Rules from one setup do not overwrite rules from another setup.

Each setup starts with a built-in **Default** workspace. You can create a new workspace by copying the current one, then rename, switch, or delete it. The built-in Default workspace is always presented in the current interface language.

## Current limitations

- Multi-window matching uses window title, saved size, and window order; a changed window ID alone does not prevent restoration.
- Automatic restoration moves windows that already exist. It does not create missing windows.
- DisplayHarbor does not actively switch macOS Spaces or create native full-screen Spaces.
- The current release is arm64-only and uses ad-hoc signing without notarization.

## License

No license has been selected yet.
