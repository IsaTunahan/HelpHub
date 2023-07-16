import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_model.dart';

class Chat {
  final String recipientId;
  final Message? lastMessage;
  final String recipientProfilePic;
  final String recipientName;

  Chat({
    required this.recipientId,
    required this.recipientProfilePic,
    required this.recipientName,
    this.lastMessage,
  });
}


 
