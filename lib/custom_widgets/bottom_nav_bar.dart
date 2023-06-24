import 'package:bootcamp/screens/home/helps_screen.dart';
import 'package:bootcamp/screens/home/home_screen.dart';
import 'package:bootcamp/screens/home/needs_screen.dart';
import 'package:bootcamp/screens/profile/profile_screen.dart';
import 'package:bootcamp/style/colors.dart';
import 'package:bootcamp/style/icons/custom_icons.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const HelpsScreen(),
    const NeedsScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            height: 0,
            thickness: 3,
            color: AppColors.purple,
          ),
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
               BottomNavigationBarItem(
                icon: _selectedIndex == 0
                    ? const Icon(Icons.home)
                    : const Icon(Icons.home_outlined),
                label: 'Ana Sayfa',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.add_task_rounded),
                label: 'Yardım Et',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.add_task_rounded),
                label: 'İhtiyacım Var',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 3
                    ? CustomIcons.user
                    : CustomIcons.user_outlined,
                label: 'Profil',
              ),
            ],
            selectedItemColor: AppColors.purple,
            unselectedItemColor: AppColors.darkGrey,
            selectedFontSize: 17,
            unselectedFontSize: 14,
            selectedIconTheme: const IconThemeData(size: 32),
            unselectedIconTheme: const IconThemeData(size: 25),
            backgroundColor: Colors.grey.shade50,
            type: BottomNavigationBarType.fixed,
          ),
        ],
      ),
    );
  }
}
