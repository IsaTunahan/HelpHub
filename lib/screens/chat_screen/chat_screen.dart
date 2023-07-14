import 'package:bootcamp/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/message_model.dart';
import '../../repository/user_repository/messaging_service.dart';

class ChatScreen extends StatefulWidget {
  final String recipientId;
  final String helpId;

  const ChatScreen({Key? key, required this.recipientId, required this.helpId})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  late MessagingService _messagingService;
  List<Message> messages = [];
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _messagingService = Provider.of<MessagingService>(context, listen: false);

    loadMessages();
  }

  @override
void dispose() {
  _isDisposed = true;
  _messageController.dispose();
  super.dispose();
}


  Future<void> loadMessages() async {
    final currentUserId = await _messagingService.getCurrentUserId();
    final chatId = generateChatId(currentUserId, widget.recipientId);

    final Stream<List<Message>> messageStream =
        _messagingService.getMessages(currentUserId, chatId);

    messageStream.listen((List<Message> newMessages) {
      setState(() {
        messages = newMessages;
      });
    });
  }

  Future<void> _handleSendMessage() async {
  final message = _messageController.text;
  if (message.isNotEmpty) {
    final currentUserId = await _messagingService.getCurrentUserId();
    final sentMessage = Message(
      senderId: currentUserId,
      recipientId: widget.recipientId,
      content: message,
      isRead: false,
      timestamp: Timestamp.now(),
      isMe: true,
    );

    if (!_isDisposed) {
      setState(() {
        messages.insert(0, sentMessage);
      });
    }
    _messageController.clear();

    final chatId = generateChatId(currentUserId, widget.recipientId);

    await _messagingService.sendMessage(
        message, currentUserId, widget.recipientId, chatId);
  }
}

  String generateChatId(String userId1, String userId2) {
    List<String> sortedIds = [userId1, userId2]..sort();
    return sortedIds.join('_');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _messagingService.getCurrentUserId(),
      builder: (context, snapshotData) {
        if (snapshotData.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshotData.hasError) {
          return Text('Hata: ${snapshotData.error}');
        } else {
          final currentUserId = snapshotData.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Mesajlaşma'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<Message>>(
                    stream: _messagingService.getMessages(
                      currentUserId,
                      generateChatId(currentUserId, widget.recipientId),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        messages = snapshot.data!;
                        return ListView.builder(
                          reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            final isMe = message.senderId == currentUserId;

                            return Align(
                              alignment: isMe
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isMe
                                      ? AppColors.purple
                                      : AppColors.darkGrey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      message.content,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      message.formatTimestamp(),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: 'Mesajınızı yazın...',
                          ),
                          autocorrect: false,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _handleSendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
