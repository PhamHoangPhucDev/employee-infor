import 'package:get/get.dart';

import '../home/home_controller.dart';
import '../notification/notification_controller.dart';
import '../profile/profile_controller.dart';
import '../task/task_controller.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    //Khởi tạo tất cả controller ngay từ đầu
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => TaskController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<HomeController>();
    Get.delete<TaskController>();
    Get.delete<NotificationController>();
    Get.delete<ProfileController>();
  }
  
  
  void changePage(int index) {
    if(currentIndex.value != index) {
      currentIndex.value = index;
    }
  }
}
