//
//  MediationAdManager.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 10/10/2022.
//

import Foundation

public struct MediationAdManager {
  
  public static let shared = MediationAdManager()
  
  public enum AdType {
    case splash
    case interstitial
    case appOpen
    case rewarded
  }

  public enum ReuseAdType {
    case interstitial
    case appOpen
    case rewarded
  }

  public enum OnceAdType {
    case splash
  }
  
  private var interstitialAd: ReuseAdProtocol = InterstitialAd()
  private var startDate: Date?
  
  public func setID(
    interstitial: String? = nil
  ) {
    if let interstitial = interstitial, allowShowFullFeature() {
      interstitialAd.createAd(interstitial)
    }
  }
  
  public func isReady(ad type: AdType) -> Bool {
    switch type {
    case .interstitial:
      return interstitialAd.isReady()
    default:
      return false
    }
  }
  
  public func show(ad type: AdType,
                   didDisplay: (() -> Void)? = nil,
                   didHide: (() -> Void)? = nil,
                   didClick: (() -> Void)? = nil,
                   didFail: (() -> Void)? = nil
  ) {
    switch type {
    case .interstitial:
      interstitialAd.show(didDisplay: didDisplay,
                          didHide: didHide,
                          didClick: didClick,
                          didFail: didFail)
    default:
      return
    }
  }
  
  public mutating func showFullFeature(from date: Date) {
    self.startDate = date
  }
  
  public func setTimeBetween(_ time: Double, ad type: ReuseAdType) {
    switch type {
    case .interstitial:
      interstitialAd.setTimeBetween(time)
    default:
      return
    }
  }
}

extension MediationAdManager {
  private func allowShowFullFeature() -> Bool {
    guard let startDate = startDate, Date().timeIntervalSince(startDate) < 0 else {
      return true
    }
    return false
  }
}
