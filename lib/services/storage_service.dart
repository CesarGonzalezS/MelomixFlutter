import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();

  factory StorageService() {
    return _instance;
  }

  StorageService._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Variables para acceder a los datos guardados
  String? get idToken => _prefs.getString('id_token');
  String? get accessToken => _prefs.getString('access_token');
  String? get refreshToken => _prefs.getString('refresh_token');
  String? get userGroup => _prefs.getString('user_group');
  String? get username => _prefs.getString('username');
  String? get password => _prefs.getString('password');

  Future<void> saveUserData(
      String idToken, String accessToken, String refreshToken, String userGroup) async {
    await _prefs.setString('id_token', idToken);
    await _prefs.setString('access_token', accessToken);
    await _prefs.setString('refresh_token', refreshToken);
    await _prefs.setString('user_group', userGroup);
  }

  Future<void> saveUserCredentials(String username, String password) async {
    await _prefs.setString('username', username);
    await _prefs.setString('password', password);
  }

  Future<Map<String, String?>> getUserCredentials() async {
    return {
      'username': _prefs.getString('username'),
      'password': _prefs.getString('password'),
    };
  }

  Future<void> clearUserData() async {
    await _prefs.clear(); // Esto borra todos los datos
  }
}
