class CallLog {
  final String id;
  final String callerId;
  final String receiverId;
  final String type; // audio, video
  final String status; // completed, missed, rejected, busy
  final int? duration;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;

  CallLog({
    required this.id,
    required this.callerId,
    required this.receiverId,
    required this.type,
    required this.status,
    this.duration,
    required this.startedAt,
    this.endedAt,
    required this.createdAt,
  });

  factory CallLog.fromJson(Map<String, dynamic> json) {
    return CallLog(
      id: json['\$id'] ?? '',
      callerId: json['callerId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      type: json['type'] ?? 'audio',
      status: json['status'] ?? 'completed',
      duration: json['duration'],
      startedAt: DateTime.parse(json['startedAt']),
      endedAt: json['endedAt'] != null ? DateTime.parse(json['endedAt']) : null,
      createdAt: DateTime.parse(json['\$createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'callerId': callerId,
      'receiverId': receiverId,
      'type': type,
      'status': status,
      'duration': duration,
      'startedAt': startedAt.toIso8601String(),
      'endedAt': endedAt?.toIso8601String(),
    };
  }
}
