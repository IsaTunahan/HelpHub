import 'package:flutter/material.dart';
import 'package:flutter_application_2/bildirimler.dart';
import 'package:flutter_application_2/profile.dart';
import 'package:flutter_application_2/category.dart';
import 'package:flutter_application_2/main.dart';

class DestekOlPage extends StatefulWidget {
  @override
  _DestekOlPageState createState() => _DestekOlPageState();
}

class _DestekOlPageState extends State<DestekOlPage> {
  String? selectedCategory;
  String? selectedSubcategory;
  TextEditingController destekController = TextEditingController();

  List<String> categories = [
    'Kategori 1',
    'Kategori 2',
    'Kategori 3',
  ];

  Map<String, List<String>> subcategories = {
    'Kategori 1': ['Alt Kategori 1', 'Alt Kategori 2', 'Alt Kategori 3'],
    'Kategori 2': ['Alt Kategori A', 'Alt Kategori B', 'Alt Kategori C'],
    'Kategori 3': ['Alt Kategori X', 'Alt Kategori Y', 'Alt Kategori Z'],
  };

  @override
  void dispose() {
    destekController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Destek Ol'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
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
                  child: Text(category),
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
                        child: Text(subcategory),
                      );
                    }).toList()
                  : [],
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
              decoration: InputDecoration(
                hintText: 'Ne konuda destek olabilirsin?',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String category = selectedCategory ?? '';
                String subcategory = selectedSubcategory ?? '';
                String destek = destekController.text;
                print('Kategori: $category');
                print('Alt Kategori: $subcategory');
                print('Destek Konusu: $destek');
              },
              child: Text('Destek Ol'),
            ),
          ],
        ),
      ),
       bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.category),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.post_add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BildirimlerPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
