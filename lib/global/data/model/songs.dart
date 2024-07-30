class Song {
  int songId;
  String title;
  int duration;
  int? albumId;
  int artistId;
  String genre;

  Song({
    required this.songId,
    required this.title,
    required this.duration,
    this.albumId,
    required this.artistId,
    required this.genre,
  });

  Map<String, dynamic> toMap() {
    return {
      'songId': songId,
      'title': title,
      'duration': duration,
      'albumId': albumId,
      'artistId': artistId,
      'genre': genre,
    };
  }

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      songId: json['song_id'],
      title: json['title'],
      duration: json['duration'],
      albumId: json['album_id'],
      artistId: json['artist_id'],
      genre: json['genre'],
    );
  }
}
