import 'package:bootcamp/screens/auth/login/login_screen.dart';
import 'package:bootcamp/screens/auth/register/registers_screen.dart';
import 'package:flutter/material.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  bool showLoginPage = true;

  void toogleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(ShowRegisterScreen: toogleScreens);
    } else {
      return RegisterScreen(ShowLoginScreen: toogleScreens);
    }
  }
}
