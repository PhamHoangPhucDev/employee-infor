import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthRepository repository;
  final AuthService authService = Get.find<AuthService>();
  
  AuthController(this.repository);

  var isLoading = false.obs;

   Future<void> login(String email, String password) async {
    // try {
    //   isLoading.value = true;
    //   final user = await repository.login(email.trim(), password.trim());
    //   if (user != null) {
    //     await authService.saveUser(user);
        Get.offAllNamed(AppRoutes.navigation);
    //   } else {
    //     Get.snackbar('Lỗi', 'Email hoặc mật khẩu không đúng');
    //   }
    // } finally {
    //   isLoading.value = false;
    // }
  }

  Future<void> logout() async {
    await repository.logout();
    await authService.clearUser();
    Get.offAllNamed(AppRoutes.login);
  }
}
