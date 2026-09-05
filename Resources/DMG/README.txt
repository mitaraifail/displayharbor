DisplayHarbor
=============

English
-------
1. Verify the downloaded DMG with the matching `.sha256` file from GitHub Releases.
2. Drag `DisplayHarbor.app` to the `Applications` folder.
3. The first time you open it, Control-click the app in Finder and choose Open.
   If macOS still blocks it, use System Settings > Privacy & Security > Open Anyway.
4. Only after verifying the checksum, advanced users may double-click
   `Open DisplayHarbor (Advanced).command`. It removes the quarantine marker from
   this exact app path and starts it. It does not grant Accessibility permission.
5. Grant DisplayHarbor access in System Settings > Privacy & Security > Accessibility.

简体中文
--------
1. 使用 GitHub Release 中对应的 `.sha256` 文件校验下载的 DMG。
2. 将 `DisplayHarbor.app` 拖到“应用程序”文件夹。
3. 第一次打开时，在 Finder 中按住 Control 点按 App，选择“打开”。
   如果 macOS 仍然拦截，请到“系统设置 → 隐私与安全性 → 仍要打开”。
4. 只有在校验 checksum 后，高级用户才可以双击
   `Open DisplayHarbor (Advanced).command`。它只会移除这个精确 App 路径的隔离标记并启动，
   不会授予辅助功能权限。
5. 请到“系统设置 → 隐私与安全性 → 辅助功能”授予 DisplayHarbor 权限。

This release is not notarized. The advanced launcher intentionally bypasses
macOS quarantine for this one app only; use the normal Finder flow whenever possible.
