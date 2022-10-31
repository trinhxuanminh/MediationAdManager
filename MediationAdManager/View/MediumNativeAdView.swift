//
//  MediumNativeAdView.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 25/10/2022.
//

import Foundation
import SnapKit

@IBDesignable public class MediumNativeAdView: BaseView {
  private var nativeAd: NativeAd?
  
  override func setProperties() {
    self.nativeAd = NativeAd(adUnitID: MediationAdManager.shared.getMediumNativeID(),
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
  
  public class func adHeightMinimum(width: CGFloat) -> CGFloat {
    return width / 16 * 9 + 120.0
  }
}
