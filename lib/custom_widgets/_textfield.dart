import 'package:bootcamp/style/colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const AppTextField(
      {super.key,
      this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(

        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: AppColors.orange,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: AppColors.green,
                ),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.darkGrey,
              )),
        ),
      ),
    );
  }
}
