class Artist {
  final int? artistId;
  final String name;
  final String genre;
  final String? bio;

  Artist({
    this.artistId,
    required this.name,
    required this.genre,
    this.bio,
  });

  // Método fromJson para convertir JSON a una instancia de Artist
  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      artistId: json['artist_id'] is int ? json['artist_id'] : int.tryParse(json['artist_id'] ?? ''),
      name: json['name'] as String,
      genre: json['genre'] as String,
      bio: json['bio'] as String?,
    );
  }

  // Método toMap para convertir una instancia de Artist a un Map que se puede convertir a JSON
  Map<String, dynamic> toMap() {
    final map = {
      'name': name,
      'genre': genre,
      'bio': bio,
    };
    if (artistId != null) {
      map['artist_id'] = artistId.toString(); // Convertir artistId a String
    }
    return map;
  }
}