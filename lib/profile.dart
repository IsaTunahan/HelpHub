import 'package:flutter/material.dart';
import 'package:flutter_application_2/bildirimler.dart';
import 'package:flutter_application_2/category.dart';
import 'package:flutter_application_2/main.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'John';
  String surname = 'Doe';
  String email = 'johndoe@example.com';
  String phone = '1234567890';
  String address = '123 Street, City';
  String district = 'District';
  String city = 'City';
  String profileImageUrl =
      'https://example.com/profile_image.jpg'; 
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = name;
    surnameController.text = surname;
    emailController.text = email;
    phoneController.text = phone;
    addressController.text = address;
    districtController.text = district;
    cityController.text = city;
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    districtController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void updateProfile() {
    setState(() {
      name = nameController.text;
      surname = surnameController.text;
      email = emailController.text;
      phone = phoneController.text;
      address = addressController.text;
      district = districtController.text;
      city = cityController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profileImageUrl),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'İsim:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'İsim',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Soyisim:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: surnameController,
                decoration: InputDecoration(
                  hintText: 'Soyisim',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'E-posta:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'E-posta',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Telefon:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: 'Telefon',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Adres:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: 'Adres',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'İlçe:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: districtController,
                decoration: InputDecoration(
                  hintText: 'İlçe',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'İl:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: cityController,
                decoration: InputDecoration(
                  hintText: 'İl',
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: updateProfile,
                  child: Text('Profil Güncelle'),
                ),
              ),
              SizedBox(height: 16),
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
