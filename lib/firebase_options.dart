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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDx7B_pqzrMhiyirjSp7SXQ2y-X0UZoE2o',
    appId: '1:575309658059:android:c9acb093b4ea5ac6f0284e',
    messagingSenderId: '575309658059',
    projectId: 'washu-6ba03',
    storageBucket: 'washu-6ba03.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2tagLxEkWG9rhThA-ZQRK_6Ye1HpxAig',
    appId: '1:575309658059:ios:5bd8677012d0272af0284e',
    messagingSenderId: '575309658059',
    projectId: 'washu-6ba03',
    storageBucket: 'washu-6ba03.appspot.com',
    androidClientId: '575309658059-3p9b6tsemlglcmu4g3if80e68jkpom6o.apps.googleusercontent.com',
    iosClientId: '575309658059-ml8n8c6itvg2rgvvbg29b8qu7fredl2m.apps.googleusercontent.com',
    iosBundleId: 'com.example.washer',
  );
}
