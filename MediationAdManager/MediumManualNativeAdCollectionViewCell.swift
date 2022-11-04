//
//  MediumManualNativeAdCollectionViewCell.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 01/11/2022.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

public class MediumManualNativeAdCollectionViewCell: BaseCollectionViewCell {
  
  private lazy var nativeAdView: MediumManualNativeAdView = {
    let nativeAdView = MediumManualNativeAdView()
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
  
  public class func adHeightMinimum(width: CGFloat) -> CGFloat {
    return width / 16.0 * 9.0 + 160.0
  }
  
  public func setColor(titleText: UIColor? = nil,
                       adText: UIColor? = nil,
                       advertiserText: UIColor? = nil,
                       bodyText: UIColor? = nil,
                       callToActionText: UIColor? = nil,
                       callToActionBackground: UIColor? = nil
  ) {
    nativeAdView.setColor(titleText: titleText,
                          adText: adText,
                          advertiserText: advertiserText,
                          bodyText: bodyText,
                          callToActionText: callToActionText,
                          callToActionBackground: callToActionBackground)
  }
  
  public func setFont(title: UIFont? = nil,
                      ad: UIFont? = nil,
                      advertiser: UIFont? = nil,
                      body: UIFont? = nil,
                      callToAction: UIFont? = nil)
  {
    nativeAdView.setFont(title: title,
                         ad: ad,
                         advertiser: advertiser,
                         body: body,
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
