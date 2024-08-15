class Artist {
  final int? artistId; // Puede ser null cuando se crea un nuevo artista
  final String name;
  final String genre;
  final String? bio; // Biografía opcional del artista

  Artist({
    this.artistId,
    required this.name,
    required this.genre,
    this.bio,
  });

  // Método para convertir un objeto Artist a un mapa (JSON)
  Map<String, dynamic> toMap() {
    return {
      'artist_id': artistId,
      'name': name,
      'genre': genre,
      'bio': bio,
    };
  }

  // Constructor de fábrica para crear un objeto Artist desde un JSON
  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      artistId: json['artist_id'],
      name: json['name'],
      genre: json['genre'],
      bio: json['bio'],
    );
  }
}