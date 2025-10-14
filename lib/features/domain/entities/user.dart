class User {
  final String? id;
  final String fullname;
  final String email;
  final String mobile;
  final String birthday;
  final String password;
  final String? token; // optional

  User({
    this.id,
    required this.fullname,
    required this.email,
    required this.birthday,
    required this.mobile,
    required this.password,
    this.token,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullname,
        'email': email,
        'token': token,
        'password': password,
        'birthday': birthday,
        'mobile': mobile,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id']?.toString() ?? '',
        fullname: json['fullname'] ?? '',
        email: json['email'] ?? '',
        mobile: json['mobile'] ?? '',
        birthday: json['birthday'] ?? '',
        password: json['password'] ?? '',
        token: json['token'],
      );
}
