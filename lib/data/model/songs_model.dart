class Song {
  final int songId;
  final String title;
  final String duration;
  final int? albumId; // Opcional
  final int artistId;
  final String genre;

  // Constructor con valores predeterminados
  Song({
    this.songId = 0, // Valor predeterminado
    required this.title,
    required this.duration,
    this.albumId,
    required this.artistId,
    required this.genre,
  });

  // Convertir de JSON a una instancia de Song
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      songId: json['song_id'] ?? 0, // Valor predeterminado si no está presente
      title: json['title'] ?? '',
      duration: json['duration'] ?? '',
      albumId: json['album_id'], // Puede ser null
      artistId: json['artist_id'] ?? 0, // Valor predeterminado si no está presente
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
