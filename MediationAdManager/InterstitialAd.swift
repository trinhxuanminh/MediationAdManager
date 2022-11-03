//
//  InterstitialAd.swift
//  
//
//  Created by Trịnh Xuân Minh on 17/10/2022.
//

import Foundation
import AppLovinSDK

final class InterstitialAd: NSObject, AdProtocol {
  private var interstitialAd: MAInterstitialAd!
  private var retryAttempt = 0.0
  private var timeBetween = 10.0
  private var presentState = false
  private var lastTimeDisplay = Date()
  private var didDisplay: (() -> Void)?
  private var didClick: (() -> Void)?
  private var didHide: (() -> Void)?
  private var didFail: (() -> Void)?
  
  func createAd(_ adUnitID: String) {
    guard interstitialAd == nil else {
      print("InterstitialAd: initialization failed - already exist!")
      return
    }
    self.interstitialAd = MAInterstitialAd(adUnitIdentifier: adUnitID)
    interstitialAd.delegate = self
    load()
  }
  
  func setTimeBetween(_ timeBetween: Double) {
    guard timeBetween > 0.0 else {
      print("InterstitialAd: set time between failed - invalid time!")
      return
    }
    self.timeBetween = timeBetween
  }
  
  func isDisplay() -> Bool {
    return presentState
  }
  
  func load() {
    guard interstitialAd != nil else {
      print("InterstitialAd: failed to load - not initialized yet!")
      return
    }
    guard !isReady() else {
      print("InterstitialAd: failed to load - ready to show!")
      return
    }
    print("InterstitialAd: start load!")
    interstitialAd.load()
  }
  
  func isReady() -> Bool {
    guard interstitialAd != nil else {
      print("InterstitialAd: not ready - not initialized yet!")
      return false
    }
    return interstitialAd.isReady && wasLoadTimeLessThanNHoursAgo()
  }
  
  func show(didDisplay: (() -> Void)?,
            didHide: (() -> Void)?,
            didClick: (() -> Void)?,
            didFail: (() -> Void)?,
            didStartRewardedVideo: (() -> Void)?,
            didCompleteRewardedVideo: (() -> Void)?,
            didRewardUser: (() -> Void)?
  ) {
    guard interstitialAd != nil else {
      print("InterstitialAd: display failure - not initialized yet!")
      return
    }
    guard isReady() else {
      print("InterstitialAd: display failure - not ready to show!")
      return
    }
    guard !presentState else {
      print("InterstitialAd: display failure - ads are being displayed!")
      return
    }
    print("InterstitialAd: requested to show!")
    self.didDisplay = didDisplay
    self.didHide = didHide
    self.didClick = didClick
    self.didFail = didFail
    interstitialAd.show()
  }
}

extension InterstitialAd: MAAdDelegate {
  func didLoad(_ ad: MAAd) {
    print("InterstitalAd: did load!")
    self.retryAttempt = 0
  }
  
  func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
    retryAttempt += 1
    let delaySec = pow(2.0, min(5.0, retryAttempt))
    
    print("InterstitalAd: did fail to load. Reload after \(delaySec)s! (\(error))")
    DispatchQueue.global().asyncAfter(deadline: .now() + delaySec, execute: load)
  }
  
  func didDisplay(_ ad: MAAd) {
    print("InterstitalAd: did display!")
    self.presentState = true
    didDisplay?()
  }
  
  func didHide(_ ad: MAAd) {
    print("InterstitalAd: did hide!")
    self.presentState = false
    self.lastTimeDisplay = Date()
    didHide?()
    load()
  }
  
  func didClick(_ ad: MAAd) {
    print("InterstitalAd: did click!")
    didClick?()
  }
  
  func didFail(toDisplay ad: MAAd, withError error: MAError) {
    print("InterstitalAd: did fail to show content!")
    didFail?()
    load()
  }
}

extension InterstitialAd {
  private func wasLoadTimeLessThanNHoursAgo() -> Bool {
    let now = Date()
    let timeIntervalBetweenNowAndLoadTime = now.timeIntervalSince(lastTimeDisplay)
    return timeIntervalBetweenNowAndLoadTime > timeBetween
  }
}
