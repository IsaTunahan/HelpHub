import 'package:bootcamp/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilYardimlar extends StatefulWidget {
  final String currentUserEmail;

  const ProfilYardimlar({Key? key, required this.currentUserEmail}) : super(key: key);

  @override
  State<ProfilYardimlar> createState() => _ProfilYardimlarState();
}

class _ProfilYardimlarState extends State<ProfilYardimlar> {
  late CollectionReference<Map<String, dynamic>> collection;
  List<DocumentSnapshot<Map<String, dynamic>>> documents = [];

  @override
  void initState() {
    super.initState();
    collection = FirebaseFirestore.instance.collection('helps');
    fetchData();
  }

  Future<void> fetchData() async {
    final querySnapshot = await collection.where('Destek Sahibi', isEqualTo: widget.currentUserEmail).get();

    setState(() {
      documents = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Yardımlarım',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            documents.isEmpty
                    ? const Center(
                        child: Text(
                          'Daha önce yardım girmediniz...',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final data = documents[index].data() as Map<String, dynamic>;
                      final anakategori = data['Ana Kategori'];
                      final altkategori = data['Alt Kategori'];
                      final birim = data['Birim'];
                      final destek = data['Destek'];
                      final miktar = data['Miktar'];


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
                                widget.currentUserEmail,
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
                                "$miktar $birim $destek" ,
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
          ],
        ),
      ),
    );
  }
}