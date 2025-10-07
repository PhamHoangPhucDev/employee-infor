import 'package:get/get.dart';
import 'debt_controller.dart';

class DebtBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DebtController>(() => DebtController());
  }
}
