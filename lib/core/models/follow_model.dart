class Follow {
  final String id;
  final String followerId;
  final String followingId;
  final DateTime createdAt;

  Follow({
    required this.id,
    required this.followerId,
    required this.followingId,
    required this.createdAt,
  });

  factory Follow.fromJson(Map<String, dynamic> json) {
    return Follow(
      id: json['\$id'] ?? '',
      followerId: json['followerId'] ?? '',
      followingId: json['followingId'] ?? '',
      createdAt: DateTime.parse(json['\$createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'followerId': followerId, 'followingId': followingId};
  }
}
