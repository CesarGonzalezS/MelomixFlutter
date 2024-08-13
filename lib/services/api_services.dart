import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:melomix/data/model/artist.dart';
import 'package:melomix/data/model/user_model.dart';
import 'package:melomix/data/model/songs_model.dart';
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

    Future<void> createArtist(Artist artist) async {
    print('API createArtist called');
    final response = await http.post(
      Uri.parse(Config.postArtistEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(artist.toMap()..remove('artistId')), // Elimina artistId si el backend lo genera automáticamente
    );

    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('Artist created successfully');
    } else {
      print('Error: ${response.body}');
      throw Exception('Failed to create artist');
    }
  }

  Future<List<Artist>> getAllArtists() async {
    print('API getAllArtists called');
    final response = await http.get(
      Uri.parse(Config.getAllArtistEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((artist) => Artist.fromJson(artist)).toList();
    } else {
      print('Error: ${response.body}');
      throw Exception('Failed to get all artists');
    }
  }

  Future<Artist> getArtist(int artistId) async {
    print('API getArtist called with artistId=$artistId');
    final response = await http.get(
      Uri.parse(Config.getArtistEndpoint.replaceAll('2', artistId.toString())),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return Artist.fromJson(jsonDecode(response.body));
    } else {
      print('Error: ${response.body}');
      throw Exception('Failed to load artist');
    }
  }

  Future<void> updateArtist(Artist artist) async {
    print('API updateArtist called');
    final response = await http.put(
      Uri.parse(Config.putArtistEndpoint.replaceAll('2', artist.artistId.toString())),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(artist.toMap()),
    );

    print('Response status: ${response.statusCode}');
    if (response.statusCode != 200) {
      print('Error: ${response.body}');
      throw Exception('Failed to update artist');
    } else {
      print('Artist updated successfully');
    }
  }

  Future<void> deleteArtist(int artistId) async {
    print('API deleteArtist called with artistId=$artistId');
    final response = await http.delete(
      Uri.parse(Config.deleteArtistEndpoint.replaceAll('2', artistId.toString())),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print('Response status: ${response.statusCode}');
    if (response.statusCode != 200) {
      print('Error: ${response.body}');
      throw Exception('Failed to delete artist');
    } else {
      print('Artist deleted successfully');
    }
  }
}


