//
//  GalleryViewController.swift
//  KakaoAlbum
//
//  Created by 이태규 on 2021/04/20.
//

import UIKit
import Photos

class GalleryViewController: UIViewController {
  private let imageManager = PHCachingImageManager()
  private var allPhotos: PHFetchResult<PHAsset>?
  var indexOfSelectedPhotos: [Int] = []
  private let requestTargetSize = CGSize(width: 200, height: 200)
  private let requestOptions: PHImageRequestOptions = {
    let options = PHImageRequestOptions()
    options.deliveryMode = .opportunistic
    return options
  }()
  
  fileprivate let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 2
    layout.minimumInteritemSpacing = 1
    layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.allowsMultipleSelection = true
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.register(ImageCell.self, forCellWithReuseIdentifier: K.cellIdentifier)
    cv.backgroundColor = .white
    return cv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(collectionView)
    setupView()
    setupConstraint()
    fetchAllPhotos()
  }
  
  func setupView() {
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  func setupConstraint() {
    collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
  }
  
  func fetchAllPhotos() {
    let fetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
    allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
    
    DispatchQueue.global(qos: .background).async { [weak self] in
      guard let self = self else {return}
      if let safePhotos = self.allPhotos {
        var assets = [PHAsset]()
        safePhotos.enumerateObjects { (asset, count, stop) in
          assets.append(asset)
        }
        
        self.imageManager.startCachingImages(for: assets, targetSize: self.requestTargetSize, contentMode: .aspectFill, options: self.requestOptions)
      }
    }
  }
  
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if allPhotos != nil {
      return allPhotos!.count
    } else {
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cellIdentifier, for: indexPath) as! ImageCell
    if let safePhotos = allPhotos {
      let asset = safePhotos.object(at: indexPath.item)
      cell.representAssetIdentifier = asset.localIdentifier
      
      imageManager.requestImage(for: asset, targetSize: requestTargetSize, contentMode: .aspectFill, options: requestOptions) { (image, _) in
        if cell.representAssetIdentifier == asset.localIdentifier {
          cell.ImageView.image = image
        }
      }
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width: CGFloat = collectionView.frame.width / 3 - 2
    return CGSize(width: width, height: width)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedCell = collectionView.cellForItem(at: indexPath) as! ImageCell
    selectedCell.selectedIndex = indexOfSelectedPhotos.count + 1
    indexOfSelectedPhotos.append(indexPath.item)
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    let selectedCell = collectionView.cellForItem(at: indexPath) as! ImageCell
    let indexOfSelectedCell = Int(selectedCell.IndexLabel.text!)! - 1
    for i in indexOfSelectedCell..<indexOfSelectedPhotos.count {
      let cellIndexPath = IndexPath(item: indexOfSelectedPhotos[i], section: 0)
      if let cell = collectionView.cellForItem(at: cellIndexPath) as? ImageCell {
        cell.decreaseIndex()
      }
    }
    indexOfSelectedPhotos.remove(at: indexOfSelectedCell)
  }
}
