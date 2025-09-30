import '../entities/user.dart';

abstract class AuthRepository {
  /// trả về User (có token nếu có)
  Future<User?> login(String email, String password);

  Future<void> logout();
}
  // Future<User?> getCurrentUser(); // lấy user hiện tại (nếu có)