import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../style/colors.dart';
import 'home_swt/home_swicther.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  late CollectionReference<Map<String, dynamic>> collection;
  List<DocumentSnapshot<Map<String, dynamic>>> documents = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    collection = FirebaseFirestore.instance.collection('needs');
    fetchData();
  }

  Future<void> fetchData() async {
    Query<Map<String, dynamic>> query = collection;
  
    if (selectedCategory != null && selectedCategory != 'Tüm Kategoriler') {
      query = query.where('Ana Kategori', isEqualTo: selectedCategory);
    }

    query = query.orderBy('createdAt', descending: true);

   final querySnapshot = await query.get();

setState(() {
  documents = querySnapshot.docs.where((doc) => doc.data() != null).toList();
});

  }

  Future<String> getUsername(String userId) async {
  final userDoc =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();

  if (userDoc.exists) {
    final userData = userDoc.data() as Map<String, dynamic>;
    final firstName = userData['firstName'] ?? '';
    final lastName = userData['lastName'] ?? '';
    return '$firstName $lastName';
  } else {
    return '';
  }
}


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: AppBar(
          backgroundColor: AppColors.lightGrey,
          elevation: 0,
          flexibleSpace: Container(
            width: double.infinity,
            child: Image.asset(
              'assets/logos/HelpHub.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CategorySwitcherWidget(),
        ],
      ),
      
    );
  }
}
