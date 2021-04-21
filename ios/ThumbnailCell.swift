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
    view.backgroundColor = .red
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
  
  override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    self.setNeedsDisplay()
    self.layoutIfNeeded()

    let size = self.contentView.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize)
    layoutAttributes.size = size
    return layoutAttributes
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
