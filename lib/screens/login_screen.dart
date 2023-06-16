import 'package:bootcamp/custom_widgets/_button.dart';
import 'package:bootcamp/custom_widgets/_textfield.dart';
import 'package:bootcamp/style/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.01,
            ),
            //Logo
            Image.asset(
              'assets/logos/logo.png',
              height: screenHeight * 0.3,
              width: screenWidth * 0.8,
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Stack(
              children: [
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.midGrey.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 15,
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  width: screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                          color: AppColors.orange,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      //Kullanıcı adı ve şifre
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                          color: Colors.grey.shade50,
                          //email
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              AppTextField(
                                controller: emailController,
                                hintText: 'Email',
                                obscureText: false,
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              //şifre
                              AppTextField(
                                controller: passwordController,
                                hintText: 'Şifre',
                                obscureText: true,
                              ),
                              SizedBox(
                                height: screenHeight * 0.005,
                              ),
                              //şifrenizi mi unuttunuz?
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.1,
                                ),
                                child: const SizedBox(
                                  height: 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Şifrenizi mi unuttunuz?',
                                        style: TextStyle(
                                          color: AppColors.darkGrey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.005,
                              ),
                              //giriş yap butonu
                              const GirisButton(
                                text: 'Giriş Yap',
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                color: AppColors.orange,
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
                                color: AppColors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //google ve apple ile giriş
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                          color: Colors.grey.shade50,
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              //google ile giriş
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.1,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppColors.green,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                  color: AppColors.green,
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Image.asset(
                                                'assets/logos/google.png',
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Google ile devam et',
                                                  style: TextStyle(
                                                    color: AppColors.midGrey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
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
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              //apple ile giriş
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.1,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppColors.green,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                  color: AppColors.green,
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Image.asset(
                                                'assets/logos/apple.png',
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Apple ile devam et',
                                                  style: TextStyle(
                                                    color: AppColors.midGrey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
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
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      //hesabın yok mu
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hesabın yok mu?",
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.darkGrey,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Kayıt ol",
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
