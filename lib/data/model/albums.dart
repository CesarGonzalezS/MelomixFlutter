class Album {
  final int? albumId; // Puede ser null cuando creamos un nuevo álbum
  final String title;
  final DateTime releaseDate;
  final int artistId;

  Album({
    this.albumId,
    required this.title,
    required this.releaseDate,
    required this.artistId,
  });

  Map<String, dynamic> toMap() {
    return {
      'album_id': albumId,
      'title': title,
      'release_date': releaseDate.toIso8601String(),
      'artist_id': artistId,
    };
  }

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      albumId: json['album_id'],
      title: json['title'],
      releaseDate: DateTime.parse(json['release_date']),
      artistId: json['artist_id'],
    );
  }
}
