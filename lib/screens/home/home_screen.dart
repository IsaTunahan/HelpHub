import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../style/colors.dart';

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
      documents = querySnapshot.docs;
    });
  }

  Future<void> addNeed(String category, String subcategory, String need) async {
    await collection.add({
      'İhtiyaç Sahibi': user.email,
      'Ana Kategori': category,
      'Alt Kategori': subcategory,
      'İhtiyaç': need,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.2),
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
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'En Son Eklenen İhtiyaçlar (${selectedCategory ?? 'Tüm Kategoriler'})',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: screenWidth,
              child: DropdownButton<String>(
                value: selectedCategory,
                hint: const Text('Kategori Seç'),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                    fetchData();
                  });
                },
                items: <String>[
                  'Tüm Kategoriler',
                  'Temel İhtiyaçlar ve Barınma',
                  'Giyim',
                  'Sağlık',
                  'Eğitim',
                  'İletişim ve Ulaşım',
                  'Kişisel Bakım',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: documents.isEmpty
                ? const Center(
                    child: Text(
                      'Şu anda gösterilebilecek bir ihtiyaç bulunmuyor...',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final data =
                          documents[index].data() as Map<String, dynamic>;
                      final anakategori = data['anaKategori'];
                      final altkategori = data['Alt Kategori'];
                      final ihtiyac = data['İhtiyaç'];
                      final ihtiyacsahibimail = data['İhtiyaç Sahibi'];

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
                                ihtiyacsahibimail ?? '',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                anakategori ?? '',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                altkategori ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                ihtiyac ?? '',
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
                  ),
          ),
        ],
      ),
    );
  }
}
