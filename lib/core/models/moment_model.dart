class Moment {
  final String id;
  final String userId;
  final String content;
  final List<String>? images;
  final String? video;
  final List<String>? likes;
  final List<String>? comments;
  final DateTime createdAt;

  Moment({
    required this.id,
    required this.userId,
    required this.content,
    this.images,
    this.video,
    this.likes,
    this.comments,
    required this.createdAt,
  });

  factory Moment.fromJson(Map<String, dynamic> json) {
    return Moment(
      id: json['\$id'] ?? '',
      userId: json['userId'] ?? '',
      content: json['content'] ?? '',
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      video: json['video'],
      likes: json['likes'] != null ? List<String>.from(json['likes']) : [],
      comments: json['comments'] != null
          ? List<String>.from(json['comments'])
          : [],
      createdAt: DateTime.parse(json['\$createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'content': content,
      'images': images,
      'video': video,
      'likes': likes,
      'comments': comments,
    };
  }
}
