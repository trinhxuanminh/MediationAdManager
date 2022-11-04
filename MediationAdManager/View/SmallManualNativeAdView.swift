//
//  SmallManualNativeAdView.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 31/10/2022.
//

import UIKit
import AppLovinSDK
import NVActivityIndicatorView

@IBDesignable public class SmallManualNativeAdView: BaseView {
  
  private lazy var loadingView: NVActivityIndicatorView = {
    let loadingView = NVActivityIndicatorView(frame: .zero)
    loadingView.type = .ballPulse
    loadingView.padding = 30.0
    return loadingView
  }()
  private lazy var nativeAdView: SmallNativeAdViewBinder = {
    let nativeAdView = SmallNativeAdViewBinder()
    let adViewBinder = MANativeAdViewBinder.init(builderBlock: { (builder) in
      builder.iconImageViewTag = 101
      builder.titleLabelTag = 102
      builder.advertiserLabelTag = 103
      builder.callToActionButtonTag = 104
    })
    nativeAdView.bindViews(with: adViewBinder)
    return nativeAdView
  }()
  
  private var nativeAd: NativeAd?
  
  public override func removeFromSuperview() {
    nativeAd = nil
    super.removeFromSuperview()
  }
  
  override func addComponents() {
    addSubview(loadingView)
  }
  
  override func setConstraints() {
    loadingView.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.width.height.equalTo(20.0)
    }
  }
  
  override func setProperties() {
    loadingView.startAnimating()
    self.nativeAd = NativeAd(adUnitID: MediationAdManager.shared.getManualNativeID(),
                             binding: { [weak self] nativeAdView in
      guard let self = self, let nativeAdView = nativeAdView else {
        return
      }
      DispatchQueue.main.async {
        self.addSubview(nativeAdView)
        nativeAdView.snp.makeConstraints { make in
          make.edges.equalToSuperview()
        }
        self.loadingView.stopAnimating()
      }
    }, into: nativeAdView)
  }
  
  override func setColor() {
    loadingView.color = UIColor(rgb: 0x000000)
  }
  
  public class func adHeightMinimum() -> CGFloat {
    return 120.0
  }
  
  public func setColor(titleText: UIColor? = nil,
                       adText: UIColor? = nil,
                       advertiserText: UIColor? = nil,
                       callToActionText: UIColor? = nil,
                       callToActionBackground: UIColor? = nil
  ) {
    nativeAdView.setColor(titleText: titleText,
                          adText: adText,
                          advertiserText: advertiserText,
                          callToActionText: callToActionText,
                          callToActionBackground: callToActionBackground)
  }
  
  public func setFont(title: UIFont? = nil,
                      ad: UIFont? = nil,
                      advertiser: UIFont? = nil,
                      callToAction: UIFont? = nil)
  {
    nativeAdView.setFont(title: title,
                         ad: ad,
                         advertiser: advertiser,
                         callToAction: callToAction)
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
