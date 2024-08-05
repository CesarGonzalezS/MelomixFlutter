class Album {
  int albumId;
  String title;
  DateTime releaseDate;
  int artistId;

  Album({
    required this.albumId,
    required this.title,
    required this.releaseDate,
    required this.artistId,
  });

  Map<String, dynamic> toMap() {
    return {
      'albumId': albumId,
      'title': title,
      'releaseDate': releaseDate.toIso8601String(),
      'artistId': artistId,
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
