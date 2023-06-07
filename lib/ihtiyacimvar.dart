import 'package:flutter/material.dart';
import 'package:flutter_application_2/bildirimler.dart';
import 'package:flutter_application_2/profile.dart';
import 'package:flutter_application_2/category.dart';
import 'package:flutter_application_2/main.dart';

class IhtiyacimVarPage extends StatefulWidget {
  @override
  _IhtiyacimVarPageState createState() => _IhtiyacimVarPageState();
}

class _IhtiyacimVarPageState extends State<IhtiyacimVarPage> {
  String? selectedCategory;
  String? selectedSubcategory;
  TextEditingController ihtiyacController = TextEditingController();

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
    ihtiyacController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İhtiyacım Var'),
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
                'İhtiyacınızı Yazın',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: ihtiyacController,
                decoration: InputDecoration(
                  hintText: 'İhtiyacınızı Yazın',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String category = selectedCategory ?? '';
                  String subcategory = selectedSubcategory ?? '';
                  String ihtiyac = ihtiyacController.text;
                  print('Kategori: $category');
                  print('Alt Kategori: $subcategory');
                  print('İhtiyaç: $ihtiyac');
                },
                child: Text('Gönder'),
              ),
            ],
          ),
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
