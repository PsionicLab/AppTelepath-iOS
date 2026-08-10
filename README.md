# AppTelepath iOS SDK

This repository distributes official binary releases of the AppTelepath iOS SDK. The SDK source code is not published here.

AppTelepath lets AI coding agents inspect and debug an iOS app through the hosted AppTelepath service and remote MCP endpoint.

## Install

Install the public Beta from CocoaPods Trunk:

```ruby
pod 'Telepath', '~> 2.1', :configurations => ['Debug']
```

Then start the SDK with the workspace token shown in the AppTelepath console:

```swift
import Telepath

Telepath.start(token: "YOUR_WORKSPACE_TOKEN")
```

Use the SDK only in authorized development and testing builds. It must be excluded from App Store production submissions. TestFlight builds require the explicit distribution opt-in documented with the SDK.

## Releases

Each GitHub Release contains the versioned XCFramework archive and its checksum. Release archives include the required third-party notices and license texts.

## Support and security

Use [GitHub Issues](https://github.com/PsionicLab/AppTelepath-iOS/issues) for SDK integration problems. Never include workspace tokens, private screenshots, captured traffic, or other customer data in a public issue.

For product access and the hosted service, visit [apptelepath.com](https://apptelepath.com/).

## License

AppTelepath is proprietary software distributed by Yibi AI LLC. See [LICENSE](LICENSE). Third-party components remain governed by their accompanying licenses and notices.
