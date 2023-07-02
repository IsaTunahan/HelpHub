import 'package:bootcamp/style/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NeedsScreen extends StatefulWidget {
  const NeedsScreen();

  @override
  _NeedsScreenState createState() => _NeedsScreenState();
}

class _NeedsScreenState extends State<NeedsScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  String? selectedCategory;
  String? selectedSubcategory;
  TextEditingController ihtiyacController = TextEditingController();

  List<String> categories = [
    'Temel İhtiyaçlar ve Barınma',
    'Giyim',
    'Sağlık',
    'Eğitim',
    'İletişim ve Ulaşım',
    'Kişisel Bakım',
  ];

  Map<String, List<String>> subcategories = {
    'Temel İhtiyaçlar ve Barınma': [
      'Yiyecek',
      'Ev Kiralama',
      'Ev Eşyaları',
      'Ev Bakımı ve Onarımı',
      'Elektrik ve Su Faturaları',
      'Doğalgaz ve Isınma'
    ],
    'Giyim': ['Üst Giyim', 'Alt Giyim', 'Ayakkabı ve Aksesuarlar'],
    'Sağlık': [
      'İlaçlar',
      'Reçeteli İlaçlar',
      'Reçetesiz İlaçlar',
      'Hastane ve Klinik Ziyaretleri',
      'Sağlık Sigortası',
      'Diyet ve Beslenme'
    ],
    'Eğitim': [
      'Okul ve Kitap Ücretleri',
      'Eğitim Materyalleri',
      'Dershane ve Özel Ders',
      'Üniversite Harçları'
    ],
    'İletişim ve Ulaşım': ['Telefon Faturası'],
    'Kişisel Bakım': [
      'Kozmetik Ürünleri',
      'Diş ve Ağız Bakımı',
      'Kişisel Hijyen Ürünleri'
    ],
  };

  @override
  void dispose() {
    ihtiyacController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Kategori Seçin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedCategory,
                hint: Text('Kategori Seçin'),
                isExpanded: true,
                onChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue;
                    selectedSubcategory = null;
                  });
                },
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: TextStyle(color: AppColors.darkGrey),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                'Alt Kategori Seçin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedSubcategory,
                hint: Text('Alt Kategori Seçin'),
                isExpanded: true,
                onChanged: (newValue) {
                  setState(() {
                    selectedSubcategory = newValue;
                  });
                },
                items: selectedCategory != null
                    ? subcategories[selectedCategory!]!.map((subcategory) {
                        return DropdownMenuItem<String>(
                          value: subcategory,
                          child: Text(
                            subcategory,
                            style: TextStyle(color: AppColors.midGrey),
                          ),
                        );
                      }).toList()
                    : [],
              ),
              SizedBox(height: 20),
              Text(
                'İhtiyacınızı Yazın',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: ihtiyacController,
                style: TextStyle(color: AppColors.purple),
                decoration: InputDecoration(
                  hintText: 'İhtiyacınızı Yazın',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.purple),
                  ),
                ),
                maxLines: null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String category = selectedCategory ?? '';
                  String subcategory = selectedSubcategory ?? '';
                  String ihtiyac = ihtiyacController.text;
                  print('Kategori: $category');
                  print('Alt Kategori: $subcategory');
                  print('İhtiyaç: $ihtiyac');

                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                  CollectionReference ihtiyacs = firestore.collection('needs');

                  try {
                    await ihtiyacs.doc().set({
                      'İhtiyaç Sahibi': user.email,
                      'anaKategori': category,
                      'Alt Kategori': subcategory,
                      'İhtiyaç': ihtiyac,
                      'createdAt': DateTime.now(),
                    });
                    print('Veri Firestore\'a başarıyla eklendi.');

                    ihtiyacController.clear();
                    setState(() {
                      selectedCategory = null;
                      selectedSubcategory = null;
                    });
                  } catch (e) {
                    print('Veri eklenirken bir hata oluştu: $e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.purple,
                ),
                child: Text(
                  'Gönder',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
