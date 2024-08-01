import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:melomix/data/model/user_model.dart';

class UserRepository {
  final String apiUrl;
  // final String accessToken; // Comentado ya que aún no tienes esta parte

  UserRepository({required this.apiUrl}); // Constructor corregido

  Future<void> createUser(User_model user) async {
    final response = await http.post(
      Uri.parse('$apiUrl/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'Bearer $accessToken', // Comentado ya que aún no tienes esta parte
      },
      body: jsonEncode(user.toMap()..remove('userId')),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create user');
    }
  }

  Future<User_model> getUser(String id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/users/$id'),
      headers: <String, String>{
        // 'Authorization': 'Bearer $accessToken', // Comentado ya que aún no tienes esta parte
      },
    );

    if (response.statusCode == 200) {
      return User_model.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<void> updateUser(User_model user) async {
    final response = await http.put(
      Uri.parse('$apiUrl/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'Bearer $accessToken', // Comentado ya que aún no tienes esta parte
      },
      body: jsonEncode(user.toMap()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(String id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/users/$id'),
      headers: <String, String>{
        // 'Authorization': 'Bearer $accessToken', // Comentado ya que aún no tienes esta parte
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }

  Future<List<User_model>> getAllUsers() async {
    final response = await http.get(
      Uri.parse('$apiUrl/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'Bearer $accessToken', // Comentado ya que aún no tienes esta parte
      },
    );

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<User_model>.from(l.map((model) => User_model.fromJson(model)));
    } else {
      throw Exception('Failed to load users');
    }
  }
}
