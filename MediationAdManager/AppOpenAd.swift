//
//  AppOpenAd.swift
//  
//
//  Created by Trịnh Xuân Minh on 18/10/2022.
//

import Foundation
import AppLovinSDK

final class AppOpenAd: NSObject, AdProtocol {
  private var appOpenAd: MAAppOpenAd!
  private var retryAttempt = 0.0
  private var timeBetween = 10.0
  private var presentState = false
  private var lastTimeDisplay = Date()
  private var didDisplay: (() -> Void)?
  private var didClick: (() -> Void)?
  private var didHide: (() -> Void)?
  private var didFail: (() -> Void)?
  
  func createAd(_ adUnitID: String) {
    guard appOpenAd == nil else {
      print("AppOpenAd: initialization failed - already exist!")
      return
    }
    self.appOpenAd = MAAppOpenAd(adUnitIdentifier: adUnitID)
    appOpenAd.delegate = self
    load()
  }
  
  func setTimeBetween(_ timeBetween: Double) {
    guard timeBetween > 0.0 else {
      print("AppOpenAd: set time between failed - invalid time!")
      return
    }
    self.timeBetween = timeBetween
  }
  
  func isDisplay() -> Bool {
    return presentState
  }
  
  func load() {
    guard appOpenAd != nil else {
      print("AppOpenAd: failed to load - not initialized yet!")
      return
    }
    guard !isReady() else {
      print("AppOpenAd: failed to load - ready to show!")
      return
    }
    print("AppOpenAd: start load!")
    appOpenAd.load()
  }
  
  func isReady() -> Bool {
    guard appOpenAd != nil else {
      print("AppOpenAd: not ready - not initialized yet!")
      return false
    }
    return appOpenAd.isReady && wasLoadTimeLessThanNHoursAgo()
  }
  
  func show(didDisplay: (() -> Void)?,
            didHide: (() -> Void)?,
            didClick: (() -> Void)?,
            didFail: (() -> Void)?,
            didStartRewardedVideo: (() -> Void)?,
            didCompleteRewardedVideo: (() -> Void)?,
            didRewardUser: (() -> Void)?
  ) {
    guard appOpenAd != nil else {
      print("AppOpenAd: display failure - not initialized yet!")
      return
    }
    guard isReady() else {
      print("AppOpenAd: display failure - not ready to show!")
      return
    }
    guard !presentState else {
      print("AppOpenAd: display failure - ads are being displayed!")
      return
    }
    print("AppOpenAd: requested to show!")
    self.didDisplay = didDisplay
    self.didHide = didHide
    self.didClick = didClick
    self.didFail = didFail
    appOpenAd.show()
  }
}

extension AppOpenAd: MAAdDelegate {
  func didLoad(_ ad: MAAd) {
    print("AppOpenAd: did load!")
    self.retryAttempt = 0
  }
  
  func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
    retryAttempt += 1
    let delaySec = pow(2.0, min(5.0, retryAttempt))
    
    print("AppOpenAd: did fail to load. Reload after \(delaySec)s!")
    DispatchQueue.global().asyncAfter(deadline: .now() + delaySec, execute: load)
  }
  
  func didDisplay(_ ad: MAAd) {
    print("AppOpenAd: did display!")
    self.presentState = true
    didDisplay?()
  }
  
  func didHide(_ ad: MAAd) {
    print("AppOpenAd: did hide!")
    self.presentState = false
    self.lastTimeDisplay = Date()
    didHide?()
    load()
  }
  
  func didClick(_ ad: MAAd) {
    print("AppOpenAd: did click!")
    didClick?()
  }
  
  func didFail(toDisplay ad: MAAd, withError error: MAError) {
    print("AppOpenAd: did fail to show content!")
    didFail?()
    load()
  }
}

extension AppOpenAd {
  private func wasLoadTimeLessThanNHoursAgo() -> Bool {
    let now = Date()
    let timeIntervalBetweenNowAndLoadTime = now.timeIntervalSince(lastTimeDisplay)
    return timeIntervalBetweenNowAndLoadTime > timeBetween
  }
}
