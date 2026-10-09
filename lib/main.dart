import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reclaim/firebase_options.dart';
import 'package:reclaim/Pages/home_page.dart';

void main() async {
  // connect to firebase before the app starts
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reclaim',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0)),
      ),
      home: const HomePage(),
    );
  }
}