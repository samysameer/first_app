import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfbid3Y77SpqqqzuGLvsZYM8JiQuT3k_E',
    appId: '1:48205090921:android:c71c940b55fcf55e8152f8',
    messagingSenderId: '48205090921',
    projectId: 'database-final-project-bccf0',
    storageBucket: 'database-final-project-bccf0.firebasestorage.app',
    databaseURL:
        'https://database-final-project-bccf0-default-rtdb.firebaseio.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
  );
}
