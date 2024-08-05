class Favorite {
  int favoriteId;
  String? description;
  int userId;
  DateTime createdAt;

  Favorite({
    required this.favoriteId,
    this.description,
    required this.userId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'favoriteId': favoriteId,
      'description': description,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      favoriteId: json['favorite_id'],
      description: json['description'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
