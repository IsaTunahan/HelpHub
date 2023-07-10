import 'package:bootcamp/screens/profile/profil_ihtiyaclar.dart';
import 'package:bootcamp/screens/profile/profil_yardimlar.dart';
import 'package:bootcamp/style/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CategorySwitcherWidget extends StatefulWidget {
  const CategorySwitcherWidget({Key? key}) : super(key: key);

  @override
  _CategorySwitcherWidgetState createState() => _CategorySwitcherWidgetState();
}

class _CategorySwitcherWidgetState extends State<CategorySwitcherWidget> {
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Expanded(
      child: Column(
        children: [
          Container(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Container(
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5, horizontal: screenWidth * 0.02),
                          child: Text(
                            'Yardımlarım',
                            style: TextStyle(
                              color: _selectedIndex == 0
                                  ? AppColors.white
                                  : AppColors.purple,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3),
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
                            'İhtiyaçlarım',
                            style: TextStyle(
                              color: _selectedIndex == 1
                                  ? AppColors.white
                                  : Colors.yellow,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                ProfilYardimlar(currentUserEmail: user.uid),
                ProfilIhtiyaclar(currentUserEmail: user.uid),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
