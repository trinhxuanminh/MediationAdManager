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

  @IBAction func onTapShowInterstitial(_ sender: Any) {
    MediationAdManager.shared.show(ad: .interstitial)
  }
  
}

