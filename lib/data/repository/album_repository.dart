import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:melomix/data/model/albums.dart';

class AlbumRepository {
  final String apiUrl;

  AlbumRepository({required this.apiUrl});

  Future<void> createAlbum(Album album) async {
    final response = await http.post(
      Uri.parse('$apiUrl/create_albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(album.toMap()..remove('album_id')), // Si el id es null, no lo incluimos
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create album. Status code: ${response.statusCode}');
    }
  }

  Future<List<Album>> getAllAlbums() async {
    final response = await http.get(
      Uri.parse('$apiUrl/get_all_albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((album) => Album.fromJson(album)).toList();
    } else {
      throw Exception('Failed to load albums. Status code: ${response.statusCode}');
    }
  }

  Future<void> updateAlbum(Album album) async {
    final response = await http.put(
      Uri.parse('$apiUrl/update_album'), // URL sin albumId
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'album_id': album.albumId,
        'title': album.title,
        'release_date': album.releaseDate.toIso8601String().split('T')[0],
        'artist_id': album.artistId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update album. Status code: ${response.statusCode}');
    }
  }


  Future<void> deleteAlbum(int albumId) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/delete_album/$albumId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete album. Status code: ${response.statusCode}');
    }
  }
}

