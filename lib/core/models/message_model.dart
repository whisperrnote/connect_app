class Message {
  final String id;
  final String conversationId;
  final String senderId;
  final String type; // text, image, video, audio, file, call_signal, system
  final String? content;
  final List<String>? attachments;
  final String? replyTo;
  final List<String>? readBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.type,
    this.content,
    this.attachments,
    this.replyTo,
    this.readBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['\$id'] ?? '',
      conversationId: json['conversationId'] ?? '',
      senderId: json['senderId'] ?? '',
      type: json['type'] ?? 'text',
      content: json['content'],
      attachments: json['attachments'] != null
          ? List<String>.from(json['attachments'])
          : null,
      replyTo: json['replyTo'],
      readBy: json['readBy'] != null ? List<String>.from(json['readBy']) : null,
      createdAt: DateTime.parse(json['\$createdAt']),
      updatedAt: DateTime.parse(json['\$updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'senderId': senderId,
      'type': type,
      'content': content,
      'attachments': attachments,
      'replyTo': replyTo,
      'readBy': readBy,
    };
  }
}
