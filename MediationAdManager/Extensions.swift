//
//  Extensions.swift
//  MediationAdManager
//
//  Created by Trịnh Xuân Minh on 21/10/2022.
//

import UIKit

extension UIColor {
  convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")

    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
  }

  convenience init(rgb: Int, alpha: CGFloat = 1.0) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: (rgb >> 8) & 0xFF,
      blue: rgb & 0xFF, alpha: alpha
    )
  }
}

extension UICollectionView {
  public func register(of type: AnyClass) {
      self.register(type, forCellWithReuseIdentifier: String(describing: type.self))
  }

  public func dequeue<T>(ofType type: T.Type, indexPath: IndexPath) -> T {
    return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
  }
}
