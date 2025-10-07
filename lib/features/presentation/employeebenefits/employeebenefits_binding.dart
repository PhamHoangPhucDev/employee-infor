import 'package:get/get.dart';

import 'employeebenefits_controller.dart';

class EmployeebenefitsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeebenefitsController>(() => EmployeebenefitsController());
  }
}
