import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyANdTHShC_C_7eF8Lr3CdARGvfJlZJ9pWw',
    appId: '1:296089790099:web:f4a7b6cffb1ff6c0f3cf66',
    messagingSenderId: '296089790099',
    projectId: 'parking-252f9',
    authDomain: 'parking-252f9.firebaseapp.com',
    storageBucket: 'parking-252f9.firebasestorage.app',
    measurementId: 'G-KBHDLD79X3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANdTHShC_C_7eF8Lr3CdARGvfJlZJ9pWw',
    appId: '1:296089790099:web:f4a7b6cffb1ff6c0f3cf66',
    messagingSenderId: '296089790099',
    projectId: 'parking-252f9',
    storageBucket: 'parking-252f9.firebasestorage.app',
  );
}