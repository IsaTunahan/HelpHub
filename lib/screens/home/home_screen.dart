import 'package:bootcamp/style/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Giriş yapıldı: ${user.email!}'),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text('Çıkış Yap'),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Hata',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            const Text(
                              'Bilinmeyen bir hata oluştu',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.purple),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Tamam'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text('Alert'),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      color: AppColors.purple,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      color: AppColors.lightpurple,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      color: AppColors.yellow,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      color: AppColors.lightyellow,
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      color: AppColors.grey1,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      color: AppColors.grey2,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      color: AppColors.grey3,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
