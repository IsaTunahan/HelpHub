import 'package:bootcamp/screens/auth/login/login_bolumleri/login_form.dart';
import 'package:bootcamp/screens/auth/login/login_bolumleri/login_google_apple.dart';
import 'package:bootcamp/style/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback ShowRegisterScreen;
  const LoginScreen({super.key, required this.ShowRegisterScreen});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Stack(children: [
            Positioned(
              bottom: screenHeight - (screenHeight - 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  //Logo
                  Image.asset(
                    'assets/logos/HelpHub.png',
                    height: screenHeight * 0.2,
                    width: screenWidth * 0.8,
                  ),
                  const SizedBox(
                    height: 51,
                  ),

                  Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey1.withOpacity(0.4),
                              spreadRadius: 4,
                              blurRadius: 15,
                              offset: const Offset(0, -4),
                            ),
                          ],
                        ),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          width: screenWidth,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              //Giriş Yap
                              const Text(
                                "Giriş Yap",
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.purple,
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                  
                              const LoginForm(),
                  
                              // ya da
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.02,
                                  horizontal: screenWidth * 0.04,
                                ),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Divider(
                                        thickness: 2,
                                        color: AppColors.purple,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.02,
                                      ),
                                      child: const Text(
                                        "ya da",
                                        style: TextStyle(
                                          color: AppColors.darkGrey,
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      child: Divider(
                                        thickness: 2,
                                        color: AppColors.purple,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                  
                              //google ve apple ile giriş
                              const LGoogleApple(),
                  
                              SizedBox(
                                height: screenHeight * 0.025,
                              ),
                              //hesabın yok mu
                              Container(
                                width: screenWidth,
                                color: AppColors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Hesabınız yok mu?",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.darkGrey,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    GestureDetector(
                                      onTap: widget.ShowRegisterScreen,
                                      child: const Text(
                                        "Kayıt ol",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: AppColors.purple,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
