import 'package:bootcamp/style/colors.dart';
import 'package:flutter/material.dart';

class GirisButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const GirisButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
