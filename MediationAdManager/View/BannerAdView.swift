//
//  BannerAdView.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 21/10/2022.
//

import UIKit
import AppLovinSDK
import SnapKit

@IBDesignable public class BannerAdView: BaseView {
  private var bannerAdView: MAAdView?
  private var didFirstLoadAd = false
  private var retryAttempt = 0.0
  
  override func addComponents() {
    guard let bannerID = MediationAdManager.shared.getBannerID() else {
      print("BannerAd: failed to load - not initialized yet!")
      return
    }
    self.bannerAdView = MAAdView(adUnitIdentifier: bannerID)
    self.addSubview(bannerAdView!)
  }
  
  override func setConstraints() {
    bannerAdView?.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  override func setProperties() {
    bannerAdView?.delegate = self
  }
  
  public override func draw(_ rect: CGRect) {
    super.draw(rect)
    guard !didFirstLoadAd else {
      return
    }
    self.didFirstLoadAd = true
    load()
  }
  
  public class func adHeightMinimum() -> CGFloat {
    return UIDevice.current.userInterfaceIdiom == .phone ? 50.0 : 90.0
  }
}

extension BannerAdView: MAAdViewAdDelegate {
  public func didExpand(_ ad: MAAd) {
    print("BannerAd: did expand!")
  }
  
  public func didCollapse(_ ad: MAAd) {
    print("BannerAd: did collapse!")
  }
  
  public func didLoad(_ ad: MAAd) {
    print("BannerAd: did load!")
    self.retryAttempt = 0
  }
  
  public func didFailToLoadAd(forAdUnitIdentifier adUnitIdentifier: String, withError error: MAError) {
    retryAttempt += 1
    let delaySec = pow(2.0, min(5.0, retryAttempt))
    
    print("BannerAd: did fail to load. Reload after \(delaySec)s!")
    DispatchQueue.global().asyncAfter(deadline: .now() + delaySec, execute: load)
  }
  
  public func didDisplay(_ ad: MAAd) {
    print("BannerAd: did display!")
  }
  
  public func didHide(_ ad: MAAd) {
    print("BannerAd: did hide!")
  }
  
  public func didClick(_ ad: MAAd) {
    print("BannerAd: did click!")
  }
  
  public func didFail(toDisplay ad: MAAd, withError error: MAError) {
    print("BannerAd: did fail to show content!")
  }
}

extension BannerAdView {
  private func load() {
    print("BannerAd: start load!")
    bannerAdView?.loadAd()
  }
}
