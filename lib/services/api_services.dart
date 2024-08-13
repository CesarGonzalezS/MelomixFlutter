// api_services.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:melomix/data/model/user_model.dart';
import 'package:melomix/data/model/song_model.dart';
import 'package:melomix/config/config.dart';

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

  Future<void> createSong(Song song) async {
    print('API createSong called');
    final response = await http.post(
      Uri.parse(Config.postSongEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(song.toJson()..remove('songId')),
    );

    print('Response status: ${response.statusCode}');
    if (response.statusCode != 200) {
      print('Error: ${response.body}');
      throw Exception('Failed to create song');
    } else {
      print('Song created successfully');
    }
  }

  // Leer una canción por ID
  Future<Song> readSong(int songId) async {
    print('API readSong called with songId=$songId');
    final response = await http.get(
      Uri.parse(Config.getSongEndpoint.replaceAll('${songId}', songId.toString())),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return Song.fromJson(jsonDecode(response.body));
    } else {
      print('Error: ${response.body}');
      throw Exception('Failed to load song');
    }
  }

  // Actualizar una canción existente
  Future<void> updateSong(Song song) async {
    print('API updateSong called');
    final response = await http.put(
      Uri.parse(Config.putSongEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(song.toJson()),
    );

    print('Response status: ${response.statusCode}');
    if (response.statusCode != 200) {
      print('Error: ${response.body}');
      throw Exception('Failed to update song');
    } else {
      print('Song updated successfully');
    }
  }

  // Eliminar una canción por ID
  Future<void> deleteSong(int songId) async {
    print('API deleteSong called with songId=$songId');
    final response = await http.delete(
      Uri.parse(Config.deleteSongEndpoint.replaceAll('${songId}', songId.toString())),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print('Response status: ${response.statusCode}');
    if (response.statusCode != 200) {
      print('Error: ${response.body}');
      throw Exception('Failed to delete song');
    } else {
      print('Song deleted successfully');
    }
  }

  // Obtener todas las canciones (opcional)
  Future<List<Song>> getAllSongs() async {
    print('API getAllSongs called');
    final response = await http.get(
      Uri.parse(Config.getAllSongsEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((song) => Song.fromJson(song)).toList();
    } else {
      print('Error: ${response.body}');
      throw Exception('Failed to load songs');

}

