import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bootcamp/style/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'maps.dart';

class HelpsScreen extends StatefulWidget {
  const HelpsScreen();

  @override
  _HelpsScreenState createState() => _HelpsScreenState();
}

class _HelpsScreenState extends State<HelpsScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  String? selectedCategory;
  String? selectedSubcategory;
  String? selectedUnit;
  String? selectedCity;
  String? selectedDistrict;

  TextEditingController destekController = TextEditingController();
  TextEditingController miktarController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    destekController.dispose();
    miktarController.dispose();
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Şehir Seçin',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButton<String>(
                    value: selectedCity,
                    hint: Text('Şehir Seçin'),
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
                          style: TextStyle(color: AppColors.darkGrey),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'İlçe Seçin',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButton<String>(
                    value: selectedDistrict,
                    hint: Text('İlçe Seçin'),
                    isExpanded: true,
                    onChanged: (newValue) {
                      setState(() {
                        selectedDistrict = newValue;
                      });
                    },
                    items: ilceler != null && ilceler[selectedCity] != null
                        ? ilceler[selectedCity]!.map((ilceler) {
                            return DropdownMenuItem<String>(
                              value: ilceler,
                              child: Text(
                                ilceler,
                                style: TextStyle(color: AppColors.midGrey),
                              ),
                            );
                          }).toList()
                        : [],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Adres',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: addressController,
                style: TextStyle(color: AppColors.purple),
                decoration: InputDecoration(
                  hintText: 'Adresinizi Girin',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.purple),
                  ),
                ),
                maxLines: null,
              ),
              SizedBox(height: 20),
              Text(
                'Birim',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedUnit,
                hint: Text('Birim Seçin'),
                isExpanded: true,
                onChanged: (newValue) {
                  setState(() {
                    selectedUnit = newValue;
                  });
                },
                items: units.map((unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                'Miktar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: miktarController,
                style: TextStyle(color: AppColors.purple),
                decoration: InputDecoration(
                  hintText: 'Miktar Girin',
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.purple),
                  ),
                ),
                maxLines: null,
              ),
              SizedBox(height: 20),
              Text(
                'Ne Konuda Destek Olabilirsin?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: destekController,
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
                  String unit = selectedUnit ?? '';
                  String destek = destekController.text;
                  String miktar = miktarController.text;
                  String city = selectedCity ?? '';
                  String district = selectedDistrict ?? '';
                  String address = addressController.text;
                  print('Kategori: $category');
                  print('Alt Kategori: $subcategory');
                  print('city: $city');
                  print('district: $district');
                  print('adres: $address');
                  print('Birim: $unit');
                  print('Destek: $destek');
                  print('Miktar: $miktar');

                  FirebaseFirestore firestore = FirebaseFirestore.instance;
                  CollectionReference destekler = firestore.collection('helps');

                  try {
                    await destekler.add({
                      'Destek Sahibi': user.uid,
                      'Ana Kategori': category,
                      'Alt Kategori': subcategory,
                      'city': selectedCity,
                      'district': selectedDistrict,
                      'address': address,
                      'createdAt': DateTime.now(),
                      'Birim': unit,
                      'Miktar': miktar,
                      'Destek': destek,
                    });
                    print('Veri Firestore\'a başarıyla eklendi.');
                    destekController.clear();
                    miktarController.clear();
                    addressController.clear;
                    
                    setState(() {
                      selectedCategory = null;
                      selectedSubcategory = null;
                      selectedUnit = null;
                      selectedCity = null;
                      selectedDistrict = null;
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
