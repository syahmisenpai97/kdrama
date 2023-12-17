import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kdrama_app/firebase_options.dart';
import 'package:kdrama_app/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCWJODeWxO9BalhQ_6DE-95hNAJXjv3TCI',
    appId: '1:547851937997:android:dbb4446fa12d0851786184',
    messagingSenderId: '547851937997',
    projectId: 'kissasian-sam',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
