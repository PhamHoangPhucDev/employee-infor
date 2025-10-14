import 'package:get/get.dart';

class EmployeesController extends GetxController {
  var scrollOffset = 0.0.obs;
  var selectedTabIndex = 0.obs;

  void updateScroll(double offset) {
    scrollOffset.value = offset;
  }

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }
      //banner

      //header avatar + tên + chức vụ + t.phố cư trú

      //Giới thiệu

      //Kinh nghiệm

      //Học vấn

      //Giấy phép & chứng nhận

      //Dự án

      //Kỹ năng

      //Ngôn ngữ
}
