import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/chat_model.dart';
import '../../repository/user_repository/messaging_service.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: Provider.of<MessagingService>(context).getCurrentUserId(),
      builder: (context, snapshotData) {
        if (snapshotData.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshotData.hasError) {
          return Text('Hata: ${snapshotData.error}');
        } else {
          final currentUserId = snapshotData.data!;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Önceki Sohbetler'),
            ),
            body: FutureBuilder<List<Chat>>(
              future: Provider.of<MessagingService>(context)
                  .getPreviousChats(currentUserId, context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final previousChats = snapshot.data!;

                  return ListView.builder(
                    itemCount: previousChats.length,
                    itemBuilder: (context, index) {
                      final chat = previousChats[index];

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(chat.recipientProfilePic),
                        ),
                        title: Text(chat.recipientName),
                        subtitle: chat.lastMessage != null
                            ? Text(chat.lastMessage!.content)
                            : null,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                recipientId: chat.recipientId,
                                helpId:
                                    '', // Help ID'si gerekiyorsa buraya ekleyin
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Hata: ${snapshot.error}');
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        }
      },
    );
  }
}
