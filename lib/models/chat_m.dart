class ChatMessage {
  final String? message;
  final DateTime time;
  final bool isMe;
  final String? imageUrl;

  ChatMessage({
    required this.time,
    required this.isMe,
    this.message,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'time': time.toIso8601String(),
      'isMe': isMe,
      'imageUrl': imageUrl,
    };
  }
}
