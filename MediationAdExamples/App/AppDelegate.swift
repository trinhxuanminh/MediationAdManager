//
//  AppDelegate.swift
//  MediationAdExamples
//
//  Created by Trịnh Xuân Minh on 10/10/2022.
//

import UIKit
import AppLovinSDK
import FBAudienceNetwork
import MediationAdManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    FBAdSettings.setDataProcessingOptions([])
    FBAdSettings.setAdvertiserTrackingEnabled(false)
    
    ALSdk.shared()!.mediationProvider = "max"
    ALSdk.shared()!.userIdentifier = "USER_ID"
    ALSdk.shared()!.initializeSdk { (configuration: ALSdkConfiguration) in
      // Start loading ads
//      MediationAdManager.shared.setTimeBetween(5.0, ad: .interstitial)
//      if let startDate = "2022-10-20".convertToDate() {
//        MediationAdManager.shared.showFullFeature(from: startDate)
//      }
      MediationAdManager.shared.setID(interstitial: "27f04436f20723da",
                                      appOpen: "7d8cb2f86a0923e8",
                                      rewarded: "6c3e65a8837c9810",
                                      banner: "83ca8456967b9cea",
                                      smallNative: "7af0e68be0920910",
                                      mediumNative: "25550a8aec3a140b",
                                      manualNative: "23df2abcf799b105")
      ALSdk.shared()!.showMediationDebugger()
    }
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  
  @available(iOS 13.0, *)
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  @available(iOS 13.0, *)
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  
  
}

