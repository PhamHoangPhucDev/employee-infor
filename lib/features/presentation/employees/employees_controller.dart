import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/about_section.dart';
import 'pages/edu_certifications_section.dart';
import 'pages/exp_projects_section.dart';
import 'pages/skills_languages_section.dart';

class EmployeesController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var currentTabIndex = 0.obs;
  final ScrollController scrollController = ScrollController();

  final List<String> tabs = [
    'Giới thiệu',
    'Kinh nghiệm & Dự án',
    'Học vấn & Chứng nhận',
    'Kỹ năng & Ngôn ngữ',
  ];
  final List<Widget> tabViews = [
    AboutSection(),
    ExpProjectsSection(),
    EduCertificationsSection(),
    SkillsLanguagesSection(),
  ];
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      currentTabIndex.value = tabController.index;
    });
    //Theo dõi cuộn
    // scrollController.addListener(() {
    //   print("Current scroll offset: ${scrollController.offset}");
    // });
  }

   @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    scrollController.dispose();
  }
}
