import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:melomix/data/model/artist.dart';

class ArtistRepository {
  final String apiUrl;

  ArtistRepository({required this.apiUrl});

  // Método para crear un artista
  Future<void> createArtist(Artist artist) async {
    final response = await http.post(
      Uri.parse('$apiUrl/create_artist'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(artist.toMap()..remove('artist_id')), // Si el id es null, no lo incluimos
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create artist. Status code: ${response.statusCode}');
    }
  }

  // Método para obtener todos los artistas
  Future<List<Artist>> getAllArtists() async {
    final response = await http.get(
      Uri.parse('$apiUrl/get_all_artists'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((artist) => Artist.fromJson(artist)).toList();
    } else {
      throw Exception('Failed to load artists. Status code: ${response.statusCode}');
    }
  }

  // Método para actualizar un artista
  Future<void> updateArtist(Artist artist) async {
    final response = await http.put(
      Uri.parse('$apiUrl/update_artist'), // URL sin artistId
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'artist_id': artist.artistId,
        'name': artist.name,
        'genre': artist.genre,
        'bio': artist.bio,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update artist. Status code: ${response.statusCode}');
    }
  }

  // Método para eliminar un artista usando el ID
  Future<void> deleteArtist(int artistId) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/delete_artist/$artistId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response);


    if (response.statusCode != 200) {
      throw Exception('Failed to delete artist. Status code: ${response.statusCode}');
    }
  }
}