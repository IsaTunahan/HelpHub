import 'dart:io';

import 'package:bootcamp/style/colors.dart';
import 'package:bootcamp/style/icons/helphub_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../repository/user_repository/user_repository.dart';

class ProfilBilgileri extends StatefulWidget {
  const ProfilBilgileri({Key? key}) : super(key: key);

  @override
  State<ProfilBilgileri> createState() => _ProfilBilgileriState();
}

class _ProfilBilgileriState extends State<ProfilBilgileri> {
  String _profileImageURL = 'assets/profile/user_profile.png';

  String _username = '';
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phone = '';

  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userRepository = UserRepository();
      final userData = await userRepository.getUserData(userId);

      if (userData != null) {
        setState(() {
          _username = userData.username;
          _firstName = userData.firstName;
          _lastName = userData.lastName;
          _email = userData.email;
          _phone = userData.phone.toString();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

Future<void> _updateProfileImage(ImageSource source) async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: source);

  if (pickedImage != null) {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    String filePath = 'profil_resimleri/$userID/profil.png';

    try {
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(filePath);
      firebase_storage.UploadTask uploadTask = ref.putFile(
        File(pickedImage.path),
        firebase_storage.SettableMetadata(
          contentType: 'image/png',
        ),
      );

      firebase_storage.TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();

      setState(() {
        _profileImageURL = downloadURL;
      });

      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'profil_resim_url': downloadURL});
      }
    } catch (error) {
      print('Firebase Storage Hatası: $error');
    }
  }
}



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth - (screenWidth - 25),
        vertical: 25,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        color: Colors.grey.shade50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Profil Bilgileri',
                style: TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.purple,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage(_profileImageURL),
                  radius: 25,
                ),
              ),
              title: const Text(
                'Profil Resmi',
                style: TextStyle(color: AppColors.darkGrey),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.purple,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Profil Resmini Güncelle'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              GestureDetector(
                                child: const Text('Kamera'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _updateProfileImage(ImageSource.camera);
                                },
                              ),
                              const Padding(padding: EdgeInsets.all(8.0)),
                              GestureDetector(
                                child: const Text('Galeri'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _updateProfileImage(ImageSource.gallery);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            ListTile(
              leading: const Icon(
                Helphub.user_outline,
                color: AppColors.purple,
              ),
              title: const Text(
                'Kullanıcı Adı',
                style: TextStyle(color: AppColors.darkGrey),
              ),
              subtitle: Text(
                _username,
                style: const TextStyle(color: AppColors.grey3),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.purple,
                ),
                onPressed: () {},
              ),
            ),
            ListTile(
              leading: const Icon(
                Helphub.user,
                color: AppColors.purple,
              ),
              title: const Text(
                'İsim',
                style: TextStyle(color: AppColors.darkGrey),
              ),
              subtitle: Text(
                _firstName,
                style: const TextStyle(color: AppColors.grey3),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.purple,
                ),
                onPressed: () {},
              ),
            ),
            ListTile(
              leading: const Icon(
                Helphub.user,
                color: AppColors.purple,
              ),
              title: const Text(
                'Soyisim',
                style: TextStyle(color: AppColors.darkGrey),
              ),
              subtitle: Text(
                _lastName,
                style: const TextStyle(color: AppColors.grey3),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.purple,
                ),
                onPressed: () {},
              ),
            ),
            ListTile(
              leading: const Icon(
                Helphub.mail,
                color: AppColors.purple,
              ),
              title: const Text(
                'E-posta Adresi',
                style: TextStyle(color: AppColors.darkGrey),
              ),
              subtitle: Text(
                _email,
                style: const TextStyle(color: AppColors.grey3),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.purple,
                ),
                onPressed: () {},
              ),
            ),
            ListTile(
              leading: const Icon(
                Helphub.phone,
                color: AppColors.purple,
              ),
              title: const Text(
                'Telefon Numarası',
                style: TextStyle(color: AppColors.darkGrey),
              ),
              subtitle: Text(
                _phone,
                style: const TextStyle(color: AppColors.grey3),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.purple,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
