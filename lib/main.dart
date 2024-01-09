import 'package:consultant_app/firebase_options.dart';
import 'package:consultant_app/pages/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:consultant_app/pages/SplashScreen.dart';
import 'package:consultant_app/pages/WelcomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const SplashScreen(),
        "/welcome": (context) => const WelcomeScreen(),
        "/home": (context) => const HomeScreen(),
      },
    );
  }
}
