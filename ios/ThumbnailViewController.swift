//
//  ThumbnailViewController.swift
//  KakaoAlbum
//
//  Created by 이태규 on 2021/04/20.
//

import UIKit
import Photos

class ThumbnailViewController: UIViewController {

  fileprivate let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 8
    layout.scrollDirection = .horizontal
    layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    layout.itemSize = CGSize(width: 59, height: 59)
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.register(ThumbnailCell.self, forCellWithReuseIdentifier: K.thumbnailIdentifier)
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.backgroundColor = .white
    return cv
  }()
  
  private let imageManager = PHCachingImageManager()
  private let requestTargetSize = CGSize(width: 20, height: 20)
  private let requestOptions: PHImageRequestOptions = {
    let options = PHImageRequestOptions()
    options.deliveryMode = .opportunistic
    return options
  }()
  
  var selectedPhotos: [ThumbnailModel] = [] {
    didSet {
      collectionView.reloadData()
    }
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
  
  func setupViews() {
    view.addSubview(collectionView)
    collectionView.sizeToFit()
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  func setupConstraints() {
    collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
  }

}

extension ThumbnailViewController: UICollectionViewDelegate {
  
}

extension ThumbnailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.selectedPhotos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.thumbnailIdentifier, for: indexPath) as! ThumbnailCell
    guard let asset = selectedPhotos[indexPath.item].asset else {return cell}
    cell.representAssetIdentifier = asset.localIdentifier
    imageManager.requestImage(for: asset, targetSize: requestTargetSize, contentMode: .aspectFill, options: requestOptions) { (image, _) in
      if cell.representAssetIdentifier == asset.localIdentifier {
        cell.ImageView.image = image
      }
    }
    return cell
  }
  
  
}

extension ThumbnailViewController: UICollectionViewDelegateFlowLayout {
}

