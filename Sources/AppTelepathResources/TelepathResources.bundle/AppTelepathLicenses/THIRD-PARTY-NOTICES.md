# Telepath iOS SDK — 第三方代码声明（Third-Party Notices）

> 最近校准：2026-08-10
> 审计范围：根 `Telepath.podspec` 会编入 SDK 二进制的全部源码，不只限于 `ThirdParty/` 目录。
> 2026-07-27 更新：4 个来源不明的目录已全部清除（3 项自研重写、1 项删除）；内嵌 FLEX 亦已整体移除。
> 现存第三方来源均已登记；许可原文、来源说明与修改声明由发行脚本一并装包。

Telepath iOS SDK 内嵌（vendored）并改编了若干第三方开源代码。多数相关符号加了 `TLP` / `TLP_` 前缀以避免与宿主 App 冲突。**加前缀与裁剪均属于修改行为**，不改变原许可对署名与声明保留的要求。

本文件是**商业分发的前置合规文档**。

> **注意**：项目已决定[默认闭源、SDK 以二进制分发](../../docs/LICENSING.md)。**闭源与二进制分发并不免除以下义务**——BSD / MIT / Apache-2.0 对二进制分发同样要求保留署名与许可声明。发行包必须包含本文件以及 `ThirdPartyLicenses/` 下对应组件的 LICENSE 与 ORIGIN。

---

## 1. 已确认许可

