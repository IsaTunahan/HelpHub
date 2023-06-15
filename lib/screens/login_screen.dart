import 'package:bootcamp/custom_widgets/_textfield.dart';
import 'package:bootcamp/style/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
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

                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
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
                      //email
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          AppTextField(
                            controller: emailcontroller,
                            hintText: 'Email',
                            obscureText: false,
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          //şifre
                          AppTextField(
                            controller: passwordcontroller,
                            hintText: 'Şifre',
                            obscureText: true,
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          //şifrenizi mi unuttunuz?
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: SizedBox(
                              height: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Şifenizi mi unuttunuz?',
                                    style: TextStyle(
                                        color: AppColors.darkGrey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
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
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
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
                    const SizedBox(
                      height: 25,
                    ),
                    //hesabın yok mu
                    const Row(
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
                          style:
                              TextStyle(fontSize: 20, color: AppColors.orange),
                        )
                      ],
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
