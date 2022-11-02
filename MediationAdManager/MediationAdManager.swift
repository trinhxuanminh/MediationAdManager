//
//  MediationAdManager.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 10/10/2022.
//

import UIKit
import Foundation

public struct MediationAdManager {
  
  public static let bundle = Bundle.main
  public static var shared = MediationAdManager()
  
  public enum AdType: Int {
    case interstitial = 0
    case appOpen = 1
    case rewarded = 2
  }
  
  private var ads: [AdProtocol] = [InterstitialAd(), AppOpenAd(), RewardedAd()]
  private var smallNativeID: String?
  private var mediumNativeID: String?
  private var manualNativeID: String?
  private var bannerID: String?
  private var startDate: Date?
  
  public mutating func setID(interstitial: String? = nil,
                             appOpen: String? = nil,
                             rewarded: String? = nil,
                             banner: String? = nil,
                             smallNative: String? = nil,
                             mediumNative: String? = nil,
                             manualNative: String? = nil
  ) {
    if let banner = banner {
      self.bannerID = banner
    }
    if let smallNative = smallNative {
      self.smallNativeID = smallNative
    }
    if let mediumNative = mediumNative {
      self.mediumNativeID = mediumNative
    }
    if let manualNative = manualNative {
      self.manualNativeID = manualNative
    }
    guard allowShowFullFeature() else {
      print("Ads are not allowed to load!")
      return
    }
    if let interstitial = interstitial {
      ads[0].createAd(interstitial)
    }
    if let appOpen = appOpen {
      ads[1].createAd(appOpen)
    }
    if let rewarded = rewarded {
      ads[2].createAd(rewarded)
    }
  }
  
  public func isReady(ad type: AdType) -> Bool {
    return ads[type.rawValue].isReady()
  }
  
  public func show(ad type: AdType,
                   didDisplay: (() -> Void)? = nil,
                   didHide: (() -> Void)? = nil,
                   didClick: (() -> Void)? = nil,
                   didFail: (() -> Void)? = nil,
                   didStartRewardedVideo: (() -> Void)? = nil,
                   didCompleteRewardedVideo: (() -> Void)? = nil,
                   didRewardUser: (() -> Void)? = nil
  ) {
    if type == .appOpen {
      guard !ads[0].isDisplay() else {
        print("AppOpenAd: display failure - InterstitialAd is showing!")
        return
      }
      guard !ads[2].isDisplay() else {
        print("AppOpenAd: display failure - RewardedAd is showing!")
        return
      }
    }
    ads[type.rawValue].show(didDisplay: didDisplay,
                            didHide: didHide,
                            didClick: didClick,
                            didFail: didFail,
                            didStartRewardedVideo: didStartRewardedVideo,
                            didCompleteRewardedVideo: didCompleteRewardedVideo,
                            didRewardUser: didRewardUser)
  }
  
  public mutating func showFullFeature(from date: Date) {
    self.startDate = date
  }
  
  public func setTimeBetween(_ time: Double, ad type: AdType) {
    ads[type.rawValue].setTimeBetween(time)
  }
}

extension MediationAdManager {
  func getBannerID() -> String? {
    return bannerID
  }
  
  func getSmallNativeID() -> String? {
    return smallNativeID
  }
  
  func getMediumNativeID() -> String? {
    return mediumNativeID
  }
  
  func getManualNativeID() -> String? {
    return manualNativeID
  }
  
  private func allowShowFullFeature() -> Bool {
    guard let startDate = startDate, Date().timeIntervalSince(startDate) < 0 else {
      return true
    }
    return false
  }
}
