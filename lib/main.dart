import 'package:bootcamp/routes/routes.dart';
import 'package:bootcamp/screens/auth/auth/auth_screen.dart';
import 'package:bootcamp/screens/home/helps_screen.dart';
import 'package:bootcamp/screens/home/needs_screen.dart';
import 'package:bootcamp/screens/profile/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.home,
      routes: {
        Routes.help: (context) => const HelpsScreen(),
        Routes.need: (context) => const NeedsScreen(),
        Routes.profile: (context) => const ProfileScreen(),

      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme),
          primarySwatch: Colors.blue),
      home: const AuthScreen(),
    );
  }
}
