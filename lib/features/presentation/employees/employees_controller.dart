import 'package:get/get.dart';

class EmployeesController extends GetxController {
  var bannerHeight = 30.0.obs; // chiều cao widget ban đầu
  final double minHeight = 0;

  void updateHeight(double offset) {
    // khi scroll, banner co dần về 0
    double newHeight = (30 - offset).clamp(minHeight, 30);
    bannerHeight.value = newHeight;
  }
}
