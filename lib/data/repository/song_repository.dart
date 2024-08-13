import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:melomix/data/model/songs_model.dart';

class SongRepository {
  final String apiUrl;

  SongRepository({required this.apiUrl});

  // Crear una nueva canción
  Future<void> createSong(Song song) async {
    final response = await http.post(
      Uri.parse('$apiUrl/create_song'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(song.toJson()..remove('song_id')), // Asegúrate de usar 'song_id'
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create song: ${response.body}');
    }
  }

  // Leer una canción por ID
  Future<Song> readSong(int songId) async {
    final response = await http.get(
      Uri.parse('$apiUrl/read_song?song_id=$songId'),
    );

    if (response.statusCode == 200) {
      return Song.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load song: ${response.body}');
    }
  }

  // Actualizar una canción existente
  Future<void> updateSong(Song song) async {
    final response = await http.put(
      Uri.parse('$apiUrl/update_song'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(song.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update song: ${response.body}');
    }
  }

  // Eliminar una canción por ID
  Future<void> deleteSong(int songId) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/delete_song?song_id=$songId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete song: ${response.body}');
    }
  }
}
