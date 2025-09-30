import 'package:get/get.dart';

import '../../domain/services/auth_service.dart';

class ProfileController extends GetxController {
  final AuthService authService = Get.find<AuthService>();

  String get name => authService.user?.name ?? '';
  String get email => authService.user?.email ?? '';
}
