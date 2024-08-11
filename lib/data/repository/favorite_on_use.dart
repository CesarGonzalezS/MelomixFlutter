import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/favorite_on_use.dart';

// Repositorio que maneja las peticiones a la API
class FavoriteRepository {
  final String apiUrl = 'https://your_api_url_here';

  FavoriteRepository();

  // Método para obtener los favoritos desde la API
  Future<List<Favorite>> getFavorites() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/get_favorites'));

      if (response.statusCode == 200) {
        List<dynamic> favoritesJson = jsonDecode(response.body)['favorites'];
        List<Favorite> favorites = favoritesJson.map((fav) => Favorite.fromJson(fav)).toList();
        return favorites;
      } else {
        throw Exception('Failed to fetch favorites');
      }
    } catch (e) {
      print('Error getFavorites: $e');
      throw Exception('Failed to fetch favorites');
    }
  }

  // Método para guardar un favorito
  Future<void> saveFavorite(Favorite favorite) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/save_favorite'),
        body: jsonEncode(favorite.toMap()),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to save favorite');
      }
    } catch (e) {
      print('Error saveFavorite $e');
      throw Exception('Failed to save favorite');
    }
  }

  // Método para actualizar un favorito
  Future<void> updateFavorite(Favorite favorite) async {
    try {
      final response = await http.put(
          Uri.parse('$apiUrl/update_favorite'),
          body: jsonEncode(favorite.toMap())
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update favorite');
      }
    } catch (e) {
      print('Error updateFavorite $e');
      throw Exception('Failed to update favorite');
    }
  }

  // Método para eliminar un favorito
  Future<void> deleteFavorite(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/delete_favorite/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete favorite');
      }
    } catch (e) {
      print('Error deleteFavorite $e');
      throw Exception('Failed to delete favorite');
    }
  }
}
