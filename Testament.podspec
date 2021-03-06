Pod::Spec.new do |s|
  s.name = "Testament"
  s.version = "2.0.1"
  s.summary = "Correct Unit Testing for basic Swift constructions."

  s.homepage = "https://github.com/Karetski/Testament.git"
  s.license = { 
    :type => "Apache 2.0",
    :file => "LICENSE.md" 
  }

  s.author = "Aliaksei Karetski"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.tvos.deployment_target = '9.0'

  s.source_files = "Sources/**/*.{swift,h,m}"
  s.source = { 
    :git => "https://github.com/Karetski/Testament.git", 
    :tag => "#{s.version}" 
  }

  s.framework = "XCTest"
  s.requires_arc = true
  s.user_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PLATFORM_DIR)/Developer/Library/Frameworks' }
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
  
  s.swift_version = '5.0'
  s.cocoapods_version = '>= 1.4.0'
end
