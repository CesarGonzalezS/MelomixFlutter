import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_favorites/data/model/favorite_on_use.dart';

// Servicio de la API para manejar los favoritos
class ApiServiceFavorite {
  final String apiUrl = 'https://your_api_url_here';

  // Método para obtener los favoritos desde la API
  Future<List<Favorite>> getFavorites() async {
    final response = await http.get(Uri.parse('$apiUrl/get_favorites'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Favorite.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load favorites');
    }
  }

  // Método para agregar un favorito
  Future<void> addFavorite(Favorite favorite) async {
    final response = await http.post(
      Uri.parse('$apiUrl/add_favorite'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(favorite.toMap()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add favorite');
    }
  }

  // Método para eliminar un favorito
  Future<void> removeFavorite(int id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/remove_favorite/$id'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to remove favorite');
    }
  }
}
