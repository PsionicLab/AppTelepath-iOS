// swift-tools-version:5.9
//
// AppTelepath —— SwiftPM 接入。
//
// 本文件由 scripts/build-ios-binary.sh 按模板生成，版本号与 checksum 构建时填入；
// 手改无效，下次发版会被覆盖。
//
// ⚠️ **接入方必须给 App target 加 `-ObjC`**（Build Settings → Other Linker Flags）。
// xcframework 里是静态库，而 SDK 有多个只含 category 的编译单元；缺这个标志时链接器
// 不会把它们拉进来，表现是运行时 unrecognized selector，**不是链接报错**。
// CocoaPods 会自动加，SwiftPM 不会——它禁止依赖包使用 unsafeFlags，这一步只能由你做。
// SDK 启动时会自检，缺失时打印醒目告警。

import PackageDescription

let package = Package(
    name: "AppTelepath",
    platforms: [.iOS(.v13)],
    products: [
        // 只暴露资源 target；它依赖二进制，链接时会把二进制一起带上。
        // 装上之后 ObjC 用 `#import <Telepath/Telepath.h>`，Swift 用 `import Telepath`
        // ——与 CocoaPods 一致，模块名始终是 Telepath。
        .library(name: "AppTelepath", targets: ["AppTelepathResources"]),
    ],
    targets: [
        .binaryTarget(
            name: "Telepath",
            url: "https://github.com/PsionicLab/AppTelepath-iOS/releases/download/3.2.0/Telepath-3.2.0.zip",
            checksum: "6b8f2e80904992c80df97e1912424d7549037db14123c2a6800fd703d27e43f1"
        ),
        // 资源必须由**普通 target** 交付：binaryTarget 不能声明 resources，
        // 而悬浮球图标与本地化都在 TelepathResources.bundle 里。
        // SwiftPM 会把它套进 AppTelepath_AppTelepathResources.bundle，
        // SDK 的 NSBundle+TLP 认得这种多一层的落位。
        .target(
            name: "AppTelepathResources",
            dependencies: ["Telepath"],
            path: "Sources/AppTelepathResources",
            resources: [.copy("TelepathResources.bundle")],
            linkerSettings: [
                .linkedLibrary("c++"),
                .linkedLibrary("sqlite3"),
                .linkedLibrary("z"),
                .linkedFramework("Network"),
                .linkedFramework("CoreTelephony"),
            ]
        ),
    ]
)
