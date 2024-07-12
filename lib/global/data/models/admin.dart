class Admin {
  int adminId;
  String username;
  String email;
  String password;
  String role;

  Admin({
    required this.adminId,
    required this.username,
    required this.email,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'adminId': adminId,
      'username': username,
      'email': email,
      'password': password,
      'role': role,
    };
  }

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      adminId: json['admin_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
    );
  }
}
