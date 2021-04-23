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
  let imagePicker = UIImagePickerController()
  let thumbnailVC = ThumbnailViewController()
  let galleryVC = GalleryViewController()
  
  var thumbnailViewHeightContraint: NSLayoutConstraint!
  
  var selectedPhotos: [ThumbnailModel] = [] {
    didSet {
      if oldValue.count == 0 || selectedPhotos.count == 0  {
        toggleThumbnailView()
      }
      thumbnailVC.selectedPhotos = selectedPhotos
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    galleryVC.delegate = self
    imagePicker.sourceType = .camera
    imagePicker.allowsEditing = true
    imagePicker.delegate = self
  
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
    thumbnailViewHeightContraint = NSLayoutConstraint(item: thumbnailVC.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 0.0, constant: 0)
    thumbnailViewHeightContraint.isActive = true
  }
  
  func toggleThumbnailView() {
    self.view.layoutIfNeeded()
    thumbnailViewHeightContraint.constant = thumbnailViewHeightContraint.constant == 91 ? 0 : 91
    UIView.animate(withDuration: 0.2) {
      self.view.layoutIfNeeded()
    }
  }
}

extension MainViewController: GalleryViewControllerProtocol {
  func setSelectedPhoto(photos: [ThumbnailModel]) {
    self.selectedPhotos = photos
  }
  
  func presentCamera() {
    present(imagePicker, animated: true)
  }
}


extension MainViewController: UINavigationControllerDelegate {
  
}

extension MainViewController: UIImagePickerControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.editedImage] as! UIImage
    
        dismiss(animated:true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    imagePicker.dismiss(animated: true, completion: nil)
  }
  
  
  
}

extension UIImagePickerController {
    open override var childForStatusBarHidden: UIViewController? {
        return nil
    }

    open override var prefersStatusBarHidden: Bool {
        return true
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fixCannotMoveEditingBox()
    }
    
    func fixCannotMoveEditingBox() {
            if let cropView = cropView,
               let scrollView = scrollView,
               scrollView.contentOffset.y == 0 {
                
                var top: CGFloat = 0.0
                if #available(iOS 11.0, *) {
                    top = cropView.frame.minY + self.view.safeAreaInsets.top
                } else {
                    // Fallback on earlier versions
                    top = cropView.frame.minY
                }
                let bottom = scrollView.frame.height - cropView.frame.height - top
                scrollView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: bottom, right: 0)
                
                var offset: CGFloat = 0
                if scrollView.contentSize.height > scrollView.contentSize.width {
                    offset = 0.5 * (scrollView.contentSize.height - scrollView.contentSize.width)
                }
                scrollView.contentOffset = CGPoint(x: 0, y: -top + offset)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                self?.fixCannotMoveEditingBox()
            }
        }
        
        var cropView: UIView? {
            return findCropView(from: self.view)
        }
        
        var scrollView: UIScrollView? {
            return findScrollView(from: self.view)
        }
        
        func findCropView(from view: UIView) -> UIView? {
            let width = UIScreen.main.bounds.width
            let size = view.bounds.size
            if width == size.height, width == size.height {
                return view
            }
            for view in view.subviews {
                if let cropView = findCropView(from: view) {
                    return cropView
                }
            }
            return nil
        }
        
        func findScrollView(from view: UIView) -> UIScrollView? {
            if let scrollView = view as? UIScrollView {
                return scrollView
            }
            for view in view.subviews {
                if let scrollView = findScrollView(from: view) {
                    return scrollView
                }
            }
            return nil
        }
}
