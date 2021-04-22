//
//  ThumbnailCell.swift
//  KakaoAlbum
//
//  Created by ChikaChika on 2021/04/20.
//

import UIKit

class ThumbnailCell: UICollectionViewCell {
  var representAssetIdentifier = ""

  let ImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.backgroundColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1).cgColor
    imageView.layer.cornerRadius = 2
    imageView.layer.borderWidth = 0.5
    imageView.layer.borderColor = UIColor(red: 0.885, green: 0.902, blue: 0.928, alpha: 1).cgColor
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  
  let DeleteImage: UIImageView = {
    let deleteImage = UIImageView()
    deleteImage.alpha = 0.6
    deleteImage.layer.backgroundColor = UIColor(red: 0.076, green: 0.121, blue: 0.237, alpha: 1).cgColor
    deleteImage.layer.cornerRadius = 10
    deleteImage.contentMode = .center
    deleteImage.image = UIImage(named: "delete")
    deleteImage.translatesAutoresizingMaskIntoConstraints = false
    return deleteImage
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  
  override func layoutSubviews() {
      super.layoutSubviews()
  }
  
  
//  override func updateConstraints() {
//    super.updateConstraints()
//    layoutMargins = .zero
//    layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 5)
//  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    contentView.addSubview(ImageView)
    contentView.addSubview(DeleteImage)
  }
  
  func setupConstraints() {
    ImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
    ImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
    ImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    ImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
    DeleteImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
    DeleteImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
    DeleteImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    DeleteImage.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
  }
}
