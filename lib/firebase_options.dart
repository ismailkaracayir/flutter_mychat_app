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
    apiKey: 'AIzaSyBivj1VyOAE70zIx-f2hx9klR8U4XJqqJ0',
    appId: '1:152767936828:web:79998a53bb003f15dc0639',
    messagingSenderId: '152767936828',
    projectId: 'flutter-chat-app-1d85f',
    authDomain: 'flutter-chat-app-1d85f.firebaseapp.com',
    storageBucket: 'flutter-chat-app-1d85f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4CzcUlxcPm-yuuH8MqpG4Pz17_zE7Lss',
    appId: '1:152767936828:android:e040c3204cb793fbdc0639',
    messagingSenderId: '152767936828',
    projectId: 'flutter-chat-app-1d85f',
    storageBucket: 'flutter-chat-app-1d85f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmv9MEFHb_QKnw9mEGXVUSpVejLLEvYds',
    appId: '1:152767936828:ios:768506fd024046f2dc0639',
    messagingSenderId: '152767936828',
    projectId: 'flutter-chat-app-1d85f',
    storageBucket: 'flutter-chat-app-1d85f.appspot.com',
    androidClientId: '152767936828-hq6u3joi82fn0j8373f0rtlm6uhuu5ot.apps.googleusercontent.com',
    iosClientId: '152767936828-ebkoa34lli5a8m27eqt3k2h61ho3nt6m.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterMychatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmv9MEFHb_QKnw9mEGXVUSpVejLLEvYds',
    appId: '1:152767936828:ios:768506fd024046f2dc0639',
    messagingSenderId: '152767936828',
    projectId: 'flutter-chat-app-1d85f',
    storageBucket: 'flutter-chat-app-1d85f.appspot.com',
    androidClientId: '152767936828-hq6u3joi82fn0j8373f0rtlm6uhuu5ot.apps.googleusercontent.com',
    iosClientId: '152767936828-ebkoa34lli5a8m27eqt3k2h61ho3nt6m.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterMychatApp',
  );
}