import 'package:flutter/material.dart';
import 'package:food_now/pages/sign_in_page.dart';
import 'package:food_now/pages/welcome_page.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: "Food Now",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const WelcomePage(),
      routes: {
        '/signIn':(context) => const SignIn(),
        //'/welcome' : (context) => const WelcomePage(),
      },
      );
  }
}
