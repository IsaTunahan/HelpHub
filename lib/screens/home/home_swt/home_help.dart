import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeHelpScreen extends StatefulWidget {
  const HomeHelpScreen({Key? key}) : super(key: key);

  @override
  State<HomeHelpScreen> createState() => _HomeHelpScreenState();
}

class _HomeHelpScreenState extends State<HomeHelpScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  late CollectionReference<Map<String, dynamic>> collection;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = [];
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    collection = FirebaseFirestore.instance.collection('helps');
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
    final userQuerySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: userId)
        .get();

    if (userQuerySnapshot.docs.isNotEmpty) {
      final userData = userQuerySnapshot.docs[0].data();
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
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (documents.isEmpty)
              const Center(
                child: Text(
                  'Şu anda gösterilebilecek bir ihtiyaç bulunmuyor...',
                  style: TextStyle(fontSize: 16),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final data = documents[index].data();
                  final anakategori = data['Ana Kategori'];
                  final altkategori = data['Alt Kategori'];
                  final destek = data['Destek'];
                  final birim = data['Birim'];
                  final miktar = data['Miktar'];
                  final desteksahibiId = data['Destek Sahibi'];
                  final il = data['city'];
                  final ilce = data['district'];

                  return FutureBuilder<String>(
                    future: getUsername(desteksahibiId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox.shrink();
                      }
                      if (snapshot.hasError) {
                        return Text('Hata oluştu: ${snapshot.error}');
                      }
                      final desteksahibiAdSoyad = snapshot.data ?? '';

                      return Card(
                        elevation: 5,
                        color: Colors.grey.shade50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                desteksahibiAdSoyad,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                miktar +' '+ birim +' ' +destek ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                anakategori ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '$ilce, $il' ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
