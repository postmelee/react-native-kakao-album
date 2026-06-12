//
//  ImageCell.swift
//  KakaoAlbum
//
//  Created by 이태규 on 2021/04/16.
//

import UIKit

class ImageCell: UICollectionViewCell {

  var selectedIndex: Int? {
    didSet {
      if let indexNumber = selectedIndex {
        IndexLabel.text = "\(indexNumber)"
      }
    }
  }
  
  var representAssetIdentifier = ""
  
  func decreaseIndex() {
    if self.selectedIndex != nil {
      self.selectedIndex! -= 1
    }
  }
  
  let ImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.layer.zPosition = 0
      return imageView
  }()
  
  let OverlayView: UIView = {
    let overlayView = UIView()
    overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    overlayView.layer.borderWidth = 2
    overlayView.layer.borderColor = #colorLiteral(red: 0, green: 0.7568627451, blue: 1, alpha: 1)
    overlayView.layer.zPosition = 1
    return overlayView
  }()
  
  let IndexLabel: UILabel = {
      let indexLabel = UILabel()
      indexLabel.text = "1"
      indexLabel.font = UIFont.boldSystemFont(ofSize: 11)
      indexLabel.translatesAutoresizingMaskIntoConstraints = false
      indexLabel.textColor = .white
      return indexLabel
  }()
  
  let IndexView: UIView = {
    let indexView = UIView()
      indexView.backgroundColor = UIColor(red: 0, green: 0.82, blue: 1, alpha: 1)
      indexView.layer.cornerRadius = 12
    indexView.translatesAutoresizingMaskIntoConstraints = false
      return indexView
  }()
  
  override var isSelected: Bool {
      didSet {
        if self.representAssetIdentifier != "camera" {
          OverlayView.isHidden = !isSelected
        }
      }
  }
  
  func setupViews() {
    contentView.addSubview(ImageView)
    contentView.addSubview(OverlayView)
    OverlayView.addSubview(IndexView)
    IndexView.addSubview(IndexLabel)
    OverlayView.isHidden = true
  }
  
  func setupConstraints() {
    IndexLabel.centerXAnchor.constraint(equalTo: IndexView.centerXAnchor).isActive = true
    IndexLabel.centerYAnchor.constraint(equalTo: IndexView.centerYAnchor).isActive = true
    IndexView.widthAnchor.constraint(equalToConstant: 24).isActive = true
    IndexView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    IndexView.topAnchor.constraint(equalTo: OverlayView.topAnchor, constant: 8).isActive = true
    IndexView.rightAnchor.constraint(equalTo: OverlayView.rightAnchor, constant: -8).isActive = true
  }

  override init(frame: CGRect) {
      super.init(frame: frame)
      setupViews()
      setupConstraints()
  }
  
  required init?(coder: NSCoder){
      fatalError()
  }
  
  override func layoutSubviews() {
      super.layoutSubviews()
      ImageView.frame = contentView.bounds
      OverlayView.frame = ImageView.bounds
  }
  
  override func prepareForReuse() {
      super.prepareForReuse()
      ImageView.image = nil
      IndexLabel.text = nil
      representAssetIdentifier = ""
      OverlayView.isHidden = true
  }
//    @IBOutlet weak var OverlayView: UIView!
//    @IBOutlet weak var ImageView: UIImageView!
//    @IBOutlet weak var IndexView: UIView!
//    @IBOutlet weak var IndexLabel: UILabel!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        IndexView.layer.cornerRadius = IndexView.frame.size.width / 2
//        OverlayView.layer.borderWidth = 2
//        OverlayView.layer.borderColor = #colorLiteral(red: 0, green: 0.7568627451, blue: 1, alpha: 1)
//        OverlayView.isHidden = true
//    }
//
//  override var isSelected: Bool {
//    didSet {
//      if isSelected {
//        OverlayView.isHidden = false
//      } else {
//        OverlayView.isHidden = true
//      }
//    }
//  }
//
//  override func prepareForReuse() {
//    OverlayView.removeFromSuperview()
//    ImageView.removeFromSuperview()
//    super.prepareForReuse()
//  }
}
