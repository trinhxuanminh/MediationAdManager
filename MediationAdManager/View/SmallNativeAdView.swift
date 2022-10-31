//
//  NativeAdView.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 24/10/2022.
//

import Foundation
import SnapKit

@IBDesignable public class SmallNativeAdView: BaseView {
  private var nativeAd: NativeAd?
  
  override func setProperties() {
    self.nativeAd = NativeAd(adUnitID: MediationAdManager.shared.getSmallNativeID(),
                             binding: { [weak self] nativeAdView in
      guard let self = self, let nativeAdView = nativeAdView else {
        return
      }
      self.addSubview(nativeAdView)
      nativeAdView.snp.makeConstraints { make in
        make.edges.equalToSuperview()
      }
    })
  }
  
  public class func adHeightMinimum() -> CGFloat {
    return 120.0
  }
}
