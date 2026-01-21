class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final String type; // text, image, file
  final DateTime createdAt;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.type,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['\$id'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      content: json['content'] ?? '',
      type: json['type'] ?? 'text',
      createdAt: DateTime.parse(json['\$createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'type': type,
    };
  }
}

class Chat {
  final String id;
  final List<String> participantIds;
  final Message? lastMessage;
  final DateTime updatedAt;

  Chat({
    required this.id,
    required this.participantIds,
    this.lastMessage,
    required this.updatedAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['\$id'] ?? '',
      participantIds: List<String>.from(json['participantIds'] ?? []),
      lastMessage: json['lastMessage'] != null
          ? Message.fromJson(json['lastMessage'])
          : null,
      updatedAt: DateTime.parse(json['\$updatedAt']),
    );
  }
}
