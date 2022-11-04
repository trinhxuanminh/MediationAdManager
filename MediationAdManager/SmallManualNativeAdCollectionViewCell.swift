//
//  SmallManualNativeAdCollectionViewCell.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 01/11/2022.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

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
  
  public func setFont(title: UIFont? = nil,
                      ad: UIFont? = nil,
                      advertiser: UIFont? = nil,
                      callToAction: UIFont? = nil
  ) {
    nativeAdView.setFont(title: title,
                         ad: ad,
                         advertiser: advertiser,
                         callToAction: callToAction)
  }
  
  public func setLoading(type: NVActivityIndicatorType? = nil,
                         color: UIColor? = nil,
                         padding: CGFloat? = nil
  ) {
    nativeAdView.setLoading(type: type,
                            color: color,
                            padding: padding)
  }
}
