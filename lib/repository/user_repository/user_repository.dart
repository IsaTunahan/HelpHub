import 'dart:io';

import 'package:bootcamp/screens/auth/auth/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUserData(String userId) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('userId', isEqualTo: userId)
      .limit(1)
      .get();

  if (snapshot.docs.isNotEmpty) {
    DocumentSnapshot documentSnapshot = snapshot.docs.first;
    UserModel user = UserModel.fromSnapshot(documentSnapshot);
    return user;
  } else {
    return null;
  }
}

Future<String> uploadProfileImage(String uid, File imageFile) async {
  try {
    // Firebase Storage referansını alın
    final Reference storageRef = FirebaseStorage.instance.ref().child('profile_images').child(uid);

    // Resmi yükleyin
    final UploadTask uploadTask = storageRef.putFile(imageFile);
    final TaskSnapshot uploadSnapshot = await uploadTask.whenComplete(() {});

    // Yüklenen resmin URL'sini alın
    final imageUrl = await uploadSnapshot.ref.getDownloadURL();

    return imageUrl;
  } catch (e) {
    print('Profil resmi yüklenirken hata oluştu: $e');
    return '';
  }
}

  Future<UserModel> addStatus(
  String uid,
  String username,
  String firstName,
  String lastName,
  String email,
  int phone,
) async {
  await Firebase.initializeApp();

  var ref = _firestore.collection('users');

  await ref.add({
    'userId': uid,
    'username': username,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phone': phone,
  });

  return UserModel(
    uid: uid,
    username: username,
    firstName: firstName,
    lastName: lastName,
    email: email,
    phone: phone,
  );
}
}