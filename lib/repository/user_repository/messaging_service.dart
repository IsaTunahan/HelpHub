import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

import '../../models/message_model.dart';

class MessagingService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String> getCurrentUserId() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser!.uid;
  }

  Stream<List<Message>> getMessages(String currentUserId, String chatId) {
  final messagesRef = _firebaseFirestore
      .collection('chats')
      .doc(chatId)
      .collection('messages');

  return messagesRef
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Message.fromMap(doc.data())).toList());
}





Future<DocumentReference> sendMessage(String message, String currentUserId, String recipientId, String chatId) async {
  final currentUserRef = _firebaseFirestore.collection('users').doc(currentUserId);
  final recipientRef = _firebaseFirestore.collection('users').doc(recipientId);

  final chatData = {
    'users': [currentUserRef, recipientRef],
  };

  final chatRef = _firebaseFirestore.collection('chats').doc(chatId);
  await chatRef.set(chatData);    

  final messageMap = {
    'senderId': currentUserId,
    'recipientId': recipientId,
    'content': message,
    'isRead': false,
    'timestamp': Timestamp.now(),
    'isMe': true,
  };

  final docRef = await chatRef.collection('messages').add(messageMap);
  return docRef;
}


  Future<void> markMessageAsRead(String messageId) async {
    await _firebaseFirestore
        .collection('messages')
        .doc(messageId)
        .update({'isRead': true});
  }


Future<void> sendNotification(String recipientToken, String message) async {
    const serverKey = 'AIzaSyCSqSDVBCg_EwslmIWdwPYAgK1LsHVpI28';
    const url = 'https://fcm.googleapis.com/fcm/send';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final body = {
      'notification': {
        'title': 'Yeni Mesaj',
        'body': message,
      },
      'priority': 'high',
      'to': recipientToken,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      print('Bildirim gönderildi');
    } else {
      print('Bildirim gönderilirken hata oluştu: ${response.reasonPhrase}');
    }
  }

  Future<String> _getRecipientToken(String recipientId) async {

    final userDoc = await _firebaseFirestore.collection('users').doc(recipientId).get();
    final token = userDoc.data()?['fcmToken'] as String;

    return token;
  }

  



  Future<void> configureFirebaseMessaging() async {
    await _firebaseMessaging.requestPermission();
    final token = await _firebaseMessaging.getToken();
    print('Firebase Messaging Token: $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification?.body}');
    });
  }

  Stream<List<Message>> getHelpMessages(String helpId) async* {
    final messagesRef = FirebaseFirestore.instance
        .collection('helps')
        .doc(helpId)
        .collection('messages');

    yield* messagesRef
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Message.fromMap(doc.data())).toList());
  }

  getPreviousChats(String currentUserId, BuildContext context) {}
  
}
