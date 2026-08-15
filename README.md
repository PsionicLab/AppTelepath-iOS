# AppTelepath iOS SDK

This repository distributes official binary releases of the AppTelepath iOS SDK. The SDK source code is not published here.

AppTelepath lets AI coding agents inspect and debug an iOS app through the hosted AppTelepath service and remote MCP endpoint.

## Install

Install the public Beta from CocoaPods Trunk:

```ruby
pod 'Telepath', '~> 2.1', :configurations => ['Debug']

# React Native Fabric apps can use the optional tap adapter:
# pod 'Telepath/ReactNative', '~> 2.1', :configurations => ['Debug']
```

Ask an AppTelepath-authorized coding agent to configure the device credential in
a gitignored local xcconfig or an existing secret store. Keep only build-setting
placeholders in `Info.plist`, then start the SDK with one line:

```swift
#if TELEPATH_ENABLED
import Telepath
Telepath.start()
#endif
```

The full SDK shows a floating local debug entry automatically and reports the
remote connection state. Write commands are enabled by default in trusted test
builds; use `TLPAgentConfig.allowWrite = false` when a read-only session is
required.

Use the SDK only in trusted, authorized development and testing builds. Never
commit a workspace credential or place it in an App Store configuration. If one
Release configuration is shared with App Store archives, create a separate
Internal or Staging configuration. TestFlight builds require explicit owner
approval and the documented distribution opt-in because embedded test
credentials can be extracted.

## Releases

Each GitHub Release contains the versioned XCFramework archive and its checksum. Release archives include the required third-party notices and license texts.

## Support and security

Use [GitHub Issues](https://github.com/PsionicLab/AppTelepath-iOS/issues) for SDK integration problems. Never include workspace tokens, private screenshots, captured traffic, or other customer data in a public issue.

For product access and the hosted service, visit [apptelepath.com](https://apptelepath.com/).

## License

AppTelepath is proprietary software distributed by Yibi AI LLC. See [LICENSE](LICENSE). Third-party components remain governed by their accompanying licenses and notices.
