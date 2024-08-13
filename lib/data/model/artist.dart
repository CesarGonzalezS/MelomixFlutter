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
      artistId: json['artistId'],
      name: json['name'],
      genre: json['genre'],
      bio: json['bio'],
    );
  }
}