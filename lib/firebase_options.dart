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
    apiKey: 'AIzaSyBYU8ZCQTHXCp7HwynxGFEgafWlmMJtJDg',
    appId: '1:708980586889:web:7ca2372b57f3e05760c958',
    messagingSenderId: '708980586889',
    projectId: 'metrics-app-ba631',
    authDomain: 'metrics-app-ba631.firebaseapp.com',
    databaseURL: 'https://metrics-app-ba631-default-rtdb.firebaseio.com',
    storageBucket: 'metrics-app-ba631.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCxyNAgakLjQnzooR7ewsdem5-bEhpwzWk',
    appId: '1:708980586889:android:25a07010322b00d660c958',
    messagingSenderId: '708980586889',
    projectId: 'metrics-app-ba631',
    databaseURL: 'https://metrics-app-ba631-default-rtdb.firebaseio.com',
    storageBucket: 'metrics-app-ba631.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAN0mh5reOe_0aGvjkiAK0P8dC6VSYJRpg',
    appId: '1:708980586889:ios:5567672fbc75dc3460c958',
    messagingSenderId: '708980586889',
    projectId: 'metrics-app-ba631',
    databaseURL: 'https://metrics-app-ba631-default-rtdb.firebaseio.com',
    storageBucket: 'metrics-app-ba631.appspot.com',
    iosClientId:
        '708980586889-79shgpvhiartg7608ve20n5k1114bqdh.apps.googleusercontent.com',
    iosBundleId: 'com.example.metricsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAN0mh5reOe_0aGvjkiAK0P8dC6VSYJRpg',
    appId: '1:708980586889:ios:5567672fbc75dc3460c958',
    messagingSenderId: '708980586889',
    projectId: 'metrics-app-ba631',
    databaseURL: 'https://metrics-app-ba631-default-rtdb.firebaseio.com',
    storageBucket: 'metrics-app-ba631.appspot.com',
    iosClientId:
        '708980586889-79shgpvhiartg7608ve20n5k1114bqdh.apps.googleusercontent.com',
    iosBundleId: 'com.example.metricsApp',
  );
}
