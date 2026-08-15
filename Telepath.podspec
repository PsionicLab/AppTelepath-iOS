Pod::Spec.new do |spec|
  spec.name         = "Telepath"
  spec.version      = "2.1.2"
  spec.summary      = "Telepath 的 iOS 二进制 SDK。"
  spec.description  = <<-DESC
                      面向 AI agent 的 iOS 远程调试 SDK 二进制发行包。
                      包含真机与模拟器静态库，以及端内面板所需资源。
                      DESC
  spec.homepage     = "https://apptelepath.com/"
  spec.license      = { :type => "Commercial", :file => "LICENSE" }
  spec.author       = "Yibi AI LLC"
  spec.platform     = :ios, "13.0"
  spec.source       = {
    :http => "https://github.com/PsionicLab/AppTelepath-iOS/releases/download/#{spec.version}/Telepath-#{spec.version}.zip",
    :sha256 => "3ca9c9f728f4722e7a8adfb2bc93738f24fc31fecd4a0221c674c9e5ae6f8669"
  }

  spec.default_subspec = "Base"

  spec.subspec "Base" do |sp|
    sp.vendored_frameworks = "Telepath.xcframework"
    sp.resources = "TelepathResources.bundle"
    sp.frameworks = "Network", "CoreTelephony"
    sp.libraries = "c++", "sqlite3", "z"
  end

  # Fabric Pressable 的动作留在 React Native 事件系统里；可选适配器把 ui.tap
  # 转成宿主 click 事件。普通 UIKit App 继续安装 Base，不引入 RN 依赖。
  spec.subspec "ReactNative" do |sp|
    sp.dependency "Telepath/Base"
    sp.source_files = "Adapters/ReactNative/**/*.{h,m,mm}"
  end
end
