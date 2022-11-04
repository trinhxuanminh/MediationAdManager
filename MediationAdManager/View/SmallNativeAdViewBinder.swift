//
//  SmallNativeAdViewBinder.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 03/11/2022.
//

import UIKit
import AppLovinSDK
import SnapKit

class SmallNativeAdViewBinder: MANativeAdView, ViewProtocol {
  
  private lazy var iconAdImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.tag = 101
    return imageView
  }()
  
  private lazy var adLabel: UILabel = {
    let label = UILabel()
    label.text = "Ad"
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
    return label
  }()
  
  private lazy var titleAdLabel: UILabel = {
    let label = UILabel()
    label.text = "Headline"
    label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    label.tag = 102
    return label
  }()
  
  private lazy var advertiserAdLabel: UILabel = {
    let label = UILabel()
    label.text = "Advertiser"
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    label.tag = 103
    return label
  }()
  
  private lazy var callToActionAdButton: UIButton = {
    let button = UIButton()
    button.setTitle("INSTALL", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    button.tag = 104
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addComponents()
    setConstraints()
    setProperties()
    setColor()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func addComponents() {
    addSubview(iconAdImageView)
    addSubview(adLabel)
    addSubview(titleAdLabel)
    addSubview(advertiserAdLabel)
    addSubview(callToActionAdButton)
  }
  
  func setConstraints() {
    iconAdImageView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.height.width.equalTo(90)
      make.leading.equalToSuperview().inset(16)
    }
    
    adLabel.snp.makeConstraints { make in
      make.leading.equalTo(iconAdImageView.snp.trailing).inset(-12)
      make.width.equalTo(24)
      make.height.equalTo(20)
      make.centerY.equalTo(titleAdLabel)
    }
    
    titleAdLabel.snp.makeConstraints { make in
      make.leading.equalTo(adLabel.snp.trailing).inset(-8)
      make.trailing.equalToSuperview().inset(16)
      make.height.equalTo(24)
      make.top.equalTo(iconAdImageView)
    }
    
    advertiserAdLabel.snp.makeConstraints { make in
      make.leading.equalTo(adLabel)
      make.top.equalTo(titleAdLabel.snp.bottom).inset(-3)
      make.height.equalTo(21)
      make.trailing.equalToSuperview().inset(16)
    }
    
    callToActionAdButton.snp.makeConstraints { make in
      make.top.equalTo(advertiserAdLabel.snp.bottom).inset(-5)
      make.leading.equalTo(adLabel)
      make.trailing.equalToSuperview().inset(16)
      make.bottom.equalTo(iconAdImageView)
    }
  }
  
  func setProperties() {
    adLabel.layer.cornerRadius = 4.0
    adLabel.layer.borderWidth = 1.0
    
    callToActionAdButton.layer.cornerRadius = 4.0
  }
  
  func setColor() {
    iconAdImageView.backgroundColor = UIColor(rgb: 0xF2F2F7)
    
    adLabel.textColor = UIColor(rgb: 0x456631)
    adLabel.layer.borderColor = UIColor(rgb: 0x456631).cgColor
    
    titleAdLabel.textColor = UIColor(rgb: 0x000000)
    
    advertiserAdLabel.textColor = UIColor(rgb: 0x000000, alpha: 0.5)
    
    callToActionAdButton.setTitleColor(UIColor(rgb: 0xFFFFFF), for: .normal)
    callToActionAdButton.backgroundColor = UIColor(rgb: 0x6399F0)
  }
  
  func setColor(titleText: UIColor? = nil,
                adText: UIColor? = nil,
                advertiserText: UIColor? = nil,
                callToActionText: UIColor? = nil,
                callToActionBackground: UIColor? = nil
  ) {
    if let titleText = titleText {
      titleAdLabel.textColor = titleText
    }
    if let adText = adText {
      adLabel.textColor = adText
      adLabel.layer.borderColor = adText.cgColor
    }
    if let advertiserText = advertiserText {
      advertiserAdLabel.textColor = advertiserText
    }
    if let callToActionText = callToActionText {
      callToActionAdButton.setTitleColor(callToActionText, for: .normal)
    }
    if let callToActionBackground = callToActionBackground {
      callToActionAdButton.backgroundColor = callToActionBackground
    }
  }
  
  func setFont(title: UIFont? = nil,
               ad: UIFont? = nil,
               advertiser: UIFont? = nil,
               callToAction: UIFont? = nil
  ) {
    if let title = title {
      titleAdLabel.font = title
    }
    if let ad = ad {
      adLabel.font = ad
    }
    if let advertiser = advertiser {
      advertiserAdLabel.font = advertiser
    }
    if let callToAction = callToAction {
      callToActionAdButton.titleLabel?.font = callToAction
    }
  }
}
