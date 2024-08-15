class SongRepository {
  final String apiUrl;

  SongRepository({required this.apiUrl});

  // Crear una nueva canción
  Future<void> createSong(Song song) async {
    final response = await http.post(
      Uri.parse(Config.postSongEndpoint), // Usa la URL desde Config
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(song.toMap()), // Usa 'toMap' del modelo
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create song: ${response.body}');
    }
  }

  // Actualizar una canción existente
  Future<void> updateSong(Song song) async {
    final response = await http.put(
      Uri.parse(Config.putSongEndpoint), // Usa la URL desde Config
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(song.toMap()), // Usa 'toMap' del modelo
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update song: ${response.body}');
    }
  }

  // Eliminar una canción por ID
  Future<void> deleteSong(int songId) async {
    final response = await http.delete(
      Uri.parse('${Config.deleteSongEndpoint}/$songId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete song: ${response.body}');
    }
  }

  // Obtener todas las canciones
  Future<List<Song>> getAllSongs() async {
    final response = await http.get(
      Uri.parse(Config.getAllSongsEndpoint), // Usa la URL desde Config
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((song) => Song.fromJson(song)).toList();
    } else {
      throw Exception('Failed to load songs: ${response.body}');
    }
  }
}