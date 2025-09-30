import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';

class WelcomeController extends GetxController {
  void goToOnboarding() {
    Get.toNamed(AppRoutes.onboarding);
  }
}
