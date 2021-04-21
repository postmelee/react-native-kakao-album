//
//  ThumbnailViewController.swift
//  KakaoAlbum
//
//  Created by 이태규 on 2021/04/20.
//

import UIKit

class ThumbnailViewController: UIViewController {

  fileprivate let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 8
    layout.scrollDirection = .horizontal
    layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "thumbnail")
    cv.autoresizesSubviews = true
    cv.autoresizingMask = .flexibleHeight
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.backgroundColor = .green
    return cv
  }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
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
    return 30
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thumbnail", for: indexPath)
    cell.backgroundColor = .blue
    return cell
  }
  
  
}

extension ThumbnailViewController: UICollectionViewDelegateFlowLayout {

}

