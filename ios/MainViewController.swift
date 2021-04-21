//
//  GalleryView.swift
//  KakaoAlbum
//
//  Created by 이태규 on 2021/04/15.
//

import UIKit
import Photos

class MainViewController: UIViewController {
  
  let stackView = UIStackView()
  let thumbnailVC = ThumbnailViewController()
  let galleryVC = GalleryViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupConstraint()
  }
  func setupView() {
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.addArrangedSubview(thumbnailVC.view)
    stackView.addArrangedSubview(galleryVC.view)
    self.view.addSubview(stackView)
  }
  
  func setupConstraint() {
    stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    stackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    stackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    thumbnailVC.view.heightAnchor.constraint(equalToConstant: 91).isActive = true
  }
  
}

