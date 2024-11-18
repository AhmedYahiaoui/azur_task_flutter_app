class Task {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime createdDate;
  final bool isNotify;
  final bool isFavorit;
  final int? hash;

  Task({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.createdDate,
    required this.isNotify,
    required this.isFavorit,
    this.hash,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      createdDate: DateTime.parse(json['createdDate']),
      isNotify: json['isNotify'],
      isFavorit: json['isFavorit'],
      hash: json['hash'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'createdDate': endTime.toIso8601String(),
      'isNotify': isNotify,
      'isFavorit': isFavorit,
      'hash': hash,
    };
  }
}
