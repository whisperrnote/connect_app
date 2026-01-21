class Conversation {
  final String id;
  final String type; // direct, group, broadcast
  final List<String> participants;
  final List<String>? admins;
  final String? name;
  final String? avatar;
  final String? lastMessageId;
  final DateTime? lastMessageAt;
  final String? encryptionKey;
  final String? contextType;
  final String? contextId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Conversation({
    required this.id,
    required this.type,
    required this.participants,
    this.admins,
    this.name,
    this.avatar,
    this.lastMessageId,
    this.lastMessageAt,
    this.encryptionKey,
    this.contextType,
    this.contextId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['\$id'] ?? '',
      type: json['type'] ?? 'direct',
      participants: List<String>.from(json['participants'] ?? []),
      admins: json['admins'] != null ? List<String>.from(json['admins']) : null,
      name: json['name'],
      avatar: json['avatar'],
      lastMessageId: json['lastMessageId'],
      lastMessageAt: json['lastMessageAt'] != null
          ? DateTime.parse(json['lastMessageAt'])
          : null,
      encryptionKey: json['encryptionKey'],
      contextType: json['contextType'],
      contextId: json['contextId'],
      createdAt: DateTime.parse(json['\$createdAt']),
      updatedAt: DateTime.parse(json['\$updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'participants': participants,
      'admins': admins,
      'name': name,
      'avatar': avatar,
      'lastMessageId': lastMessageId,
      'lastMessageAt': lastMessageAt?.toIso8601String(),
      'encryptionKey': encryptionKey,
      'contextType': contextType,
      'contextId': contextId,
    };
  }
}
