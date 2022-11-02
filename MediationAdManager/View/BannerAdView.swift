//
//  BannerAdView.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 21/10/2022.
//

import UIKit
import AppLovinSDK
import SnapKit
import NVActivityIndicatorView

@IBDesignable public class BannerAdView: BaseView {
  
  private lazy var loadingView: NVActivityIndicatorView = {
    let loadingView = NVActivityIndicatorView(frame: .zero)
    loadingView.type = .ballPulse
    loadingView.padding = 30.0
    return loadingView
  }()
  
  private var bannerAdView: MAAdView?
  private var retryAttempt = 0.0
  private var didLoadAd = false
  
  public override func removeFromSuperview() {
    bannerAdView = nil
    super.removeFromSuperview()
  }
  
  override func addComponents() {
    addSubview(loadingView)
    guard let bannerID = MediationAdManager.shared.getBannerID() else {
      print("BannerAd: failed to load - not initialized yet!")
      return
    }
    self.bannerAdView = MAAdView(adUnitIdentifier: bannerID)
    addSubview(bannerAdView!)
  }
  
  override func setConstraints() {
    loadingView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.width.height.equalTo(20.0)
    }
    bannerAdView?.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  override func setProperties() {
    bannerAdView?.delegate = self
  }
  
  override func setColor() {
    loadingView.color = UIColor(rgb: 0x000000)
  }
  
  public override func draw(_ rect: CGRect) {
    super.draw(rect)
    guard !didLoadAd else {
      return
    }
    self.didLoadAd = true
    load()
    loadingView.startAnimating()
  }
  
  public class func adHeightMinimum() -> CGFloat {
    return UIDevice.current.userInterfaceIdiom == .phone ? 50.0 : 90.0
  }
  
  public func setLoading(type: NVActivityIndicatorType? = nil,
                         color: UIColor? = nil,
                         padding: CGFloat? = nil
  ) {
    let isAnimating = loadingView.isAnimating
    if isAnimating {
      loadingView.stopAnimating()
    }
    if let type = type {
      loadingView.type = type
    }
    if let color = color {
      loadingView.color = color
    }
    if let padding = padding {
      loadingView.padding = padding
    }
    if isAnimating {
      loadingView.startAnimating()
    }
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
    loadingView.stopAnimating()
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
