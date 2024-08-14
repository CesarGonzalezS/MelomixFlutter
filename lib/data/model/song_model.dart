class Song {
  final String songId;
  final String title;
  final String duration;
  final int? albumId; // Opcional
  final int artistId;
  final String genre;

  // Constructor con valores predeterminados
  Song({
    this.songId = '', // Valor predeterminado
    required this.title,
    required this.duration,
    this.albumId,
    required this.artistId,
    required this.genre,
  });

  // Convertir de JSON a una instancia de Song
  factory Song.fromJson(Map<String, dynamic> json) {
  return Song(
    songId: json['song_id']?? '', // Asegura que sea un String
    title: json['title'] ?? '',
    duration: json['duration'] ?? '',
    albumId: json['album_id'] is int
        ? json['album_id']
        : json['album_id'] != null
            ? int.tryParse(json['album_id'].toString())
            : null,
    artistId: json['artist_id'] is int
        ? json['artist_id']
        : int.tryParse(json['artist_id'].toString()) ?? 0,
    genre: json['genre'] ?? '',
  );
}

  // Convertir de una instancia de Song a un mapa JSON completo
  Map<String, dynamic> toJson() {
    return {
      'song_id': songId,
      'title': title,
      'duration': duration,
      'album_id': albumId,
      'artist_id': artistId,
      'genre': genre,
    };
  }

  // Convertir de una instancia de Song a un mapa parcial para enviar al servidor
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'duration': duration,
      'album_id': albumId,
      'artist_id': artistId,
      'genre': genre,
    };
  }
}
