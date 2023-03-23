import 'package:gpt_3_chat/models/user.dart';

class Message {
  final String text;
  final DateTime timestamp;
  final User sender;
  final bool waiting;

  Message({
    required this.text, 
    required this.timestamp,
    required this.sender,
    this.waiting = false,
  });

}