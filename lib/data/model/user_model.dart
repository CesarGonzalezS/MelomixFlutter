class User_model {
  final String userId;
  final String username;
  final String email;
  final String password;
  final String dateJoined;

  User_model({
    this.userId = '', // Hacer que userId sea opcional
    required this.username,
    required this.email,
    required this.password,
    required this.dateJoined,
  });

  // Convertir de JSON a una instancia de User_model
  factory User_model.fromJson(Map<String, dynamic> json) {
    return User_model(
      userId: json['userId'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      dateJoined: json['dateJoined'] ?? '',
    );
  }

  // Convertir de una instancia de User_model a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'password': password,
      'dateJoined': dateJoined,
    };
  }

  // Convertir de una instancia de User_model a un mapa para enviar al servidor
  Map<String, dynamic> toMap() {
    return {
      'username': email,
      'email': email,
      'password': password,
      'dateJoined': dateJoined,
    };
  }

  setUsername(String username) {
    return User_model(
      userId: userId,
      username: username,
      email: email,
      password: password,
      dateJoined: dateJoined,
    );
  }
}
