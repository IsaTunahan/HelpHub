import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),

              //Logo
              Image.asset(
                'assets/logos/logo.png',
                height: 150,
                width: 380,
              ),
              Container(
                color: Colors.red,
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  children: [
                    TextField( decoration: InputDecoration(hintText: "Kullanıcı adı"),)
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
