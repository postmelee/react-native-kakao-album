//
//  ThumbnailCell.swift
//  KakaoAlbum
//
//  Created by ChikaChika on 2021/04/20.
//

import UIKit

class ThumbnailCell: UICollectionViewCell {
  var representAssetIdentifier = ""
  
  let contianerView: UIView = {
    let view = UIView()
    view.layer.borderWidth = 1
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  
  override func layoutSubviews() {
      super.layoutSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    contentView.addSubview(contianerView)
  }
  
  func setupConstraints() {
    contianerView.frame = contentView.bounds
  }
}
