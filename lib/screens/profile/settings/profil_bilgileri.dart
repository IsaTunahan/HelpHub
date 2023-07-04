import 'dart:io';

import 'package:bootcamp/style/colors.dart';
import 'package:bootcamp/style/icons/helphub_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../repository/user_repository/user_repository.dart';

class ProfilBilgileri extends StatefulWidget {
  const ProfilBilgileri({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilBilgileri> createState() => _ProfilBilgileriState();
}

class _ProfilBilgileriState extends State<ProfilBilgileri> {
  String _username = '';
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phone = '';
  File? _image;
  String? _profileImageURL;

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

  Future<void> _fetchProfileImageURL() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    final userRef = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
    final userSnapshot = await userRef.get();

    if (userSnapshot.exists) {
      final userData = userSnapshot.data();
      final profileImageRef = FirebaseStorage.instance.ref().child('Profil_resimleri/${currentUser.uid}');
      final profileImageURL = await profileImageRef.getDownloadURL();

      setState(() {
        _profileImageURL = profileImageURL;
      });
    }
  }
}


  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _fetchProfileImageURL();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      await _uploadProfileImage();
    }
  }

  Future<void> _uploadProfileImage() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final storage = FirebaseStorage.instance;
        final storageRef = storage.ref();

        final imageRef =
            storageRef.child('Profil_resimleri/${currentUser.uid}');
        final uploadTask = imageRef.putFile(_image!);

        final snapshot = await uploadTask.whenComplete(() {});
        final downloadURL = await snapshot.ref.getDownloadURL();

        setState(() {
          _profileImageURL = downloadURL;
        });

        await _updateUserData();
      }
    } catch (e) {
      print('Hata: $e');
    }
  }

  Future<void> _updateUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userRef =
            FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
        await userRef.update({'profileImageURL': _profileImageURL});
      }
    } catch (e) {
      print('Hata: $e');
    }
  }

  Future<void> showImageSourceDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Profil Resmi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Row(
                    children: [
                      Icon(Helphub.image, color: AppColors.purple),
                      SizedBox(width: 10),
                      Text('Galeri'),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  child: const Row(
                    children: [
                      Icon(Helphub.camera, color: AppColors.purple),
                      SizedBox(width: 10),
                      Text('Kamera'),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
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
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.purple,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade50,
                        backgroundImage: _profileImageURL != null
                            ? NetworkImage(_profileImageURL!)
                            : const AssetImage(
                                    'assets/profile/user_profile.png')
                                as ImageProvider<Object>?,
                        radius: 40,
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 45,
                      child: Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade50,
                        ),
                        child: IconButton(
                          iconSize: 22,
                          icon: const Icon(
                            Helphub.image,
                            color: AppColors.purple,
                          ),
                          onPressed: () {
                            showImageSourceDialog();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
