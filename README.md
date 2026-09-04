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
git tag v0.1.0
git push origin v0.1.0
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
