//
//  MediationAdManager.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 10/10/2022.
//

import Foundation

public final class MediationAdManager {
  
  public static let shared = MediationAdManager()
  
  private let test = 20.0
  
  public func getTest() -> Double {
    return test
  }
}
