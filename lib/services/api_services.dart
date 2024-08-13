import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:melomix/data/model/user_model.dart';
import 'package:melomix/config/config.dart';
//Importations of albums
import '../data/model/albums.dart';

class ApiServices {
  Future<void> createUser(User_model user) async {
    print('API createUser called'); // Log para verificar que la API se llama
    final response = await http.post(
      Uri.parse(Config.sing_upEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toMap()),
    );

    print('Response status: ${response.statusCode}'); // Log para verificar el estado de la respuesta

    if (response.statusCode != 200) {
      print('Error: ${response.body}'); // Log de error si el código de estado no es 200
      throw Exception('Failed to create user');
    } else {
      print('User created successfully'); // Log de éxito
    }
  }

  Future<List<User_model>> getAllUsers() async {
    final response = await http.get(
      Uri.parse(Config.getAllUsersEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((user) => User_model.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
  //------------------------------------------------------
  //Services de albums
  //------------------------------------------------------
  //We create the create album service
  Future<void> createAlbum(Album album) async {
    final response = await http.post(
      Uri.parse(Config.createAlbumEndpoint),
      headers:<String , String>{
        'Content-Type': 'application/json; charset= UTF-8',
    },
      body: jsonEncode(album.toMap()),
    );
    if (response.statusCode == 200) {
      print('Album created successfully');
    } else {
      throw Exception('Failed to create album');
    }
  }

  //Now to get all albums
  Future<List<Album>> getAllAlbums() async{
    final response = await http.get(
      Uri.parse(Config.getAllAlbumsEndpoint),
      headers:<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((album) => Album.fromJson(album)).toList();
    }else{
      throw Exception('Failes to get all albums line 75 in api_service');
    }
  }

  //Now update
  Future<void> updateAlbum(Album album) async {
    final response = await http.put(
      Uri.parse(Config.updateAlbumEndpoint +'/${album.albumId}'),
      headers:<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(album.toMap()),
    );
    if (response.statusCode != 200) {
      throw Exception('Album failed to update in line 89');
    }
  }

  //Finally, delete
  Future<void> deleteAlbum(int albumId) async {
    final response = await http.delete(
      Uri.parse(Config.deleteAlbumEndpoint + '/$albumId'),
      headers:<String, String>{
        'Content-Type': 'application/json; charset= UTS-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Album failed to delete in line 102');
    }
  }
  //-----------------------------------------------------------------------


}
