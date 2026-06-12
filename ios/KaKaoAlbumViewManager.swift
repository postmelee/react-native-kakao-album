//
//  KaKapAlbumViewManager.swift
//  KakaoAlbum
//
//  Created by 이태규 on 2021/04/15.
//

import Photos

protocol KaKaoAlbumViewManagerProtocol {
  
}

@objc(KaKaoAlbumViewManager)
class KaKaoAlbumViewManager: RCTViewManager {
  
  override func view() -> UIView! {
    return MainView()
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return false
  }
}
