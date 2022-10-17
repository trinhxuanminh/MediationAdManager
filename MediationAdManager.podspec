Pod::Spec.new do |spec|

  spec.name         = "MediationAdManager"
  spec.version      = "0.0.4"
  spec.summary      = "A CocoaPods library written in Swift"

  spec.description  = <<-DESC
This CocoaPods library helps you perform calculation.
                   DESC

  spec.homepage     = "https://github.com/trinhxuanminh"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author       = { "trinhxuanminh" => "trinhxuanminh2000@gmail.com" }

  spec.ios.deployment_target = "11.0"
  spec.swift_version = "5.0"

  spec.source        = { :git => "https://github.com/trinhxuanminh/MediationAdManager.git", :branch => "master", :tag => "#{spec.version}" }
  spec.source_files  = "MediationAdManager/**/*.{h,m,swift}"
  
  spec.static_framework = true
  
  spec.dependency 'AppLovinSDK', '11.5.1'
  spec.dependency 'AppLovinMediationAdColonyAdapter', '4.9.0.0.2'
  spec.dependency 'AppLovinMediationGoogleAdapter', '9.11.0.2'
  spec.dependency 'AppLovinMediationFacebookAdapter', '6.11.2.1'
  spec.dependency 'AppLovinMediationUnityAdsAdapter', '4.4.0.0'
  spec.dependency 'AppLovinMediationVungleAdapter', '6.12.0.3'
  # spec.dependency 'AppLovinMediationIronSourceAdapter', '7.2.5.0.0'

end
