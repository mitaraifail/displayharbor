# Display-aware workspace restore 产品调研

> 产品现名：DisplayHarbor（原名 AppDock）

> 调研日期：2026-09-03  
> 目的：比较 Snapback、Layoutish 与 DisplayHarbor，明确“显示器环境感知 + 工作区恢复”方向的竞争位置和后续优先级。

## 结论摘要

- **Snapback** 的优势是“完整工作区快照”：一次保存整个桌面，恢复所有 App、窗口、位置和显示器，适合多个工作模式之间的一键切换。
- **Layoutish** 与 DisplayHarbor 最接近：都把显示器组合当成布局匹配条件，并能在恢复时启动未运行的 App。它目前在虚拟桌面、快捷键和定时恢复方面更完整。
- **DisplayHarbor** 的差异化机会不是复制“全桌面快照”，而是做成一个可解释、可管理的“显示器环境 → App 规则”控制面板：用户能看见当前环境、每个 App 的规则、保存状态和恢复结果。

如果只比较功能广度：**Snapback > Layoutish > DisplayHarbor**。  
如果比较与 DisplayHarbor 的产品方向相似度：**Layoutish ≈ DisplayHarbor > Snapback**。

## 产品能力对比

| 维度 | Snapback | Layoutish | DisplayHarbor（当前原型） |
|---|---|---|---|
| 核心模型 | 整个工作区快照 | 命名布局 + 显示器 profile | 显示器环境下的 App/窗口规则 |
| 多显示器 | 支持，官方宣传最多 6 个显示器 | 支持不同显示器配置 | 支持，按显示器身份、位置、尺寸、主屏关系识别 |
| 环境自动匹配 | 插拔、唤醒等场景自动恢复 | 连接/断开显示器时自动应用对应布局 | 显示器参数变化后重新识别并恢复当前环境规则 |
| App 启动 | 恢复时自动重新打开缺失 App | 恢复时自动打开缺失 App | 支持快捷打开并恢复当前环境中未运行的 App；App 启动后也会尝试恢复 |
| 多工作模式 | 支持多个命名 workspace | 支持多个命名 layout | 当前一个显示器环境基本对应一套 App 规则 |
| 虚拟桌面 / Spaces | 不直接依赖 Spaces，主要恢复窗口位置 | 明确支持跨虚拟桌面保存 | 当前未完整支持 Spaces 切换或创建 |
| 定时恢复 | Pro/高级功能支持 | 支持定时应用布局 | 当前未支持 |
| 窗口平铺/吸附 | 支持 | 不是主要卖点 | 当前不是主要目标 |
| 单个 App 规则管理 | 相对偏整体 | 主要围绕布局 | 强：可查看、删除和维护某个环境下的单个 App 规则 |
| 状态可解释性 | 偏“保存/恢复工作区” | 偏“应用布局” | 可显示“未保存 / 已保存·当前一致 / 已保存·当前有变化” |

## Snapback

### 官方功能事实

