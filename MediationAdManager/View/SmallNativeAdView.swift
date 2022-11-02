//
//  NativeAdView.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 24/10/2022.
//

import Foundation
import SnapKit
import NVActivityIndicatorView

@IBDesignable public class SmallNativeAdView: BaseView {
  private lazy var loadingView: NVActivityIndicatorView = {
    let loadingView = NVActivityIndicatorView(frame: .zero)
    loadingView.type = .ballPulse
    loadingView.padding = 30.0
    return loadingView
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
    self.nativeAd = NativeAd(adUnitID: MediationAdManager.shared.getSmallNativeID(),
                             binding: { [weak self] nativeAdView in
      guard let self = self, let nativeAdView = nativeAdView else {
        return
      }
      self.addSubview(nativeAdView)
      nativeAdView.snp.makeConstraints { make in
        make.edges.equalToSuperview()
      }
      self.loadingView.stopAnimating()
    })
  }
  
  override func setColor() {
    loadingView.color = UIColor(rgb: 0x000000)
  }
  
  public class func adHeightMinimum() -> CGFloat {
    return 120.0
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
