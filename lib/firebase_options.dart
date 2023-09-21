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
    apiKey: 'AIzaSyB9-SgureaUC9yBfxss9Kc4t3Xt51sWIr8',
    appId: '1:993175523207:web:80fa3d530cad0aaea34d22',
    messagingSenderId: '993175523207',
    projectId: 'flutter-chat-learning-82a35',
    authDomain: 'flutter-chat-learning-82a35.firebaseapp.com',
    storageBucket: 'flutter-chat-learning-82a35.appspot.com',
    measurementId: 'G-S3VEPVQB4X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPWs_NCQkoEW98afofp92ZFdNhUQuKeKY',
    appId: '1:993175523207:android:7f052156ce77fe21a34d22',
    messagingSenderId: '993175523207',
    projectId: 'flutter-chat-learning-82a35',
    storageBucket: 'flutter-chat-learning-82a35.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUbLU8FCK8o82o0fjVAEPoLfbhrZUxJBY',
    appId: '1:993175523207:ios:76648787b9e77363a34d22',
    messagingSenderId: '993175523207',
    projectId: 'flutter-chat-learning-82a35',
    storageBucket: 'flutter-chat-learning-82a35.appspot.com',
    iosClientId: '993175523207-3i62h5soo163sgrhn5sr9c356146jtaa.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterchatbox',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUbLU8FCK8o82o0fjVAEPoLfbhrZUxJBY',
    appId: '1:993175523207:ios:76648787b9e77363a34d22',
    messagingSenderId: '993175523207',
    projectId: 'flutter-chat-learning-82a35',
    storageBucket: 'flutter-chat-learning-82a35.appspot.com',
    iosClientId: '993175523207-3i62h5soo163sgrhn5sr9c356146jtaa.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterchatbox',
  );
}