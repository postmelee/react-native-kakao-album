//
//  GalleryViewController.swift
//  KakaoAlbum
//
//  Created by 이태규 on 2021/04/15.
//

import UIKit

class MainView: UIView {
  weak var mainViewController: MainViewController?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    if  mainViewController == nil {
      embed()
    } else {
      mainViewController?.view.frame = bounds
    }
  }
  
  private func embed() {
    guard let parentVC = parentViewController else {
      return
    }
    
    let vc = MainViewController()
    parentVC.addChild(vc)
    addSubview(vc.view)
    vc.view.frame = bounds
    vc.didMove(toParent: parentVC)
    self.mainViewController = vc
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