Snapback 将所有打开的 App、窗口位置、窗口大小和所属显示器保存为一个 workspace，并支持一键恢复；官方页面还强调了关闭的 App 会被重新打开、显示器插拔后布局会自动适配。[官方主页](https://snapbackapp.com/)  

帮助文档进一步说明：workspace 是包含所有 App、窗口位置/尺寸和显示器归属的完整布局；缺失显示器上的窗口会被跳过，整个 workspace 只有一块屏幕时可以降级到可用屏幕。[帮助中心](https://snapbackapp.com/help/)

高级版本还提供命令面板、自定义布局，以及同时打开 App、项目、网址和执行命令的能力。[Snapback Pro](https://snapbackapp.com/pro/)

### 相对 DisplayHarbor 的优点

1. **整体恢复更完整**：用户不需要逐个 App 保存规则。
2. **工作模式更清晰**：多个命名 workspace 适合“开发、会议、写作”等场景切换。
3. **自动化广度更大**：显示器变化、重启、项目/网址/命令等都可以纳入恢复流程。
4. **窗口管理能力更丰富**：除了恢复，还覆盖平铺、吸附和自定义布局。

### 相对 DisplayHarbor 的不足

1. 整体快照模型不如 DisplayHarbor 的“环境 → App 规则”透明；用户更难快速回答“某个 App 在这个环境下为什么这样放”。
2. 对只想恢复一个 App 的用户，恢复整个 workspace 可能过重。
3. 产品重点是工作区快照，而不是显示器环境的规则管理；这给 DisplayHarbor 留出了更细粒度的管理空间。

## Layoutish

### 官方功能事实

Layoutish 以保存和恢复完整窗口布局为核心，记录 App、窗口和位置；它提供不同显示器配置的 profiles，并在显示器连接/断开时自动应用匹配布局。[官方产品页](https://appish.app/layoutish)

官方页面还明确提到：未运行的 App 会在恢复时自动打开；布局可以通过点击或快捷键恢复，并支持跨多个显示器和虚拟桌面保存。[官方产品页](https://appish.app/layoutish)

### 相对 DisplayHarbor 的优点

1. **与 DisplayHarbor 最接近**：显示器组合本身就是布局选择条件。
2. **自动恢复链路更完整**：检测显示器 profile、启动缺失 App、定位窗口。
3. **用户工作流更成熟**：命名布局、全局快捷键、定时恢复和跨虚拟桌面能力较完整；定时恢复由其官方博客进一步说明。[官方博客](https://appish.app/blog/mac-save-window-positions-automatically-restore)
4. **对复杂 App 的恢复策略更积极**：公开资料提到会对部分启动后尚未准备好的 App 重试定位。

### 相对 DisplayHarbor 的不足

1. 公开产品叙事更偏“保存布局”，而不是“维护环境下的 App 规则”。
2. 当用户只需要检查或修改一个 App 时，布局级模型可能不如 DisplayHarbor 的单 App 管理直接。
3. 自动应用布局可能更像黑盒；DisplayHarbor 可以把匹配的环境、规则数量、当前一致性直接展示出来。

## DisplayHarbor 当前原型的定位

当前代码见 [`Sources/DisplayHarbor/main.swift`](../../Sources/DisplayHarbor/main.swift)，主要模型是：

1. 使用当前连接显示器的物理身份、排列位置、分辨率、可用区域和主屏关系生成环境签名。
2. 每个环境分别保存多个 App 的规则；每条规则记录 App、窗口标题、窗口序号、显示器和相对位置/尺寸。
3. App 启动后尝试恢复该 App 在当前环境中的窗口。
4. 显示器环境变化后，对已运行且有匹配规则的 App 重新布局。
5. 菜单栏面板显示当前 App 的显示器、环境、尺寸、布局、规则和状态。
6. 当前环境存在未运行的规则 App 时，提供“快捷打开与恢复”，并在 hover 中说明未打开的 App。
7. 管理页支持查看、重命名和删除环境，以及删除单个 App 规则。

### DisplayHarbor 的核心优势

- **环境是一级概念**：不是把所有布局混成一张表，而是明确区分书房、办公室、移动办公等显示器环境。
- **规则可解释**：用户能看到某个 App 保存在哪些屏幕、多少个窗口、是否独占桌面，以及当前是否一致。
- **渐进式恢复**：可以只恢复当前 App，或只打开当前环境中缺失的 App，而不必每次重建整个工作区。
- **产品边界清楚**：重点是“窗口应该属于哪个显示器环境”，而不是同时变成通用平铺工具。

### DisplayHarbor 当前短板

- 同一个显示器环境暂时只有一套规则，缺少“开发/会议/写作”等多个命名工作模式。
- 保存以 App 为单位，尚未提供一次性保存整个环境工作区的入口。
- 尚未完整支持 macOS Spaces、定时触发、项目/网址/命令编排和窗口平铺。
- 当前环境签名较严格；显示器身份、排列或尺寸发生变化时，可能被识别为新环境，而不是兼容的旧环境。
- App 是否真正打开、窗口是否已经恢复，需要继续提高检测稳定性和错误反馈。

## 建议的产品差异化

### 1. 保留“环境 → App 规则”作为核心抽象

不要直接改造成 Snapback 式的全局快照。建议保留当前信息架构，并在其上增加“环境内多个布局 profile”：

```text
显示器环境
└── 工作模式（可选）
    └── App 规则
        └── 窗口规则
```

这样既保留 DisplayHarbor 的可解释性，又能覆盖 Layoutish/Snapback 的多工作模式需求。

### 2. 把环境匹配做成可解释的兼容匹配

不要只显示“匹配/不匹配”，而应告诉用户：

- 完全匹配：显示器身份、排列和尺寸均一致；
- 兼容匹配：显示器身份一致，但分辨率或可用区域变化；
- 降级匹配：目标显示器缺失，窗口将移动到主屏或跳过；
- 无匹配：需要创建新环境或手动选择布局。

这会成为 DisplayHarbor 相对竞品最有辨识度的体验之一。

### 3. 强化“恢复前预览”和“恢复后结果”

快捷操作 hover 或点击后，应能明确展示：

- 将打开哪些 App；
- 哪些 App 已经打开；
- 哪些窗口可以恢复；
- 哪些显示器缺失；
- 哪些 App/窗口恢复失败及原因。

### 4. 把自动化策略做成用户可选的恢复政策

建议至少提供三种策略：

- 仅恢复已打开 App；
- 自动打开规则中的缺失 App；
- 询问后打开并恢复全部缺失 App。

这样可以避免用户觉得 DisplayHarbor 擅自启动太多 App。

## 后续优先级

### P0：可靠性

- 修正 App 前台/运行状态检测；
- 处理启动延迟、窗口尚未创建、权限不足等失败状态；
- 恢复后重新检测并展示结果；
- 对显示器轻微变化增加兼容匹配和降级策略。

### P1：产品完整性

- 同一环境支持多个命名布局；
- 一次保存当前环境的全部 App 规则；
- 支持“恢复当前环境”与“只恢复当前 App”两个层级；
- 增加恢复前预览。

### P2：扩展能力

- Spaces 支持；
- 定时或登录触发；
- 项目、网址和命令编排；
- 可选的窗口平铺/吸附能力。

## 命名启示

市场命名大多使用 `Layout`、`Workspace`、`Restore`、`Scene` 等功能词。`AppDock` 容易被理解成 App 启动坞，`AppLayout` 又过于通用。DisplayHarbor 更强调显示器环境和窗口归位，再用副标题解释功能：

- `WindowOrbit · 按显示器环境恢复 App 工作区`
- `WindowHarbor · Display-aware workspace restore`
- `DisplayContext · 显示器环境感知的工作区恢复`

这些名称仅做公开网页/GitHub/App Store 的初筛，不等于正式的商标、域名或 App Store 可用性清查。

## 参考资料

- [Snapback 官方主页](https://snapbackapp.com/)
- [Snapback 帮助中心](https://snapbackapp.com/help/)
- [Snapback Pro](https://snapbackapp.com/pro/)
- [Layoutish 官方产品页](https://appish.app/layoutish)
- [Layoutish 官方博客：自动保存和恢复窗口布局](https://appish.app/blog/mac-save-window-positions-automatically-restore)
- [DisplayHarbor 当前原型代码](../../Sources/DisplayHarbor/main.swift)
- [DisplayHarbor 原型 README](../../README.md)

## DisplayHarbor 名称复核（2026-09-03）

- GitHub 仓库/代码与 App Store 的精确检索中，未发现名为 `DisplayHarbor` 的成熟 macOS 窗口管理或工作区恢复产品；这只是公开网页初筛，不等于商标清查结论。
- `displayharbor.com` 当前已被一个邮件/营销统计 tracking domain 使用，不能视为可直接注册或适合作为官网域名。[displayharbor.com](https://displayharbor.com/)
- App Store 中存在名为 `Harbor` 的 macOS 下载管理器，但不是 `DisplayHarbor`，产品类别也不同。[Harbor - File Manager Hub](https://apps.apple.com/us/app/harbor-file-manager-hub/id6787646121?mt=12)
- 因此，**DisplayHarbor 作为产品名可以继续使用，但官网域名和正式商标仍需单独确认**；优先考虑可用的 `.app`、`.dev` 或其他新域名，并在发布前完成商标检索。
