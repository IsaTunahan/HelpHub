import 'package:bootcamp/style/colors.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppColors.purple,
            fontSize: 40,
          ),
        ),
        elevation: 0,

      ),
    );
  }
}
