// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAigV3a_i_c7srmM51X05XL5vAKdeS53lc',
    appId: '1:106272095361:web:af7e3e8477972ef899a180',
    messagingSenderId: '106272095361',
    projectId: 'nantap-6ca4a',
    authDomain: 'nantap-6ca4a.firebaseapp.com',
    storageBucket: 'nantap-6ca4a.appspot.com',
    measurementId: 'G-LRWWZXLC2X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArDlaAmQ5sNA953La9kZE81x-_FzXg2sI',
    appId: '1:106272095361:android:de5302114a9b900f99a180',
    messagingSenderId: '106272095361',
    projectId: 'nantap-6ca4a',
    storageBucket: 'nantap-6ca4a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9BsBebf4jPurpq1jWPJ-QfDmP7ITifHI',
    appId: '1:106272095361:ios:88181bd23fa9b2f599a180',
    messagingSenderId: '106272095361',
    projectId: 'nantap-6ca4a',
    storageBucket: 'nantap-6ca4a.appspot.com',
    iosBundleId: 'com.nantap.nantap',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC9BsBebf4jPurpq1jWPJ-QfDmP7ITifHI',
    appId: '1:106272095361:ios:88181bd23fa9b2f599a180',
    messagingSenderId: '106272095361',
    projectId: 'nantap-6ca4a',
    storageBucket: 'nantap-6ca4a.appspot.com',
    iosBundleId: 'com.nantap.nantap',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAigV3a_i_c7srmM51X05XL5vAKdeS53lc',
    appId: '1:106272095361:web:2737dc96b9b2341799a180',
    messagingSenderId: '106272095361',
    projectId: 'nantap-6ca4a',
    authDomain: 'nantap-6ca4a.firebaseapp.com',
    storageBucket: 'nantap-6ca4a.appspot.com',
    measurementId: 'G-0RYGKXYPD2',
  );
}
