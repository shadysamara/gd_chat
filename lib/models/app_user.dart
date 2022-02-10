class AppUser {
  String? userId;
  late String email;
  late String password;
  late String name;
  AppUser({
    required this.email,
    required this.password,
    required this.name,
  });
  AppUser.fromJson(Map<String, dynamic> map) {
    this.email = map['email'];
    this.name = map['name'];
    this.userId = map['userId'];
  }
  toMap() {
    return {'email': email, 'name': name, 'userId': userId};
  }
}