| 组件 | 上游 | 版权方 | 许可 | 仓库内许可文件 |
|---|---|---|---|---|
| **SocketRocket** `ThirdParty/SocketRocket/` | Square（**旧版**，见 §3） | Square Inc. (2012) | Apache License 2.0 | ✅ `SocketRocket/LICENSE` |
| **fishhook** `ThirdParty/fishhook/` | [facebook/fishhook](https://github.com/facebook/fishhook) | Facebook, Inc. (2013) | BSD 3-Clause | ✅ `fishhook/LICENSE` |
| **MTAppenderFile** `ThirdParty/MTAppenderFile/` | [meitu/MTAppenderFile](https://github.com/meitu/MTAppenderFile)，部分代码派生自 Tencent Mars xlog | Meitu / meitu.com（2017、2019–）；THL A29 Limited（2016） | MIT | ✅ `MTAppenderFile/LICENSE`（同时保留 Meitu 与 THL 版权） |
| **DBDebugToolkit 派生文件**（见下方清单） | [dbukowski/DBDebugToolkit](https://github.com/dbukowski/DBDebugToolkit) | Dariusz Bukowski (2016–2017) | MIT | ✅ `../ThirdPartyLicenses/DBDebugToolkit/LICENSE` |

DBDebugToolkit 派生范围以仍保留其版权与 MIT 许可头的文件为准，当前包括：

- `Plugins/Common/Location/TLPLocationModel.h`；
- `Plugins/Common/NSLog/TLPNSLogDataProvider.*`；
- `Plugins/Performance/CrashRecorder/` 下的 `TLPCrashReport.*`、`TLPCrashReportsToolkit.*`；
- `Utility/Categories/NSObject+TLP.*`（仅 swizzle 部分）。

3.0.0 移除端内面板时，`Core/Triggers/`、`CLLocationManager+DBLocationToolkit.*`、
`TLPCustomLocationViewController.h` 与崩溃详情 UI 一并删除，已从上面的清单中去掉。

## 2. 来源不明的内嵌代码

审计发现 4 项内嵌代码的来源信息在引入时被清除或改写，**无法仅从代码判断上游与许可**。**4 项现已全部清除**：3 项自研重写替换，1 项整体删除。

### 2.1 ✅ 已清除（2026-07-27 自研重写并删除）

以下三项来源不明的内嵌代码**已整体删除并以自研实现替换**，不再构成分发风险：

| 原组件 | 替换为 | 实现要点 |
|---|---|---|
| `ThirdParty/Reachability/` | `Core/Probes/Network/TLPNetworkState` | 基于 Network.framework 的 `NWPathMonitor`，而非流传甚广的 SCNetworkReachability 示例代码（后者正是各种来源不明副本的源头）；蜂窝制式取自 CoreTelephony |
| `ThirdParty/TLPBacktrace/` | `Core/Probes/Diagnostics/TLPBacktrace` | `backtrace(3)` 捕获 + `dladdr` 惰性符号化。**不再用 fishhook 重绑定 GCD 符号**——给客户 App 的调试 SDK 改写系统符号风险过高，且旧实现自述与 dyld hook 并用会死锁 |
| `ThirdParty/ThreadStackUtil/` | `Core/Probes/Diagnostics/TLPThreadStack` | mach `thread_suspend` + `thread_get_state` + 帧指针回溯；栈内存一律经 `vm_read_overwrite` 安全读取，正确处理 arm64e 指针认证，所有路径保证恢复线程。纯 C/ObjC，去掉了对 C++ 的依赖 |

改接的调用方：`TLPCpuMonitor`、`TLPIOMonitor`、`TLPThreadStackUtil`、`TLPMethodTraceCore`、`TLPCrashReportsToolkit`。

### 2.2 ✅ 已清除（2026-07-27 删除）

| 原组件 | 处置 |
|---|---|
| `ThirdParty/ResourceMonitor/` | **整体删除**，连同仅依赖它的端内 `Plugins/Performance/PerformanceMonitor` 插件与同源的 `Utility/TLPThread`。agent 侧 `perf.snapshot` 本就是自建实现，不受影响。性能能力改由「SDK 采集 → 命令层 → 控制台」承接，规划见 [PERFORMANCE-ROADMAP.md](../../docs/PERFORMANCE-ROADMAP.md) |

**至此 `ThirdParty/` 下已无来源不明的内嵌代码。**

## 3. 曾经的两项商业化阻塞（已随 FLEX 移除解除）

2026-07-27 移除内嵌 FLEX 后，审计中最严重的两条限制**同时消失**：

- **⛔→✅ FLEX 许可禁止 App Store 分发**：其 LICENSE 在标准 BSD-3 之外多一条具约束力的条款
  「You must NOT include this project in an application to be submitted to the App Store™」。
  只要内嵌 FLEX，SDK 就永远不能进入任何拟提交 App Store 的构建。**该库已删除，此约束解除。**
  （注：[分发策略](../../docs/DISTRIBUTION-POLICY.md)出于**安全**考虑仍禁止 App Store 正式包，
  但那是我们自己的产品决定，不再是第三方许可强加的义务。）
- **⛔→✅ APSL-2.0 文件级 copyleft**：`TLP_FLEXObjcInternal.mm` 受 Apple Public Source License 2.0
  约束，即使闭源二进制分发也须公开对该文件的修改，与闭源策略直接冲突。**该文件随 FLEX 删除。**
- **FLEXWindow 派生残留**：复审发现 `TLPWindow` 仍保留 FLEXWindow 的私有 selector 实现。现已删除该实现并以只使用公开 UIKit API 的轻量 overlay window 重写，不再包含 FLEX 派生代码。

### 3.1 SocketRocket 内嵌的是 Square 旧版

内嵌副本的文件头是 **Square Inc. (2012) / Apache License 2.0**。上游项目此后转由 Facebook 维护并
改用 BSD 许可——**以内嵌副本的许可为准，即 Apache-2.0**，不可套用上游现行许可。Apache-2.0 §4
要求随分发提供许可副本（已补 `SocketRocket/LICENSE`）并**声明所做修改**（加 `TLP` 前缀属修改）。
`TLP_SRWebSocket.h/.m` 顶部已加入显著修改声明；完整来源与修改摘要见同目录 `ORIGIN.md`，二者均进入发行包。

## 4. 待办清单

| # | 事项 | 状态 |
|---|---|---|
| 1 | 补入 QMUI / SocketRocket / fishhook 的上游 LICENSE 原文 | ✅ **已完成**（2026-07-27，逐字取自上游）；QMUI 已于 3.0.0 整个移除，不再分发 |
| 2 | ~~确认 §2 四项的上游与许可~~ | ✅ **已全部清除**：3 项自研重写（§2.1）、1 项删除（§2.2） |
| 3 | ~~替换 `TLP_FLEXObjcInternal.mm`，移除 APSL-2.0 代码~~ | ✅ 已随 FLEX 整体删除 |
| 4 | 各第三方来源补来源与修改说明 | ✅ **已完成**；历史取用版本未保留的条目如实标记未知，不用推断填空 |
| 5 | ~~向下游传递「含私有 API，禁止 App Store 分发」的许可义务~~ | ✅ 已随 FLEX 删除而消失。产品侧的分发限制仍在，见 [DISTRIBUTION-POLICY.md](../../docs/DISTRIBUTION-POLICY.md) |
| 6 | ~~推进内嵌 FLEX 移除~~ | ✅ **已完成**：全仓引用归零后整体删除 |
| 7 | 发行包附带第一方 LICENSE、汇总 notices 与每个第三方许可原文/来源说明 | ✅ **已进入构建脚本与合规门禁** |

> **审计口径说明**：本文档只记录可从代码与上游公开信息核实的事实。凡无法核实的，一律列入 §2 而不作推定——许可问题上的"看起来像"没有价值。
