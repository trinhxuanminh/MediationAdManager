//
//  NativeAd.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 24/10/2022.
//

import Foundation
import AppLovinSDK

class NativeAd: NSObject {
  private var adUnitID: String?
  private var adView: MANativeAdView?
  private var adLoader: MANativeAdLoader?
  private var loadedAd: MAAd?
  private var retryAttempt = 0.0
  private var binding: ((MANativeAdView?) -> Void)?
  
  init(adUnitID: String?,
       binding: ((MANativeAdView?) -> Void)?,
       into typeAdView: MANativeAdView? = nil
  ) {
    super.init()
    self.adUnitID = adUnitID
    self.binding = binding
    self.adView = typeAdView
    createAdLoader()
  }
  
  func createAdLoader() {
    guard let adUnitID = adUnitID else {
      print("NativeAd: failed to load - not initialized yet!")
      return
    }
    self.adLoader = MANativeAdLoader(adUnitIdentifier: adUnitID)
    adLoader?.nativeAdDelegate = self
    adLoader?.revenueDelegate = self
    load()
  }
  
  func load() {
    guard adLoader != nil else {
      print("NativeAd: failed to load - not initialized yet!")
      return
    }
    print("NativeAd: start load!")
    guard adView != nil else {
      adLoader?.loadAd()
      return
    }
    adLoader?.loadAd(into: adView)
  }
}

extension NativeAd: MANativeAdDelegate {
  func didLoadNativeAd(_ nativeAdView: MANativeAdView?, for ad: MAAd) {
    print("NativeAd: did load!")
    self.retryAttempt = 0
    if let currentNativeAd = loadedAd {
      adLoader?.destroy(currentNativeAd)
    }
    
    self.loadedAd = ad
    
    if let currentNativeAdView = adView {
      currentNativeAdView.removeFromSuperview()
    }
    
    self.adView = nativeAdView
    
    binding?(adView)
  }
  
  func didFailToLoadNativeAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
    retryAttempt += 1
    let delaySec = pow(2.0, min(5.0, retryAttempt))
    
    print("NativeAd: did fail to load. Reload after \(delaySec)s!")
    DispatchQueue.global().asyncAfter(deadline: .now() + delaySec, execute: load)
  }
  
  func didClickNativeAd(_ ad: MAAd) {
    print("NativeAd: did click!")
  }
}

extension NativeAd: MAAdRevenueDelegate {
  func didPayRevenue(for ad: MAAd) {
    print("NativeAd: did pay revenue!")
  }
}
