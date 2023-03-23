import 'dart:convert';

extension FromJSON on String {
  dynamic get fromJson => json.decode(this);
}

extension CleanMessage on String {
  String get cleanMessage {
    String message = this;

    while (message.startsWith('\n') || message.startsWith(' ')) {
      message = message.substring(1);
    }

    while (message.endsWith('\n') || message.endsWith(' ')) {
      message = message.substring(0, message.length - 1);
    }

    return message;
  }
}
