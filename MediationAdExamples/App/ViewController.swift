//
//  ViewController.swift
//  MediationAdExamples
//
//  Created by Trịnh Xuân Minh on 10/10/2022.
//

import UIKit
import MediationAdManager

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  @IBAction func onTapShowInterstitial(_ sender: Any) {
    MediationAdManager.shared.show(ad: .interstitial)
  }
  
  @IBAction func onTapShowAppOpen(_ sender: Any) {
    MediationAdManager.shared.show(ad: .appOpen)
  }
  
  @IBAction func onTapShowRewarded(_ sender: Any) {
    MediationAdManager.shared.show(ad: .rewarded)
  }
  
  @IBAction func onTapShowBanner(_ sender: Any) {
    let bannerAdView = BannerAdView()
    bannerAdView.backgroundColor = .cyan
    bannerAdView.frame = CGRect(x: 0, y: self.view.frame.height - self.view.safeAreaInsets.bottom - BannerAdView.adHeightMinimum(), width: self.view.frame.width, height: BannerAdView.adHeightMinimum())
    bannerAdView.setLoading(color: .orange)
    self.view.addSubview(bannerAdView)
  }
  
  @IBAction func onTapShowNative(_ sender: Any) {
    let nativeAdView = MediumManualNativeAdView()
    nativeAdView.backgroundColor = .cyan
    nativeAdView.setColor(callToActionText: .black)
    nativeAdView.frame = CGRect(x: 0, y: self.view.safeAreaInsets.top, width: self.view.frame.width, height: MediumManualNativeAdView.adHeightMinimum(width: self.view.frame.width))
    self.view.addSubview(nativeAdView)
  }
  
  @IBAction func onTapToNativeCV(_ sender: Any) {
    navigationController?.pushViewController(NativeViewController(), animated: true)
  }
}

