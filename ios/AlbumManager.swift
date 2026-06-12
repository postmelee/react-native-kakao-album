//
//  AlbumManager.swift
//  KakaoAlbum
//
//  Created by ChikaChika on 2021/04/29.
//

import Foundation
import Photos

@objc(AlbumManager)
class AlbumManager: NSObject {
  @objc static func requiresMainQueueSetup() -> Bool {
    return false
  }
  
  @objc func getAlbums(_ resolve: @escaping RCTPromiseResolveBlock, rejector reject: @escaping RCTPromiseRejectBlock) -> Void {
    var result = [NSString]()
    let fetchOptions = PHFetchOptions()
    let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: fetchOptions)
    
    smartAlbums.enumerateObjects { (assetCollection, index, stop) in
      let asset = PHAsset.fetchAssets(in: assetCollection, options: fetchOptions)
      if let _ = asset.firstObject {
        let album = AlbumModel(title: assetCollection.localizedTitle, count: asset.count, uri: "ph://%\(asset.firstObject!.localIdentifier)")
        
        do {
          let jsonData = try JSONEncoder().encode(album)
          let jsonString = String(data: jsonData, encoding: .utf8)!
          print(jsonString)
          result.append(jsonString as NSString)
        } catch { print(error)
          reject(error.localizedDescription, nil, error)
        }
      }
    }
    resolve(result)
  }
}
