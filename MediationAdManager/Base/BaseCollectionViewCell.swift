//
//  BaseCollectionViewCell.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 01/11/2022.
//

import UIKit

public class BaseCollectionViewCell: UICollectionViewCell, ViewProtocol {
  
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
  
  func addComponents() {}
  
  func setConstraints() {}
  
  func setProperties() {}
  
  func setColor() {}
}
