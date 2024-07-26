import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://u4dinp3ekk.execute-api.us-east-2.amazonaws.com/Prod/login';

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Aquí puedes manejar la respuesta, por ejemplo, verificar el token de autenticación
      print('Login successful');
      return true;
    } else {
      // Manejar errores
      print('Login failed: ${response.reasonPhrase}');
      return false;
    }
  }
}
