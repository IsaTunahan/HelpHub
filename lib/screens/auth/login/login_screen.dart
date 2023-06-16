import 'package:bootcamp/custom_widgets/_button.dart';
import 'package:bootcamp/custom_widgets/_textformfield.dart';
import 'package:bootcamp/screens/auth/forgot_pw_reset/forgot_pw_screen.dart';
import 'package:bootcamp/style/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback ShowRegisterScreen;
  const LoginScreen({super.key, required this.ShowRegisterScreen});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pop(context);
    } catch (e) {
      print('Hata: $e');
      Navigator.pop(context);
    }
  }

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
      body: SizedBox(
        height: screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              //Logo
              Image.asset(
                'assets/logos/logo.png',
                height: screenHeight * 0.2,
                width: screenWidth * 0.8,
              ),
              const SizedBox(
                height: 31,
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
                            offset: const Offset(0, -4),
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
                            color: AppColors.orange,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),

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
                                SizedBox(height: screenHeight * 0.02),
                                AppTextFormField(
                                  controller: emailController,
                                  hintText: 'Email',
                                  obscureText: false,
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                //şifre
                                AppTextFormField(
                                  controller: passwordController,
                                  hintText: 'Şifre',
                                  obscureText: true,
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                //şifrenizi mi unuttunuz?
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.05),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: ((context) {
                                                return const forgotPassword();
                                              }),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Şifrenizi mi unuttunuz?',
                                          style: TextStyle(
                                            color: AppColors.orange,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                //giriş yap butonu
                                GestureDetector(
                                  onTap: signIn,
                                  child: const GirisButton(
                                    text: 'Giriş Yap',
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
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
                                    horizontal: screenWidth * 0.05,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                padding:
                                                    const EdgeInsets.all(5),
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                    horizontal: screenWidth * 0.05,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                padding:
                                                    const EdgeInsets.all(5),
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                    color: AppColors.orange,
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
            ],
          ),
        ),
      ),
    );
  }
}
