import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteDataFromFirestore(String collectionName, String docId) async {
  try {
    // Firestore'dan veriyi silmek için gerekli kodları buraya ekleyin
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(docId)
        .delete();
  } catch (error) { 
    print("document silinemedi!"); 
    }
}