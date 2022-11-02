//
//  SmallNativeAdCollectionViewCell.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 31/10/2022.
//

import UIKit
import SnapKit

public class SmallNativeAdCollectionViewCell: BaseCollectionViewCell {
  
  private lazy var nativeAdView: SmallNativeAdView = {
    let nativeAdView = SmallNativeAdView()
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
}
