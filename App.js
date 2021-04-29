/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React, {useEffect} from 'react';
import type {Node} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
  requireNativeComponent,
  NativeModules
} from 'react-native';

import {
  Colors,
  DebugInstructions,
  Header,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

const KaKaoAlbumView = requireNativeComponent("KaKaoAlbumView")

const App: () => Node = () => {
  const isDarkMode = useColorScheme() === 'dark';
  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  useEffect(() => {
    const AlbumManager = NativeModules.AlbumManager;
    AlbumManager.getAlbums().then(response => {
      const data = JSON.parse(response)
      console.log(data)
    }).catch(e => console.log(e))
  }, [])
  return (
    <SafeAreaView style={backgroundStyle}>
      <KaKaoAlbumView style={{
        width: '100%',
        height: '100%',
        backgroundColor: 'red',
        justifyContent: 'center',
        alignItems: 'center'
      }}/>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  highlight: {
    fontWeight: '700',
  },
});

export default App;
