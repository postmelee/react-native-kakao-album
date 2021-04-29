//
//  KaKaoAlbumViewManager.m
//  KakaoAlbum
//
//  Created by 이태규 on 2021/04/15.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(KaKaoAlbumViewManager, RCTViewManager)
@end

@interface RCT_EXTERN_MODULE(AlbumManager, NSObject)
RCT_EXTERN_METHOD(getAlbums: (RCTPromiseResolveBlock)resolve rejector: (RCTPromiseRejectBlock)reject)
@end
