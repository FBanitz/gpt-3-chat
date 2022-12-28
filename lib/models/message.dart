class Message {
  final String text;
  final DateTime timestamp;
  final String sender;
  final bool waiting;

  Message({
    required this.text, 
    required this.timestamp,
    required this.sender,
    this.waiting = false,
  });

}