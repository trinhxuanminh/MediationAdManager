//
//  MediumNativeAdCollectionViewCell.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 01/11/2022.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

public class MediumNativeAdCollectionViewCell: BaseCollectionViewCell {
  
  private lazy var nativeAdView: MediumNativeAdView = {
    let nativeAdView = MediumNativeAdView()
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
  
  public func setLoading(type: NVActivityIndicatorType? = nil,
                         color: UIColor? = nil,
                         padding: CGFloat? = nil
  ) {
    nativeAdView.setLoading(type: type,
                            color: color,
                            padding: padding)
  }
}
