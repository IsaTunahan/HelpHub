import 'package:bootcamp/style/icons/helphub_icons.dart';
import 'package:flutter/material.dart';

class NeedsScreen extends StatelessWidget {
  const NeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('İhtiyaçlar Sayfası'),
              Icon(Helphub.help,size: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
