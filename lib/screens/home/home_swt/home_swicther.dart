
import 'package:bootcamp/screens/home/home_swt/home_help.dart';
import 'package:bootcamp/screens/home/home_swt/home_need.dart';
import 'package:flutter/material.dart';

import '../../../style/colors.dart';
class CategorySwitcherWidget extends StatefulWidget {
  const CategorySwitcherWidget({Key? key}) : super(key: key);

  @override
  _CategorySwitcherWidgetState createState() => _CategorySwitcherWidgetState();
}

class _CategorySwitcherWidgetState extends State<CategorySwitcherWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.grey.shade50,
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
                        'En Son Yardımlar',
                        style: TextStyle(
                          color: _selectedIndex == 0
                              ? AppColors.white
                              : AppColors.purple,
                          fontSize: 25,
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
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
                      child: Text(
                        'En Son İhtiyaçlar',
                        style: TextStyle(
                          color: _selectedIndex == 1
                              ? AppColors.white
                              : Colors.yellow,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              HomeHelpScreen(),
              HomeNeedScreen(),
            ],
          ),
        ),
      ],
    );
  }
}
