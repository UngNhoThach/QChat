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
    apiKey: 'AIzaSyAvxMqUaAllDcuwnG7R69yNtkZUbuOrSmc',
    appId: '1:1089238207929:web:8203b6782cb029464c7a68',
    messagingSenderId: '1089238207929',
    projectId: 'qchat-2969a',
    authDomain: 'qchat-2969a.firebaseapp.com',
    storageBucket: 'qchat-2969a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDAemJ0Axd-r5-isE3cY6YJx3voNyY7iCw',
    appId: '1:1089238207929:android:5ee73f49e3b6261c4c7a68',
    messagingSenderId: '1089238207929',
    projectId: 'qchat-2969a',
    storageBucket: 'qchat-2969a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBVL2WYFgkIGYOahP-6XHZ87uTZmqBJrRg',
    appId: '1:1089238207929:ios:855a250fae10da5a4c7a68',
    messagingSenderId: '1089238207929',
    projectId: 'qchat-2969a',
    storageBucket: 'qchat-2969a.appspot.com',
    androidClientId: '1089238207929-1skmogf30sc6ndi2hcncs77vs3d1kkce.apps.googleusercontent.com',
    iosClientId: '1089238207929-15q1a5pjd9mve2i492l5fl2avei5kqvq.apps.googleusercontent.com',
    iosBundleId: 'com.example.qchat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBVL2WYFgkIGYOahP-6XHZ87uTZmqBJrRg',
    appId: '1:1089238207929:ios:855a250fae10da5a4c7a68',
    messagingSenderId: '1089238207929',
    projectId: 'qchat-2969a',
    storageBucket: 'qchat-2969a.appspot.com',
    androidClientId: '1089238207929-1skmogf30sc6ndi2hcncs77vs3d1kkce.apps.googleusercontent.com',
    iosClientId: '1089238207929-15q1a5pjd9mve2i492l5fl2avei5kqvq.apps.googleusercontent.com',
    iosBundleId: 'com.example.qchat',
  );
}
