import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../repository/user_repository/messaging_service.dart';
import '../chat_screen/chat_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late MessagingService _messagingService;

  @override
  void initState() {
    super.initState();
    _messagingService = MessagingService();
  }

  Future<String> getCurrentUserId() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getCurrentUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final currentUserId = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Chat List'),
            ),
            body: FutureBuilder<List<DocumentSnapshot>>(
              future: _messagingService.getPreviousChats(currentUserId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final chatDocs = snapshot.data!;
                  return ListView.builder(
                    itemCount: chatDocs.length,
                    itemBuilder: (context, index) {
                      final chatDoc = chatDocs[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                recipientId: chatDoc['recipientId'],
                              ),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(chatDoc['recipientImage']),
                        ),
                        title: Text(chatDoc['recipientName']),
                        subtitle: Text(chatDoc['lastMessage']),
                      );
                    },
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}