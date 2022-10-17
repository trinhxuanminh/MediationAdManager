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
  func show(didDisplay: (() -> Void)?,
            didHide: (() -> Void)?,
            didClick: (() -> Void)?,
            didFail: (() -> Void)?)
}

protocol ReuseAdProtocol: AdProtocol {
  func setTimeBetween(_ timeBetween: Double)
}


protocol OnceAdProtocol: AdProtocol {
  func stopLoading()
}
