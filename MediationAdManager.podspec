Pod::Spec.new do |spec|

  spec.name         = "MediationAdManager"
  spec.version      = "1.0.2"
  spec.summary      = "A CocoaPods library written in Swift"

  spec.description  = <<-DESC
This CocoaPods library helps you perform calculation.
                   DESC

  spec.homepage     = "https://github.com/trinhxuanminh"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author       = { "trinhxuanminh" => "trinhxuanminh2000@gmail.com" }

  spec.ios.deployment_target = "11.0"
  spec.swift_version = "5.0"

  spec.source        = { :git => "https://github.com/trinhxuanminh/MediationAdManager.git", :branch => "main", :tag => "#{spec.version}" }
  spec.source_files  = "MediationAdManager/**/*.{h,m,swift}"
  
  spec.static_framework = true
  
  spec.dependency 'SnapKit', '5.6.0'
  spec.dependency 'NVActivityIndicatorView', '5.1.1'
  spec.dependency 'AppLovinSDK', '11.9.0'
  spec.dependency 'AppLovinMediationGoogleAdapter', '10.3.0.2'
  spec.dependency 'AppLovinMediationUnityAdsAdapter', '4.6.1.0'
  spec.dependency 'AppLovinMediationVungleAdapter', '6.12.3.0'

end
