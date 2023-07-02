import 'package:bootcamp/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ProfilIhtiyaclar extends StatefulWidget {
  final String currentUserEmail;

  const ProfilIhtiyaclar({Key? key, required this.currentUserEmail}) : super(key: key);

  @override
  State<ProfilIhtiyaclar> createState() => _ProfilIhtiyaclarState();
}
class _ProfilIhtiyaclarState extends State<ProfilIhtiyaclar> {
  late CollectionReference<Map<String, dynamic>> collection;
  List<DocumentSnapshot<Map<String, dynamic>>> documents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    collection = FirebaseFirestore.instance.collection('needs');
    fetchData();
  }

  Future<void> fetchData() async {
    final querySnapshot = await collection.where('İhtiyaç Sahibi', isEqualTo: widget.currentUserEmail).get();

    setState(() {
      documents = querySnapshot.docs;
      isLoading = false;
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
                'İhtiyaçlarım',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : documents.isEmpty
                    ? const Center(
                        child: Text(
                          'Daha önce ihtiyaç girmediniz...',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final data = documents[index].data() as Map<String, dynamic>;
                          final anakategori = data['anaKategori'];
                          final altkategori = data['Alt Kategori'];
                          final ihtiyac = data['İhtiyaç'];

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
          ],
        ),
      ),
    );
  }
}
