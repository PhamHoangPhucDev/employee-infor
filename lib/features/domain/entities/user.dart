class User {
  final String id;
  final String name;
  final String email;
  final String? token; // optional

  User({
    required this.id,
    required this.name,
    required this.email,
    this.token,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'token': token,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id']?.toString() ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        token: json['token'],
      );
}
