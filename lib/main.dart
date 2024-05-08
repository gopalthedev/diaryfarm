import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'mainpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyDYMjqHQKNs7lhvVq7QpmkMWvg10R6agAA", appId: "1:484794436234:android:cd457dde41b420e11c7b73",
      messagingSenderId: "484794436234",
      projectId: "shelter-26398",storageBucket: "shelter-26398.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
