import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:melomix/data/model/user_model.dart';

class UserRepository {
  final String apiUrl;

  UserRepository({required this.apiUrl});

  Future<void> createUser(User_model user) async {
    final response = await http.post(
      Uri.parse('$apiUrl/sign_up'), // Asegúrate de tener la URL correcta
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toMap()..remove('userId')),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create user');
    }
  }
}
