# 专注番茄钟（iOS 版）

SwiftUI 写的小番茄钟：25 分钟专注、5 分钟休息，圆环显示进度，时间到震动提醒并自动切换模式，完成的番茄数会存下来。

## 在 Mac 上装到 iPad / iPhone（约 5 分钟）

1. 打开 **Xcode**，选 File → New → Project → iOS → **App**，点 Next。
2. Product Name 填 **FocusTimer**，Interface 选 **SwiftUI**，Language 选 **Swift**，其余默认，Next 保存。
3. 点开左侧的 **ContentView.swift**，内容全选删掉，换成本仓库 `ContentView.swift` 的全部内容。
4. 数据线连上 iPad/iPhone，Xcode 顶部把运行设备选成它。
5. 项目设置 Signing & Capabilities 里，Team 选自己的 Apple ID（免费账号就行）。
6. 点 ▶ 运行。第一次打开提示"不受信任的开发者"的话，去设备 设置 → 通用 → VPN 与设备管理 里信任。

免费 Apple ID 签的 App 有效期 7 天，过期后连上 Mac 再点一次 ▶ 即可续上。

## 玩法

- 开始/暂停/继续、重置
- 「专注 25 分钟」和「休息 5 分钟」一键切换
- 专注结束自动记一个番茄，并切到休息模式
