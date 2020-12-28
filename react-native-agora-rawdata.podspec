require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-agora-rawdata"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/LichKing-2234/react-native-agora-rawdata.git", :tag => "#{s.version}" }


  s.source_files = "ios/**/*.{h,m,mm,swift}", "cpp/apple/**/*.{h,cpp}"

  s.static_framework = true
  s.swift_version = "4.0"

  s.dependency "React"
  s.dependency "AgoraRtcEngine_iOS"
end
