// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyCC42b6E6pDnUqZmSJX9zhK5fMGxdzPxBg',
    appId: '1:367818138912:web:7f0684e45d606cedaee345',
    messagingSenderId: '367818138912',
    projectId: 'tubesconsul',
    authDomain: 'tubesconsul.firebaseapp.com',
    storageBucket: 'tubesconsul.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBaRfacowwvTwyUSvqZBAhuycT6bK3UC4A',
    appId: '1:367818138912:android:418ab2ecda860e10aee345',
    messagingSenderId: '367818138912',
    projectId: 'tubesconsul',
    storageBucket: 'tubesconsul.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJD5dgqNx_nkqozO2fuQXa-LXwNjW09Cc',
    appId: '1:367818138912:ios:415faa0f5971c612aee345',
    messagingSenderId: '367818138912',
    projectId: 'tubesconsul',
    storageBucket: 'tubesconsul.appspot.com',
    iosBundleId: 'com.example.consultantApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJD5dgqNx_nkqozO2fuQXa-LXwNjW09Cc',
    appId: '1:367818138912:ios:fb13c42a84b23cbcaee345',
    messagingSenderId: '367818138912',
    projectId: 'tubesconsul',
    storageBucket: 'tubesconsul.appspot.com',
    iosBundleId: 'com.example.consultantApp.RunnerTests',
  );
}
