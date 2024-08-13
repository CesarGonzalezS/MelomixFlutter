import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:melomix/data/model/albums.dart';

class AlbumRepository {
  final String apiUrl;

  AlbumRepository({required this.apiUrl});

  //To create we are gonna use an async method, like this one
  Future<void> createAlbum(Album album) async {
    final response = await http.post(
      Uri.parse('$apiUrl/create_albums'), // Asegúrate de tener la URL correcta
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(album.toMap()..remove('albumId')),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create album failed, check line 21');
    }
  }

  //Ahora metodo para obtener todos los albunes
  Future<List<Album>> getAllAlbums() async {
    final response = await http.get(
      Uri.parse('$apiUrl/get_all_albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    //We have yo validate the repsonse to get all the albums
    if(response.statusCode == 200){
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((album) => Album.fromJson(album)).toList();
    }else{
    throw Exception('Failed to load albums check line38');
    }
  }

  //Now, we are gonna do the update
  Future<void> updateAlbum(Album album) async{
    final response = await http.put(
      Uri.parse('$apiUrl/update_album/${album.albumId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(album.toMap()),
    );
    //We validate the response to get an error if it exists
    if(response.statusCode != 200){
      throw Exception("Its an error updating the album, please check it line53");
    }
  }

  //To finally, we need to delete an album using the id
  Future<void> deleteAlbum(int albumId) async{
    final response = await http.delete(
      Uri.parse('$apiUrl/delete_album/$albumId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    //And validate again
    if(response.statusCode != 200){
      throw Exception("Failed to delete the album, check line67");
    }
  }
}
