import 'package:bootcamp/screens/profile/prf_yrd_ihtc.dart';
import 'package:bootcamp/screens/profile/settings/settings_screen.dart';
import 'package:bootcamp/style/colors.dart';
import 'package:bootcamp/style/icons/helphub_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = '';
  String _firstName = '';
  String _lastName = '';
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: user!.email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final userData = querySnapshot.docs.first.data();
      setState(() {
        _username = userData['username'];
        _firstName = userData['firstName'];
        _lastName = userData['lastName'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
          child: const Icon(
            Helphub.settings,
            color: AppColors.purple,
            size: 35,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth - (screenWidth - 25),
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              color: Colors.grey.shade50,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.02,
                    vertical: screenHeight * 0.01,
                  ),
                  child: Row(
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
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage('assets/profile/user_profile.png'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$_firstName $_lastName',
                              style: const TextStyle(
                                color: AppColors.darkGrey,
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '@$_username',
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
          const CategorySwitcherWidget(),
        ],
      ),
    );
  }
}
