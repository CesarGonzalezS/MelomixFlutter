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
      body: jsonEncode(song.toMap()), // Usa 'toMap' para excluir 'song_id'
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create song: ${response.body}');
    } else {
      print('Song created successfully');
    }
  }

  // Actualizar una canción existente
  Future<void> updateSong(Song song) async {
    final response = await http.put(
      Uri.parse('$apiUrl/update_song'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(song.toJson()), // Usa 'toJson' para incluir 'song_id'
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update song: ${response.body}');
    }
  }

  // Eliminar una canción por ID
  Future<void> deleteSong(String songId) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/delete_song?song_id=$songId'),
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
      Uri.parse('$apiUrl/read_all_songs'),
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
