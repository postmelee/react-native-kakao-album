//
//  GalleryView.swift
//  KakaoAlbum
//
//  Created by 이태규 on 2021/04/15.
//

import UIKit
import Photos

class MainViewController: UIViewController {
  
  let galleryVC = GalleryViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupConstraint()
  }
  func setupView() {
    self.addChild(galleryVC)
    self.view.addSubview(galleryVC.view)
  }
  
  func setupConstraint() {
    galleryVC.view.frame = self.view.bounds
  }
  
}

