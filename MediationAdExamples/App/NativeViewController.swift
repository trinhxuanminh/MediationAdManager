//
//  NativeViewController.swift
//  MediationAdExamples
//
//  Created by Trịnh Xuân Minh on 01/11/2022.
//

import UIKit
import MediationAdManager

class NativeViewController: UIViewController {
  
  @IBOutlet weak var nativeCV: UICollectionView! {
    didSet {
      nativeCV.delegate = self
      nativeCV.dataSource = self
      nativeCV.register(of: SmallNativeAdCollectionViewCell.self)
      nativeCV.register(of: MediumNativeAdCollectionViewCell.self)
      nativeCV.register(of: SmallManualNativeAdCollectionViewCell.self)
      nativeCV.register(of: MediumManualNativeAdCollectionViewCell.self)
    }
  }
  
  @IBAction func onTapBack(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
}

extension NativeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch indexPath.item {
    case 0:
      return CGSize(width: collectionView.frame.width, height: SmallNativeAdCollectionViewCell.adHeightMinimum())
    case 1:
      return CGSize(width: collectionView.frame.width, height: MediumNativeAdCollectionViewCell.adHeightMinimum(width: collectionView.frame.width))
    case 2:
      return CGSize(width: collectionView.frame.width, height: SmallManualNativeAdCollectionViewCell.adHeightMinimum())
    default:
      return CGSize(width: collectionView.frame.width, height: MediumManualNativeAdCollectionViewCell.adHeightMinimum(width: collectionView.frame.width))
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10.0
  }
}

extension NativeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.item {
    case 0:
      let cell = collectionView.dequeue(ofType: SmallNativeAdCollectionViewCell.self, indexPath: indexPath)
      return cell
    case 1:
      let cell = collectionView.dequeue(ofType: MediumNativeAdCollectionViewCell.self, indexPath: indexPath)
      return cell
    case 2:
      let cell = collectionView.dequeue(ofType: SmallManualNativeAdCollectionViewCell.self, indexPath: indexPath)
      cell.setColor(callToActionBackground: .black)
      return cell
    default:
      let cell = collectionView.dequeue(ofType: MediumManualNativeAdCollectionViewCell.self, indexPath: indexPath)
      return cell
    }
  }
}
