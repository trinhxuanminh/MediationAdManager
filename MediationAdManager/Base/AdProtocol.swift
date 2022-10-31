//
//  AdProtocol.swift
//  
//
//  Created by Trịnh Xuân Minh on 17/10/2022.
//

import Foundation

protocol AdProtocol {
  func createAd(_ adUnitID: String)
  func isDisplay() -> Bool
  func load()
  func isReady() -> Bool
  func setTimeBetween(_ timeBetween: Double)
  func show(didDisplay: (() -> Void)?,
            didHide: (() -> Void)?,
            didClick: (() -> Void)?,
            didFail: (() -> Void)?,
            didStartRewardedVideo: (() -> Void)?,
            didCompleteRewardedVideo: (() -> Void)?,
            didRewardUser: (() -> Void)?
  )
}
