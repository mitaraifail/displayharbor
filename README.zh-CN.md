# DisplayHarbor

[English](README.md)

DisplayHarbor 是一个原生 macOS 菜单栏工具，用来记住每个 App 窗口应该出现的位置。它会识别当前显示器环境，为 App 保存窗口规则，并在 App 启动或显示器发生变化时恢复这些规则。

## 功能

- 从菜单栏识别当前 App 和标准窗口。
- 保存窗口所在显示器、位置、大小和全屏状态。
- 一次恢复同一个 App 的多个窗口。
- 为不同的物理显示器环境分别保存规则。
- 在每个显示器环境下创建命名情景。
- 支持复制、新建、重命名、切换和删除情景。
- 显示器连接、断开或重新排列后自动重新应用规则。
- 一键打开当前情景中尚未运行的 App，并恢复窗口。
- 在管理窗口中查看和维护显示器环境及 App 规则。
- 跟随 macOS 首选语言（内置 English 和简体中文）。

## 系统要求

- macOS 14 或更高版本。
- Apple Silicon（当前 Release 流程生成 arm64 版本）。
- DisplayHarbor 的辅助功能权限。

首次运行时，请在以下位置允许 DisplayHarbor 控制窗口：

`系统设置 → 隐私与安全性 → 辅助功能`

## 从源码运行

```bash
swift run
```

生成可双击运行的 App：

```bash
zsh build-app.sh
open dist/DisplayHarbor.app
```

本地开发时，建议先创建一次稳定的开发签名：

```bash
zsh setup-dev-signing.sh
zsh build-app.sh
open dist/DisplayHarbor.app
```

开发签名只用于本机。GitHub Release 构建使用 ad-hoc 签名，不包含公证。首次打开下载的版本时，如果 macOS 要求确认，请按住 Control 点按 App，然后选择“打开”。

## 使用方式

1. 启动 DisplayHarbor 并授予辅助功能权限。
2. 将 App 窗口摆放到目标显示器。
3. 从菜单栏打开 DisplayHarbor。
4. 为当前 App 保存布局。
5. 打开“管理环境与 App 规则”查看规则和情景。
6. 使用“应用当前情景”打开尚未运行的 App，并恢复已保存窗口。

规则保存在：

`~/Library/Application Support/DisplayHarbor/environments.json`

用户自定义的环境名、情景名和 App 规则会按输入原样保留。内置文案会在运行时本地化，因此切换 macOS 首选语言后，重启 App 即可生效。

## GitHub Release

推送 `v*` tag 后，[`.github/workflows/release.yml`](.github/workflows/release.yml) 会自动构建并发布：

```bash
git tag v0.1.0
git push origin v0.1.0
```

工作流会构建、验证并上传：

- `DisplayHarbor-<version>-macos-arm64.zip`
- 对应的 `.sha256` 校验文件

## 安装 GitHub Release

1. 从 Release 页面下载 `.zip` 文件。`.sha256` 只是校验文件，不是安装程序。
2. 在终端中校验下载内容：

   ```bash
   shasum -a 256 -c DisplayHarbor-v0.1.0-macos-arm64.zip.sha256
   ```

3. 解压并将 `DisplayHarbor.app` 移动到 `/Applications`：

   ```bash
   ditto -x -k DisplayHarbor-v0.1.0-macos-arm64.zip .
   mv DisplayHarbor.app /Applications/
   ```

4. 当前 Release 尚未公证。首次打开时，在 Finder 中按住 Control 点按 `DisplayHarbor.app`，选择“打开”并确认提示。不要把 `.zip` 或 `.sha256` 文件当作 App 打开。
5. 如果校验通过后 macOS 仍然拦截，可以只移除这个 App 包的隔离标记，然后启动：

   ```bash
   xattr -dr com.apple.quarantine /Applications/DisplayHarbor.app
   open /Applications/DisplayHarbor.app
   ```

   Release 包已经包含生成好的 DisplayHarbor 图标；如果 Finder 仍显示缓存的占位图标，可以重新启动 Finder。

## 显示器环境与情景

DisplayHarbor 根据已连接的物理显示器、排列位置、分辨率和主屏关系识别显示器环境。不同环境的规则互不覆盖。

每个环境默认包含一个内置“默认”情景。你可以复制当前情景创建新情景，然后进行重命名、切换或删除。内置默认情景会始终按当前界面语言显示。

## 当前限制

- 多窗口匹配使用窗口标题、保存时尺寸和窗口顺序；窗口 ID 改变本身不会阻止恢复。
- 自动恢复只会移动已经存在的窗口，不会创建缺少的窗口。
- DisplayHarbor 不会主动切换 macOS Space，也不会创建原生全屏 Space。
- 当前 Release 仅支持 arm64，并使用未公证的 ad-hoc 签名。

## License

暂未选择许可证。
