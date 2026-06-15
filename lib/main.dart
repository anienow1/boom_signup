import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:boom_signup/database/firebase_options.dart';
import 'package:boom_signup/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boom Signup',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.white)),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
