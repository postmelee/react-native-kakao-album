# react-native-kakao-album

`react-native-kakao-album` is an experimental iOS-native photo picker for
React Native apps.

The goal was to avoid the slow photo-loading path commonly seen in hybrid app
frameworks by moving the album grid, thumbnail caching, camera entry point, and
selection UI into Swift/UIKit. In the original production use case, this
approach reduced the user photo loading experience from about 3 seconds to
about 0.1 seconds.

## Project Status

This repository is an archived prototype, not a production-ready npm package.
It is useful as a reference for bridging a native Swift photo picker into a
React Native app.

- iOS-focused implementation
- React Native 0.64 sample app
- Swift/UIKit native view embedded through `RCTViewManager`
- Objective-C bridge for React Native module exports
- Android project is the untouched React Native template

## Features

- Exposes a native `KaKaoAlbumView` component to React Native.
- Fetches iOS photo albums through `Photos.framework`.
- Renders a 3-column native `UICollectionView` image grid.
- Uses `PHCachingImageManager` to preload thumbnails.
- Supports multi-select with numbered selection overlays.
- Shows a horizontal selected-thumbnail tray.
- Provides a camera entry cell and opens `UIImagePickerController`.
- Includes a native crop UI layout workaround for the camera picker.
- Exposes `AlbumManager.getAlbums()` as a Promise-based native module.

## Why This Exists

A photo upload flow similar to KakaoTalk's album picker needs to feel immediate,
even when the user has a large local photo library. A default hybrid approach
can become too slow for that user-facing flow because album rendering,
thumbnail loading, and selection state all compete with the JavaScript-driven UI
path.

This prototype keeps the heavy album and thumbnail work inside the iOS native
layer:

- `Photos.framework` fetches assets directly from the local photo library.
- `PHCachingImageManager` caches image thumbnails for smoother scrolling.
- UIKit collection views handle grid layout and selection state.
- React Native embeds the native view instead of rendering every photo item in
  JavaScript.

## Usage Example

```js
import React, {useEffect} from 'react';
import {NativeModules, requireNativeComponent} from 'react-native';

const KaKaoAlbumView = requireNativeComponent('KaKaoAlbumView');

export default function App() {
  useEffect(() => {
    NativeModules.AlbumManager.getAlbums()
      .then(response => {
        const albums = response.map(item => JSON.parse(item));
        console.log(albums);
      })
      .catch(console.error);
  }, []);

  return <KaKaoAlbumView style={{width: '100%', height: '100%'}} />;
}
```

## Native Bridge

The bridge is split between Swift and Objective-C:

- `ios/KaKaoAlbumViewManager.swift` creates the native React Native view.
- `ios/KaKaoAlbumViewManager.m` exports the Swift view manager and album module
  to React Native.
- `ios/MainView.swift` embeds `MainViewController` into the React Native view.
- `ios/AlbumManager.swift` exposes album metadata through a Promise.

## iOS UI Structure

```text
KaKaoAlbumView
`-- MainView
    `-- MainViewController
        |-- ThumbnailViewController
        |   `-- horizontal selected-photo tray
        `-- GalleryViewController
            `-- 3-column photo grid and camera entry cell
```

## Development

Install dependencies:

```sh
npm install
```

Install iOS pods:

```sh
cd ios
pod install
```

Run the iOS app:

```sh
npm run ios
```

## Permissions

The iOS app declares:

- `NSPhotoLibraryUsageDescription`
- `NSCameraUsageDescription`

Apps adopting the same approach should provide production-ready permission copy
and handle authorization states explicitly before reading the photo library.

## Known Limits

- The repository is a prototype and has not been packaged as a reusable npm
  library.
- The public JavaScript API is minimal.
- Selected photos are managed inside the native UI; a production package should
  add a typed event/callback contract back to React Native.
- `AlbumManager.getAlbums()` currently returns JSON strings and should be
  normalized before production use.
- Android support is not implemented.
- The project uses legacy React Native 0.64-era tooling.

## License

MIT
