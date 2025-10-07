import 'package:get/get.dart';

import 'helpcenter_controller.dart';

class HelpcenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HelpcenterController>(() => HelpcenterController());
  }
}
