DisplayHarbor
=============

English
-------
1. Verify the downloaded DMG with the matching `.sha256` file from GitHub Releases.
2. Drag `DisplayHarbor.app` to the `Applications` folder.
3. The first time you open it, Control-click the app in Finder and choose Open.
   If macOS still blocks it, use System Settings > Privacy & Security > Open Anyway.
4. Alternatively, after verifying the checksum, advanced users may double-click
   `Open DisplayHarbor (Advanced).app` directly from the mounted DMG. After you
   confirm, it installs or replaces `DisplayHarbor.app` in `Applications`, removes
   the quarantine marker from that exact app path, and starts it. If macOS blocks
   this helper the first time, Control-click it in Finder and choose Open. It does
   not grant Accessibility permission.
5. Grant DisplayHarbor access in System Settings > Privacy & Security > Accessibility.

简体中文
--------
1. 使用 GitHub Release 中对应的 `.sha256` 文件校验下载的 DMG。
2. 将 `DisplayHarbor.app` 拖到“应用程序”文件夹。
3. 第一次打开时，在 Finder 中按住 Control 点按 App，选择“打开”。
   如果 macOS 仍然拦截，请到“系统设置 → 隐私与安全性 → 仍要打开”。
4. 另一种方式是：校验 checksum 后，直接在已挂载的 DMG 中双击
   `Open DisplayHarbor (Advanced).app`。确认后，它会将 `DisplayHarbor.app` 安装或替换到“应用程序”，
   移除这个精确 App 路径的隔离标记并启动。如果 macOS 第一次拦截这个辅助 App，请在 Finder 中按住
   Control 点按它并选择“打开”。它不会授予辅助功能权限。
5. 请到“系统设置 → 隐私与安全性 → 辅助功能”授予 DisplayHarbor 权限。

This release is not notarized. The advanced launcher intentionally bypasses
macOS quarantine for this one app only; use the normal Finder flow whenever possible.
