import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../employees_controller.dart';

class ExperienceListSection extends StatelessWidget {
  const ExperienceListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmployeesController>();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TabBarView(
        controller: controller.tabController,
        physics: NeverScrollableScrollPhysics(),
        children: controller.tabViews.map((page) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: page
          );
        }).toList(),
      )
    );
  }
}