Pod::Spec.new do |spec|
  spec.name         = "Telepath"
  spec.version      = "2.1.3"
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
    :sha256 => "9a14a949c7785415b9049ffff6a72459cbc97c4c754910e4559871ed552a6233"
  }

  spec.default_subspec = "Base"

  spec.subspec "Base" do |sp|
    sp.vendored_frameworks = "Telepath.xcframework"
    sp.resources = "TelepathResources.bundle"
    sp.frameworks = "Network", "CoreTelephony"
    sp.libraries = "c++", "sqlite3", "z"
  end

  # Fabric 适配器已编入基础二进制；该别名只表达宿主类型，不新增 RN Pod 依赖。
  spec.subspec "ReactNative" do |sp|
    sp.dependency "Telepath/Base"
  end
end
