//
//  AppTelepathResources.h
//
//  这个 target 存在的唯一理由是交付 TelepathResources.bundle——
//  SwiftPM 的 binaryTarget 不能声明 resources。接口全在二进制里，
//  用 `#import <Telepath/Telepath.h>`（Swift 用 `import Telepath`）。
//

#import <Foundation/Foundation.h>

/// 仅为让本 target 有一个可编译单元；不构成公开接口。
FOUNDATION_EXPORT NSString *AppTelepathResourcesMarker(void);
