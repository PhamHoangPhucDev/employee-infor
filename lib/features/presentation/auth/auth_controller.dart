import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../../data/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthRepository repository;
  final AuthService authService = Get.find<AuthService>();
  
  AuthController(this.repository);

  var isLoading = false.obs;

  final fullnameCtrl = TextEditingController();
  final emailCtrl = TextEditingController(text: "a@gmail.com");
  final mobileCtrl = TextEditingController();
  final birthdayCtrl = TextEditingController();
  final passwordCtrl = TextEditingController(text: "1234");
  final confirmPasswordCtrl = TextEditingController();

  final signupFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onClose() {
    fullnameCtrl.dispose();
    emailCtrl.dispose();
    mobileCtrl.dispose();
    birthdayCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.onClose();
  }

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

  // SIGNUP FUNCTION
  Future<void> signup() async {
  if (!signupFormKey.currentState!.validate()) return;

  isLoading.value = true;

  try {
    final request = UserModel(
      // id có thể bỏ hoặc backend tạo
      fullname: fullnameCtrl.text,
      email: emailCtrl.text,
      mobile: mobileCtrl.text,
      birthday: birthdayCtrl.text,
      password: passwordCtrl.text,
    );

    // await repository.signup(request);
    await Future.delayed(Duration(seconds: 2)); // giả lập API call

    Get.snackbar('Thành công', 'Đăng ký thành công cho ${request.fullname}');
    signupFormKey.currentState!.reset(); // reset form
  } catch (e) {
    Get.snackbar('Lỗi', 'Đăng ký thất bại: $e');
  } finally {
    isLoading.value = false;
  }
}


  Future<void> logout() async {
    await repository.logout();
    await authService.clearUser();
    Get.offAllNamed(AppRoutes.login);
  }
}
