// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    apiKey: 'AIzaSyCg9iJmFaPKMWk_8qHPU45c9n9e14eTrME',
    appId: '1:1012277701471:web:4468f0e2b1be1b178c24ea',
    messagingSenderId: '1012277701471',
    projectId: 'flutter-todo-db-b81d9',
    authDomain: 'flutter-todo-db-b81d9.firebaseapp.com',
    storageBucket: 'flutter-todo-db-b81d9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQg8UVGjNSkHSQGSSmSEW320H13rY0VNI',
    appId: '1:1012277701471:android:90e0c57e0dea58768c24ea',
    messagingSenderId: '1012277701471',
    projectId: 'flutter-todo-db-b81d9',
    storageBucket: 'flutter-todo-db-b81d9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4bPzfqkp0stDpPst8k0SPL7oeANrdGIA',
    appId: '1:1012277701471:ios:6c70f699fa504e0b8c24ea',
    messagingSenderId: '1012277701471',
    projectId: 'flutter-todo-db-b81d9',
    storageBucket: 'flutter-todo-db-b81d9.appspot.com',
    iosClientId: '1012277701471-1ipgo24umpucb1v25dcc6mhi3o4vp6d8.apps.googleusercontent.com',
    iosBundleId: 'com.todo-ios.app',
  );
}
