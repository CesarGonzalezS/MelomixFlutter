import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/favorites.dart';
import 'package:melomix/config/config.dart';

class FavoriteRepository {
  final String apiUrl;
  FavoriteRepository({required this.apiUrl});

  //We obtain all the favorites from an user
  Future<List<Favorite>> getAllFavoritesByUser(int userId) async{
    final response = await http.get(
      Uri.parse('${Config.getAllFavoritesByUserEndpoint}/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode ==200){
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((favorite) => Favorite.fromJson(favorite)).toList();
    }else{
      throw Exception("Failed to get favorites line 23");
    }
  }

  //Create a new favorite
  Future<void> createFavorite(Favorite favorite) async {
    final response = await http.post(
      Uri.parse(Config.createFavoriteEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: json.encode(favorite.toMap()),
    );
    if(response.statusCode != 200){
      throw Exception("Failed to create a favorite line 37");
    }
  }

  //Update a favorite
  Future<void> updateFavorite(Favorite favorite) async{
    final response = await http.put(
      Uri.parse('${Config.updateFavorite}/${favorite.favoriteId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; carset=UTF-8',
      },
      body: jsonEncode(favorite.toMap())
    );

    if(response.statusCode != 200){
      throw Exception("Failed to update favorite lin52");
    }
  }

  //Eliminate a favorite
  Future<void> deleteFavorite(int favoriteId) async{
    final response = await http.delete(
      Uri.parse("${Config.deleteFavorite}/$favoriteId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if(response.statusCode != 200){
      throw Exception("Failed to delete favorite line 66");
    }
  }

}


