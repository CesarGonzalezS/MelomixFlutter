class User {
  int userId;
  String username;
  String email;
  String password;
  DateTime dateJoined;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.dateJoined,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'password': password,
      'dateJoined': dateJoined.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      dateJoined: DateTime.parse(json['date_joined']),
    );
  }
}
