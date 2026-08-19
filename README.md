# AppTelepath iOS SDK

**Remote debugging for iOS apps, built for AI coding agents.**

[![CocoaPods](https://img.shields.io/cocoapods/v/AppTelepath.svg?label=pod&color=0a84ff)](https://cocoapods.org/pods/AppTelepath)
[![Platform](https://img.shields.io/cocoapods/p/AppTelepath.svg?color=555)](https://cocoapods.org/pods/AppTelepath)
[![iOS 13+](https://img.shields.io/badge/iOS-13%2B-555)](https://apptelepath.com/)
[![License](https://img.shields.io/badge/license-Commercial-555)](LICENSE)

Official binary releases of the AppTelepath iOS SDK. The source code is not published here.

Add the SDK to a debug build, and an AI coding agent can inspect the running app remotely: logs, network traffic, view hierarchy, screenshots, database and sandbox, crash and performance reports, plus weak-network, GPS and push simulation. Agents connect through the hosted [AppTelepath](https://apptelepath.com/) service and its remote MCP endpoint; the same device can be driven from the web console.

## Install

```ruby
pod 'AppTelepath', '~> 3.0', :configurations => ['Debug']
```

The pod is also published under its original name, `Telepath`. Both names install the same binary — pick one, do not add both. Either way the import is unchanged:

```swift
#if TELEPATH_ENABLED
import Telepath
Telepath.start()
#endif
```

Documentation, workspace setup and the MCP endpoint: **[apptelepath.com](https://apptelepath.com/)**

## Use

For trusted, authorized development and testing builds only. Do not place a workspace credential in an App Store configuration or commit one to source control.

## Releases

Each [release](https://github.com/PsionicLab/AppTelepath-iOS/releases) contains the XCFramework archive with third-party notices and license texts. The published podspec pins the archive checksum.

## Support

[Open an issue](https://github.com/PsionicLab/AppTelepath-iOS/issues) for integration problems — never include workspace tokens, captured traffic, screenshots or other private data. Security reports: see [SECURITY.md](SECURITY.md).

## License

Proprietary software distributed by Yibi AI LLC. See [LICENSE](LICENSE). Third-party components remain governed by their accompanying licenses and notices.
