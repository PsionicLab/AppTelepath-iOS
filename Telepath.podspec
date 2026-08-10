Pod::Spec.new do |spec|
  spec.name         = "Telepath"
  spec.version      = "2.1.0"
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
    :sha256 => "78bae34308becaec980c440d97d9f0f2e4705c4c6b91730f9e16ee03286a6b7e"
  }

  spec.vendored_frameworks = "Telepath.xcframework"
  spec.resources = "TelepathResources.bundle"
  spec.frameworks = "Network", "CoreTelephony"
  spec.libraries = "c++", "sqlite3", "z"
end
