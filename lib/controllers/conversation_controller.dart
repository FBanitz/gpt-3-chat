import 'package:gpt_3_chat/extensions/string.dart';
import 'package:gpt_3_chat/models/message.dart';
import 'package:gpt_3_chat/models/user.dart';

import 'ai_controller.dart';

class ConversationController {
  final List<Message> _conversation = [];
  final _aiController = AIController();
  final User ai = User.ai;
  final User user = User(name: "user", role: UserRole.user);
  Map<String, int> usage = {
    'prompt_tockens': 0,
    'completion_tokens': 0,
    'total_tockens': 0,
  };

  Future<void> sendMessage(String message, {Function? callback}) async {
    _conversation.add(Message(
      sender: user,
      text: message.cleanMessage,
      timestamp: DateTime.now(),
    ));

    _conversation.add(Message(
      sender: ai,
      text: '',
      waiting: true,
      timestamp: DateTime.now(),
    ));

    String prompt = "";

    for (Message message in _conversation) {
      prompt += "${message.sender.name}: ${message.text}\n";
    }

    late AiResponse response;
    try {
      response = await _aiController.generateText(prompt, 0.5, 2048);
    } catch (e) {
      response = AiResponse(
        text: "Error: $e",
        isError: true,
        promptTokens: 0,
        completionTokens: 0,
        totalTokens: 0,
      );
    } finally {
      editLastAiMessage(response.text);
      usage['prompt_tockens'] =
          response.promptTokens + usage['prompt_tockens']!;
      usage['completion_tokens'] =
          response.completionTokens + usage['completion_tokens']!;
      usage['total_tockens'] = response.totalTokens + usage['total_tockens']!;
      callback?.call();
    }
  }

  void delete(int index) {
    _conversation.removeAt(index);
  }

  void editLastAiMessage(String message) {
    for (int i = _conversation.length - 1; i >= 0; i--) {
      if (_conversation[i].sender.role == UserRole.ai) {
        delete(i);
        _conversation.add(Message(
          sender: ai,
          text: message,
          waiting: false,
          timestamp: DateTime.now(),
        ));
        break;
      }
    }
  }

  List<Message> get conversation => _conversation;

  bool get waiting => (_conversation.isNotEmpty && _conversation.last.waiting);
}
