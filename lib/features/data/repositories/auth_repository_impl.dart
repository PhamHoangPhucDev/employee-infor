import '../../../core/network/api_client.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;

  AuthRepositoryImpl(this.apiClient);

  @override
  Future<User?> login(String email, String password) async {
    try {
      final resp = await apiClient.dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      if (resp.statusCode == 200 && resp.data != null) {
        // giả sử API trả { user: {...}, token: '...' } hoặc trả trực tiếp user object
        final data = resp.data;
        if (data is Map && data['user'] != null) {
          final userMap = Map<String, dynamic>.from(data['user']);
          userMap['token'] = data['token'] ?? userMap['token'];
          return UserModel.fromJson(userMap);
        }
        if (data is Map) {
          return UserModel.fromJson(Map<String, dynamic>.from(data));
        }
      }
      // nếu API không tồn tại (demo) -> fallback mock
    } catch (e) {
      // ignore: avoid_print
      print('AuthRepositoryImpl.login error: $e');
    }

    // FALLBACK (local demo) — để dev test khi chưa có backend:
    if (email == 'admin@company.com' && password == '1234') {
      return UserModel(id: '1', name: 'Nguyễn Văn A', email: email, token: 'fake-jwt-token');
    }

    return null;
  }

  @override
  Future<void> logout() async {
    try {
      await apiClient.dio.post('/auth/logout');
    } catch (_) {
      // ignore errors on logout
    }
  }
}
