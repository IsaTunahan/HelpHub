import 'package:bootcamp/screens/profile/prf_yrd_ihtc.dart';
import 'package:bootcamp/screens/profile/profil_ihtiyaclar.dart';
import 'package:bootcamp/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bootcamp/screens/profile/settings/settings_screen.dart';
import 'package:bootcamp/style/icons/helphub_icons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(color: AppColors.purple, fontSize: 40),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            );
          },
          child: const Icon(Helphub.settings, color: AppColors.purple, size: 35),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              color: Colors.grey.shade50,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.purple,
                                width: 2,
                              ),
                            ),
                            child: const CircleAvatar(
                              radius: 45,
                              backgroundImage: AssetImage('assets/profil/isa.jpg'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: AppColors.white,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Yapılan Yardım',
                                      style: TextStyle(
                                        color: AppColors.purple,
                                        fontSize: 25,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '12',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: AppColors.darkGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.displayName ?? '',
                              style: const TextStyle(
                                color: AppColors.darkGrey,
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '@${user.email!.split('@')[0]}',
                              style: const TextStyle(
                                color: AppColors.purple,
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const CategorySwitcherWidget()
        ],
      ),
    );
  }
}
