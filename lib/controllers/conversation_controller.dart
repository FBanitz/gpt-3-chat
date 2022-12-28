import 'package:gpt_3_chat/models/message.dart';

import 'ai_controller.dart';

class ConversationController {
  final List<Message> _conversation = [];
  final _aiController = AIController();

  void sendMessage(String message, {Function? callback}) {
    _conversation.add(
      Message(
        sender: 'user',
        text: message,
        timestamp: DateTime.now(),
      )
    );
    _conversation.add(
      Message(
        sender: 'ai',
        text: '...',
        waiting: true,
        timestamp: DateTime.now(),
      )
    );
    String prompt = "";
    for (Message message in _conversation){
      prompt += "${message.sender}: ${message.text}\n";
    }
    prompt += "ai: ";
    _aiController.generateText(prompt, 0.5, 2048).then((response) {
      editLastAiMessage(response);
      callback?.call();
    });
  }

  void delete(int index) {
    _conversation.removeAt(index);
  }

  void editLastAiMessage (String message) {
    for (int i = _conversation.length - 1; i >= 0; i--) {
      if (_conversation[i].sender == 'ai') {
        delete(i);
        _conversation.add(
          Message(
            sender: 'ai',
            text: message,
            waiting: false,
            timestamp: DateTime.now(),
          )
        );
        break;
      }
    }
  }

  List<Message> get conversation => _conversation;

  bool get waiting => (_conversation.isNotEmpty && _conversation.last.waiting);
}