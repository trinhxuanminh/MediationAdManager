//
//  SmallManualNativeAdCollectionViewCell.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 01/11/2022.
//

import UIKit
import SnapKit

public class SmallManualNativeAdCollectionViewCell: BaseCollectionViewCell {
  
  private lazy var nativeAdView: SmallManualNativeAdView = {
    let nativeAdView = SmallManualNativeAdView()
    return nativeAdView
  }()
  
  override func addComponents() {
    addSubview(nativeAdView)
  }
  
  override func setConstraints() {
    nativeAdView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  public class func adHeightMinimum() -> CGFloat {
    return 120.0
  }
  
  public func setColor(titleText: UIColor? = nil,
                       advertiserText: UIColor? = nil,
                       callToActionText: UIColor? = nil,
                       callToActionBackground: UIColor? = nil
  ) {
    nativeAdView.setColor(titleText: titleText,
                          advertiserText: advertiserText,
                          callToActionText: callToActionText,
                          callToActionBackground: callToActionBackground)
  }
}
