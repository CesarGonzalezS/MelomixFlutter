class Artist {
  int artistId;
  String name;
  String genre;
  String? bio;

  Artist({
    required this.artistId,
    required this.name,
    required this.genre,
    this.bio,
  });

  Map<String, dynamic> toMap() {
    return {
      'artistId': artistId,
      'name': name,
      'genre': genre,
      'bio': bio,
    };
  }

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      artistId: json['artist_id'],
      name: json['name'],
      genre: json['genre'],
      bio: json['bio'],
    );
  }
}
