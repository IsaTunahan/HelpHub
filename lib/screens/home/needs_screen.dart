import 'package:bootcamp/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'maps.dart';
class NeedsScreen extends StatefulWidget {
  const NeedsScreen({super.key});

  @override
  _NeedsScreenState createState() => _NeedsScreenState();
}

class _NeedsScreenState extends State<NeedsScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  String? selectedCategory;
  String? selectedSubcategory;
    String? selectedCity;
  String? selectedDistrict;
  TextEditingController ihtiyacController = TextEditingController();
   TextEditingController addressController = TextEditingController();


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
        preferredSize: Size.fromHeight(screenHeight * 0.1),
        child: AppBar(
          backgroundColor: AppColors.lightGrey,
          elevation: 0,
          flexibleSpace: SizedBox(
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
              const Text(
                'Kategori Seçin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedCategory,
                hint: const Text('Kategori Seçin'),
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
                      style: const TextStyle(color: AppColors.darkGrey),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Alt Kategori Seçin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedSubcategory,
                hint: const Text('Alt Kategori Seçin'),
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
                            style: const TextStyle(color: AppColors.midGrey),
                          ),
                        );
                      }).toList()
                    : [],
              ),
              const SizedBox(height: 20),
            Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Şehir Seçin',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<String>(
                      value: selectedCity,
                      hint: const Text('Şehir Seçin'),
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCity = newValue;
                          selectedDistrict = null;
                        });
                      },
                      items: sehirler.map((city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(
                            city,
                            style: const TextStyle(color: AppColors.darkGrey),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'İlçe Seçin',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<String>(
                      value: selectedDistrict,
                      hint: const Text('İlçe Seçin'),
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          selectedDistrict = newValue;
                        });
                      },
                      items: ilceler[selectedCity] != null
                          ? ilceler[selectedCity]!.map((ilceler) {
                              return DropdownMenuItem<String>(
                                value: ilceler,
                                child: Text(
                                  ilceler,
                                  style: const TextStyle(color: AppColors.midGrey),
                                ),
                              );
                            }).toList()
                          : [],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
            const Text(
              'Adres',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: addressController,
              style: const TextStyle(color: AppColors.purple),
              decoration: const InputDecoration(
                hintText: 'Adresinizi Girin',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.purple),
                ),
              ),
              maxLines: null,
            ),
              const SizedBox(height: 20),
              const Text(
                'İhtiyacınızı Yazın',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: ihtiyacController,
                style: const TextStyle(color: AppColors.purple),
                decoration: const InputDecoration(
                  hintText: 'İhtiyacınızı Yazın',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.purple),
                  ),
                ),
                maxLines: null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String category = selectedCategory ?? '';
                  String subcategory = selectedSubcategory ?? '';
                  String ihtiyac = ihtiyacController.text;
                  String city = selectedCity ?? '';
                  String district = selectedDistrict ?? '';
                  String address = addressController.text;


                  print('Kategori: $category');
                  print('Alt Kategori: $subcategory');
                  print('İhtiyaç: $ihtiyac');
                  print('city: $city');
                  print('district: $district');
                  print('adres: $address');

                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                  CollectionReference ihtiyacs = firestore.collection('needs');

                  try {
                    await ihtiyacs.doc().set({
                      'İhtiyaç Sahibi': user.uid,
                      'anaKategori': category,
                      'Alt Kategori': subcategory,
                      'İhtiyaç': ihtiyac,
                      'city':selectedCity,
                      'district':selectedDistrict,
                      'address': address,
                      'createdAt': DateTime.now(),
                    });
                    print('Veri Firestore\'a başarıyla eklendi.');

                    ihtiyacController.clear();
                    addressController.clear();
                    setState(() {
                      selectedCategory = null;
                      selectedSubcategory = null;
                       selectedCity = null;
                      selectedDistrict = null;
                    });
                  } catch (e) {
                    print('Veri eklenirken bir hata oluştu: $e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                ),
                child: const Text(
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
