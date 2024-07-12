class User {
  int userId;
  String username;
  String email;
  String password;
  DateTime dateJoined;
  String? profileImageBase64;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.dateJoined,
    this.profileImageBase64,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'password': password,
      'dateJoined': dateJoined.toIso8601String(),
      'profileImageBase64': profileImageBase64,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      dateJoined: DateTime.parse(json['date_joined']),
      profileImageBase64: json['profile_image_base64'],
    );
  }
}
