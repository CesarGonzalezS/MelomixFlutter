class FavoriteOnUse {
  int favoriteOnUseId;
  int? favoriteId;
  int? songId;
  DateTime? createdAt;

  FavoriteOnUse({
    required this.favoriteOnUseId,
    this.favoriteId,
    this.songId,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'favoriteOnUseId': favoriteOnUseId,
      'favoriteId': favoriteId,
      'songId': songId,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory FavoriteOnUse.fromJson(Map<String, dynamic> json) {
    return FavoriteOnUse(
      favoriteOnUseId: json['favorite_on_use_id'],
      favoriteId: json['favorite_id'],
      songId: json['song_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}
