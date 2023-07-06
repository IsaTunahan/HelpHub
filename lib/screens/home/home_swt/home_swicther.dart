import 'package:bootcamp/screens/home/home_swt/home_help.dart';
import 'package:bootcamp/screens/home/home_swt/home_need.dart';
import 'package:bootcamp/screens/profile/profil_ihtiyaclar.dart';
import 'package:bootcamp/screens/profile/profil_yardimlar.dart';
import 'package:bootcamp/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CategorySwitcherWidget extends StatefulWidget {
  const CategorySwitcherWidget({super.key});

  @override
  _CategorySwitcherWidgetState createState() => _CategorySwitcherWidgetState();
}

class _CategorySwitcherWidgetState extends State<CategorySwitcherWidget> {
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth - (screenWidth - 20), vertical: 15),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: _selectedIndex == 1 ? AppColors.lightyellow : AppColors.lightpurple,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                        color: _selectedIndex == 0
                            ? AppColors.purple
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _selectedIndex == 0
                              ? Colors.transparent
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        'En Son İhtiyaçlar',
                        style: TextStyle(
                          color: _selectedIndex == 0
                              ? AppColors.white
                              : AppColors.purple,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selectedIndex == 1
                            ? Colors.yellow
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _selectedIndex == 0
                              ? Colors.grey.shade300
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5, horizontal: screenWidth * 0.02),
                        child: Text(
                          'En Son Yardımlar',
                          style: TextStyle(
                            color: _selectedIndex == 1
                                ? AppColors.white
                                : AppColors.lightyellow,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        IndexedStack(
          index: _selectedIndex,
          children: [
            HomeNeedScreen(),
            HomeHelpScreen(),
          ],
        ),
      ],
    );
  }
}
