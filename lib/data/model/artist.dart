class Artist {
  final String artistId;
  final String name;
  final String genre;
  final String? bio; // Biografía opcional del artista

  Artist({
    this.artistId = '',
    required this.name,
    required this.genre,
    this.bio,
  });

  // Método para convertir un objeto Artist a un mapa (JSON)
  Map<String, dynamic> toMap() {
    return {
      'artistId': artistId,
      'name': name,
      'genre': genre,
      'bio': bio,
    };
  }

  // Constructor de fábrica para crear un objeto Artist desde un JSON
  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      artistId: json['artistId']?.toString() ?? '', // Convertir a String o asignar un String vacío
      name: json['name'] ?? '',
      genre: json['genre'] ?? '',
      bio: json['bio'], // `bio` puede ser nulo
    );
  }
}