import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/services/auth_service.dart';


class ProfileController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthController = TextEditingController();

  String get name => authService.user?.fullname ?? '';
  String get email => authService.user?.email ?? '';
}
