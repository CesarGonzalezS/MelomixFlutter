class Song {
  final int? songId;
  final String title;
  final int duration; // Cambiado a int
  final int? albumId;
  final int artistId;
  final String genre;

  Song({
    this.songId,
    required this.title,
    required this.duration, // Mantener duration como int
    this.albumId,
    required this.artistId,
    required this.genre,
  });

  // Método fromJson para convertir JSON a una instancia de Song
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      songId: json['song_id'] is int ? json['song_id'] : int.tryParse(json['song_id'] ?? ''),
      title: json['title'] as String,
      // Convertir duration a int si viene como String
      duration: json['duration'] is int ? json['duration'] : int.parse(json['duration']),
      albumId: json['album_id'] is int ? json['album_id'] : int.tryParse(json['album_id'] ?? ''),
      artistId: json['artist_id'] is int ? json['artist_id'] : int.parse(json['artist_id']),
      genre: json['genre'] as String,
    );
  }

  // Método toMap para convertir una instancia de Song a un Map que se puede convertir a JSON
  Map<String, dynamic> toMap() {
    final map = {
      'title': title,
      'duration': duration, // Mantener duration como int
      'album_id': albumId,
      'artist_id': artistId,
      'genre': genre,
    };
    if (songId != null) {
      map['song_id'] = songId;
    }
    return map;
  }
}
