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
    apiKey: 'AIzaSyCA9lbMXU-iS2m0-eKDtmbIRRop2VEyskc',
    appId: '1:355255457708:web:5b7aa8f7e21cee2f070c09',
    messagingSenderId: '355255457708',
    projectId: 'mfde-submission',
    authDomain: 'mfde-submission.firebaseapp.com',
    storageBucket: 'mfde-submission.appspot.com',
    measurementId: 'G-813LJ3H06F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDECz-JpkcEzA6V-LyKbTx8ltLABXKducM',
    appId: '1:355255457708:android:dbed67193fa11f43070c09',
    messagingSenderId: '355255457708',
    projectId: 'mfde-submission',
    storageBucket: 'mfde-submission.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbT7Yl6VxL_314BZw7yc3V16PHWDQg74Y',
    appId: '1:355255457708:ios:00a76a9a499316e0070c09',
    messagingSenderId: '355255457708',
    projectId: 'mfde-submission',
    storageBucket: 'mfde-submission.appspot.com',
    iosClientId: '355255457708-s18fa7vqatrcsvo53fvstkel7sc6ldtq.apps.googleusercontent.com',
    iosBundleId: 'com.dicoding.ditonton',
  );
}
