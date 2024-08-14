import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:melomix/data/model/user_model.dart';
import 'package:melomix/data/model/song_model.dart';
import 'package:melomix/config/config.dart';
//Importations of albums
import '../data/model/albums.dart';

class ApiServices {
  Future<void> createUser(User_model user) async {
    print('API createUser called');
    final response = await http.post(
      Uri.parse(Config.sing_upEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toMap()),
    );

    print('Response status: ${response.statusCode}');

    if (response.statusCode != 200) {
      print('Error: ${response.body}');
      throw Exception('Failed to create user');
    } else {
      print('User created successfully');
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

  // Servicio de login
  Future<bool> loginUser(String email, String password) async {
    print('API loginUser called with email=$email');

    final response = await http.post(
      Uri.parse(Config.login),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['success'] == true) {
        print('Login successful');
        return true;
      } else {
        print('Login failed: ${responseData['message']}');
        return false;
      }
    } else {
      print('Login failed with status: ${response.statusCode}');
      return false;
    }
  }

  // Servicios para las canciones

Future<void> createSong(Song song) async {
    final response = await http.post(
      Uri.parse(Config.postSongEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(song.toJson()), // Usar toJson para enviar el objeto canción
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create song');
    } else {
      print('Song created successfully');
    }
  }

  // Obtener todas las canciones
  Future<List<Song>> getAllSongs() async {
  final response = await http.get(
    Uri.parse(Config.getAllSongsEndpoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  print('Response Status: ${response.statusCode}');
  print('Response Body: ${response.body}'); // Imprime la respuesta cruda

  if (response.statusCode == 200) {
    print("12345");
    List<dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((song) => Song.fromJson(song)).toList();
  } else {
    throw Exception('Failed to load songs');
  }
}

  // Obtener una canción por ID
  Future<Song> getSong(String songId) async {
    final response = await http.get(
      Uri.parse('${Config.getSongEndpoint.replaceAll('1', songId)}'), // Reemplaza el placeholder por el songId
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Song.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load song');
    }
  }

  // Actualizar una canción existente
  Future<void> updateSong(Song song) async {
    final response = await http.put(
      Uri.parse(Config.putSongEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(song.toJson()), // Usar toJson para enviar los datos actualizados
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update song');
    } else {
      print('Song updated successfully');
    }
  }

  // Eliminar una canción por ID
  Future<void> deleteSong(String songId) async {
    final response = await http.delete(
      Uri.parse('${Config.deleteSongEndpoint.replaceAll('1', songId)}'), // Reemplaza el placeholder por el songId
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete song');
    } else {
      print('Song deleted successfully');
    }
  }


  // Servicios para los álbumes
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
      throw Exception('Failed to get all albums');
    }
  }

  Future<void> updateAlbum(Album album) async {
    final response = await http.put(
      Uri.parse(Config.updateAlbumEndpoint +'/${album.albumId}'),
      headers:<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(album.toMap()),
    );
    if (response.statusCode != 200) {
      throw Exception('Album failed to update');
    }
  }

  Future<void> deleteAlbum(int albumId) async {
    final response = await http.delete(
      Uri.parse(Config.deleteAlbumEndpoint + '/$albumId'),
      headers:<String, String>{
        'Content-Type': 'application/json; charset= UTS-8',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Album failed to delete');
    }
  }
}