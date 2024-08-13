import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:melomix/data/model/artist.dart';

class ArtistRepository {
  final String apiUrl;

  ArtistRepository({required this.apiUrl});

  // Método para crear un artista
  Future<void> createArtist(Artist artist) async {
    final response = await http.post(
      Uri.parse('$apiUrl/create_artist'), // Asegúrate de tener la URL correcta
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(artist.toMap()..remove('artistId')),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create artist');
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
      throw Exception('Failed to load artists');
    }
  }

  // Método para actualizar un artista
  Future<void> updateArtist(Artist artist) async {
    final response = await http.put(
      Uri.parse('$apiUrl/update_artist/${artist.artistId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(artist.toMap()),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update artist");
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

    if (response.statusCode != 200) {
      throw Exception("Failed to delete artist");
    }
  }
}