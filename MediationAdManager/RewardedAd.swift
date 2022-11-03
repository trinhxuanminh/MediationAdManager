//
//  RewardedAd.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 18/10/2022.
//

import Foundation
import AppLovinSDK

final class RewardedAd: NSObject, AdProtocol {
  private var rewardedAd: MARewardedAd!
  private var retryAttempt = 0.0
  private var timeBetween = 10.0
  private var presentState = false
  private var lastTimeDisplay = Date()
  private var didDisplay: (() -> Void)?
  private var didClick: (() -> Void)?
  private var didHide: (() -> Void)?
  private var didFail: (() -> Void)?
  private var didStartRewardedVideo: (() -> Void)?
  private var didCompleteRewardedVideo: (() -> Void)?
  private var didRewardUser: (() -> Void)?
  
  func createAd(_ adUnitID: String) {
    guard rewardedAd == nil else {
      print("RewardedAd: initialization failed - already exist!")
      return
    }
    self.rewardedAd = MARewardedAd.shared(withAdUnitIdentifier: adUnitID)
    rewardedAd.delegate = self
    load()
  }
  
  func setTimeBetween(_ timeBetween: Double) {
    guard timeBetween > 0.0 else {
      print("RewardedAd: set time between failed - invalid time!")
      return
    }
    self.timeBetween = timeBetween
  }
  
  func isDisplay() -> Bool {
    return presentState
  }
  
  func load() {
    guard rewardedAd != nil else {
      print("RewardedAd: failed to load - not initialized yet!")
      return
    }
    guard !isReady() else {
      print("RewardedAd: failed to load - ready to show!")
      return
    }
    print("RewardedAd: start load!")
    rewardedAd.load()
  }
  
  func isReady() -> Bool {
    guard rewardedAd != nil else {
      print("RewardedAd: not ready - not initialized yet!")
      return false
    }
    return rewardedAd.isReady && wasLoadTimeLessThanNHoursAgo()
  }
  
  func show(didDisplay: (() -> Void)?,
            didHide: (() -> Void)?,
            didClick: (() -> Void)?,
            didFail: (() -> Void)?,
            didStartRewardedVideo: (() -> Void)?,
            didCompleteRewardedVideo: (() -> Void)?,
            didRewardUser: (() -> Void)?
  ) {
    guard rewardedAd != nil else {
      print("RewardedAd: display failure - not initialized yet!")
      return
    }
    guard isReady() else {
      print("RewardedAd: display failure - not ready to show!")
      return
    }
    guard !presentState else {
      print("RewardedAd: display failure - ads are being displayed!")
      return
    }
    print("RewardedAd: requested to show!")
    self.didDisplay = didDisplay
    self.didHide = didHide
    self.didClick = didClick
    self.didFail = didFail
    self.didStartRewardedVideo = didStartRewardedVideo
    self.didCompleteRewardedVideo = didCompleteRewardedVideo
    self.didRewardUser = didRewardUser
    rewardedAd.show()
  }
}

extension RewardedAd: MARewardedAdDelegate {
  func didLoad(_ ad: MAAd) {
    print("RewardedAd: did load!")
    self.retryAttempt = 0
  }
  
  func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
    retryAttempt += 1
    let delaySec = pow(2.0, min(5.0, retryAttempt))
    
    print("RewardedAd: did fail to load. Reload after \(delaySec)s! (\(error))")
    DispatchQueue.global().asyncAfter(deadline: .now() + delaySec, execute: load)
  }
  
  func didDisplay(_ ad: MAAd) {
    print("RewardedAd: did display!")
    self.presentState = true
    didDisplay?()
  }
  
  func didHide(_ ad: MAAd) {
    print("RewardedAd: did hide!")
    self.presentState = false
    self.lastTimeDisplay = Date()
    didHide?()
    load()
  }
  
  func didClick(_ ad: MAAd) {
    print("RewardedAd: did click!")
    didClick?()
  }
  
  func didFail(toDisplay ad: MAAd, withError error: MAError) {
    print("RewardedAd: did fail to show content!")
    didFail?()
    load()
  }
  
  func didStartRewardedVideo(for ad: MAAd) {
    print("RewardedAd: did start video!")
    didStartRewardedVideo?()
  }
  
  func didCompleteRewardedVideo(for ad: MAAd) {
    print("RewardedAd: did complete video!")
    didCompleteRewardedVideo?()
  }
  
  func didRewardUser(for ad: MAAd, with reward: MAReward) {
    print("RewardedAd: did reward user!")
    didRewardUser?()
  }
}

extension RewardedAd {
  private func wasLoadTimeLessThanNHoursAgo() -> Bool {
    let now = Date()
    let timeIntervalBetweenNowAndLoadTime = now.timeIntervalSince(lastTimeDisplay)
    return timeIntervalBetweenNowAndLoadTime > timeBetween
  }
}
