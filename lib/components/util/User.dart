class User {
  int id;
  String username = "User";
  String email = "NULL";
  String token;
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['name'].toString(),
      email: json['email'].toString(),
      token: json['token'].toString(),
    );
  }

  String getName() {
    return username;
  }
}
