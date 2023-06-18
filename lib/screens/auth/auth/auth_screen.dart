import 'dart:async';

import 'package:bootcamp/screens/auth/login_or_register/login_or_register_screen.dart';
import 'package:bootcamp/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../splash/splash_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _showSplash = true; // SplashScreen'ın gösterilip gösterilmeyeceğini belirlemek için bir değişken

  @override
  void initState() {
    super.initState();
    // 2 saniye sonra _showSplash değerini false yaparak SplashScreen'ı kaldırıyoruz
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (_showSplash) {

            return const SplashScreen(); 
          } else {
            if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const LoginOrRegisterScreen();
            }
          }
        },
      ),
    );
  }
}
