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
      final resp = await apiClient.post('/login', data: {
        'email': email,
        'password': password,
      });

      if (resp.statusCode == 200 && resp.data != null) {
        final data = resp.data as Map<String, dynamic>;
        final userMap = Map<String, dynamic>.from(data['user']);
        userMap['token'] = data['token']; // thêm token vào user
        return UserModel.fromJson(userMap);
      }
    } catch (e) {
      print('AuthRepositoryImpl.login error: $e');
    }

    return null;
  }


  @override
  Future<void> logout() async {
    try {
      await apiClient.dio.post('/logout');
    } catch (_) {
      // ignore errors on logout
    }
  }
}
