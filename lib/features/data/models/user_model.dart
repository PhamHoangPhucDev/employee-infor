import '../../domain/entities/user.dart';

class UserModel extends User {
  final String? gender;
  final String? role;
  final String? exp;
  final String? yearsOfService;
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    this.exp,
    this.gender,
    this.role,
    this.yearsOfService,
    super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => super.toJson();
}
