import '../../domain/entities/user.dart';

class UserModel extends User {
  final String? gender;
  final String? role;
  final String? exp;
  final String? yearsOfService;
  UserModel({
    super.id,
    required super.fullname,
    required super.email,
    required super.birthday,
    required super.mobile,
    required super.password,
    this.exp,
    this.gender,
    this.role,
    this.yearsOfService,
    super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      birthday: json['birthday'] ?? '',
      password: json['password'] ?? '',
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => super.toJson();
}
