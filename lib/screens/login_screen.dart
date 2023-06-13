import 'package:bootcamp/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),

            //Logo
            Image.asset(
              'assets/logos/logo.png',
              height: 150,
              width: 380,
            ),

            const SizedBox(
              height: 40,
            ),

            Stack(children: [
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
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    //Giriş Yap
                    const Text(
                      "Giriş Yap",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orange),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //Kullanıcı adı ve şifre
                    Container(
                      width: MediaQuery.of(context).size.width - 75,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.midGrey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),

                    // ya da
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: AppColors.orange,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "ya da",
                              style: TextStyle(color: AppColors.midGrey),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: AppColors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //google ve apple ile giriş
                    Container(
                      width: MediaQuery.of(context).size.width - 75,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.midGrey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),

                    //hesabın yok mu
                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hesabın yok mu ?",
                            style: TextStyle(
                                fontSize: 20, color: AppColors.darkGrey),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Kayıt ol",
                            style: TextStyle(
                                fontSize: 20, color: AppColors.orange),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
