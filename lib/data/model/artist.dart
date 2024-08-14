class Artist {
  int artistId;
  String name;
  String genre;
  String? bio; // Biografía opcional del artista

  Artist({
    required this.artistId,
    required this.name,
    required this.genre,
    this.bio,
  });

  // Método para convertir un objeto Artist a un mapa (JSON)
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'genre': genre,
      'bio': bio,
    };

    // Incluye 'artistId' solo si no es nulo
    if (artistId != 0) {
      map['artistId'] = artistId;
    }

    return map;
  }

  // Constructor de fábrica para crear un objeto Artist desde un JSON
  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      artistId: json['artistId'] ?? 0, // Proporciona un valor por defecto si es nulo
      name: json['name'] ?? '',       // Proporciona un valor por defecto si es nulo
      genre: json['genre'] ?? '',     // Proporciona un valor por defecto si es nulo
      bio: json['bio'],               // `bio` puede ser nulo
    );
  }
}