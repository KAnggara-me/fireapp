import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDoDEgVkvx2ZxM_FLwv6j2xvH_tq0D5uR8',
    appId: '1:756242541281:web:22b7c7195cea46c30e65a0',
    messagingSenderId: '756242541281',
    projectId: 'fire-app-1121',
    authDomain: 'fire-app-1121.firebaseapp.com',
    storageBucket: 'fire-app-1121.appspot.com',
    measurementId: 'G-XV48BXDXHW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAlerMGrNzELOQ12pGurU-qogqq1gu5c8o',
    appId: '1:756242541281:android:d1676421ae4349e20e65a0',
    messagingSenderId: '756242541281',
    projectId: 'fire-app-1121',
    storageBucket: 'fire-app-1121.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdzpqRvwHJcbstBWmCN7AB9-XaSHewGhA',
    appId: '1:756242541281:ios:da77f83a9d6831250e65a0',
    messagingSenderId: '756242541281',
    projectId: 'fire-app-1121',
    storageBucket: 'fire-app-1121.appspot.com',
    androidClientId:
        '756242541281-q970ddar81o60suhej7ecdolqin4ep5s.apps.googleusercontent.com',
    iosClientId:
        '756242541281-nuhn4pk7t2tpn9gh5tbrj2r4t7i39j2p.apps.googleusercontent.com',
    iosBundleId: 'my.id.kanggara.fireapp',
  );
}
