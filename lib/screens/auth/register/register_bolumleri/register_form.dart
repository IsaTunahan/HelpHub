import 'package:bootcamp/custom_widgets/alert.dart';
import 'package:bootcamp/style/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../custom_widgets/_textformfield.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key,});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

  Future<void> signUp() async {
    if (passwordConfirmed()) {
      setState(() {
        isLoading = true;
      });

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Bilinmeyen bir hata oluştu';

        if (e.code == 'invalid-email') {
          errorMessage = 'Geçersiz e-posta formatı.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'Bu e-posta adresi zaten kullanımda.';
        } else if (e.code == 'weak-password') {
          errorMessage = 'Şifre çok zayıf. Daha güçlü bir şifre deneyin.';
        }

        showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(title: 'Hata', message: errorMessage);
          },
        );
      } catch (e) {
        print('Hata: $e');
        showDialog(
          context: context,
          builder: (context) {
            return const ErrorDialog(
              title: 'Hata',
              message: 'Bilinmeyen bir hata oluştu',
            );
          },
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmPasswordController.text.trim()) {
      return true;
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Hata'),
            content: const Text('Şifreler uyuşmuyor.'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        color: Colors.grey.shade50,
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            AppTextFormField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            SizedBox(height: screenHeight * 0.01),
            AppTextFormField(
              controller: passwordController,
              hintText: 'Şifre',
              obscureText: true,
            ),
            SizedBox(height: screenHeight * 0.01),
            AppTextFormField(
              controller: confirmPasswordController,
              hintText: 'Şifreyi Doğrula',
              obscureText: true,
            ),
            SizedBox(height: screenHeight * 0.01),
            GestureDetector(
              onTap: isLoading ? null : signUp,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: isLoading ? AppColors.purple : AppColors.purple,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        )
                      : const Text(
                          'Giriş Yap',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
