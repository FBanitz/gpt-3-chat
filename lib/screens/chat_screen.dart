import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gpt_3_chat/controllers/conversation_controller.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final scrollController = ScrollController();
  final _messageController = TextEditingController();
  final _conversationController = ConversationController();

  void _sendMessage() {
    callback() {
      setState(() {});
      Future.delayed(
        const Duration(milliseconds: 300), 
        () {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
      );
    }

    _conversationController.sendMessage(
      _messageController.text, 
      callback: callback,
    );

    callback();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPT-3 Chat App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: _conversationController.conversation.length,
              dragStartBehavior: DragStartBehavior.down,
              itemBuilder: (context, index) {
                final message = _conversationController.conversation[index];
                final isMessageFromUser = message.sender == 'user';
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(isMessageFromUser ? 32 : 16 , 0, isMessageFromUser ? 16 : 32, 0),
                    child: Column(
                      crossAxisAlignment:
                        isMessageFromUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        if(!message.waiting) Text(
                          DateFormat.jm().format(message.timestamp),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: isMessageFromUser
                              ? Colors.lightBlue[100]
                              : Colors.grey[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: message.waiting
                          ? SizedBox(
                            width: 50,
                            child: JumpingDotsProgressIndicator(
                              fontSize: 20,
                              numberOfDots: 3,
                            ),
                          )
                          : Text(
                            message.text,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    enabled: !_conversationController.waiting,
                    controller: _messageController,
                    textInputAction: TextInputAction.send,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onSubmitted:  (_) => _sendMessage(),
                    decoration: const InputDecoration(
                      hintText: 'Enter a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: _conversationController.waiting ? Colors.grey : Colors.blue,
                  ),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
