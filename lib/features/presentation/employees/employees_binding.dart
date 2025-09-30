import 'package:get/get.dart';

import 'employees_controller.dart';

class EmployeesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeesController>(() => EmployeesController());
  }
}
