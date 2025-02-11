import 'package:firebase_core/firebase_core.dart';

FirebaseOptions defaultFirebaseOption() {
  return const FirebaseOptions(
    apiKey: 'AIzaSyBxXFOY0WxcDkXHXXXXXXXXXXXXXXXXXXX',  // Replace with your Firebase API key
    appId: '1:123456789012:ios:abcdef1234567890',       // Replace with your Firebase App ID
    messagingSenderId: '123456789012',                   // Replace with your Firebase Messaging Sender ID
    projectId: 'your-project-id',                        // Replace with your Firebase Project ID
    storageBucket: 'your-project-id.appspot.com',       // Replace with your Firebase Storage Bucket
  );
} 