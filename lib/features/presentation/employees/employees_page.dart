import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/components/appBar_component.dart';
import '../../../core/components/app_dialog_component.dart.dart';
import '../../../core/components/text_field_component.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import 'employees_controller.dart';
import 'widgets/experience_list_section.dart';
import 'widgets/header_section.dart';
import 'widgets/profile_info_section.dart';
import 'widgets/social_links_section.dart';
import 'widgets/tabs_section.dart';

class EmployeesPage extends GetView<EmployeesController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBarComponent(title: AppStrings.employeesTitle),
      body: NestedScrollView(
        controller: controller.scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // HEADER
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HeaderSection(),
                  ProfileInfoSection(),
                  SocialLinksSection(),
                  Divider(color: AppColors.backgroundInput,indent: 20,endIndent: 20,thickness: 2,height: 10,)
                ],
              ),
            ),
            
            // TABS BAR
            SliverPersistentHeader(
              pinned: true,
              delegate: TabsHeaderDelegate(),
            ),
            
          ];
        },
        //Tab View
        body: ExperienceListSection(),
      ),
      floatingActionButton:_buildFloatingButton(context)
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    return Obx(() {
      final isExperienceTab = controller.currentTabIndex.value == 0 || controller.currentTabIndex.value == 1;
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: animation, child: child),
        ),
        child: isExperienceTab
            ? FloatingActionButton(
                key: const ValueKey("fab_visible"),
                onPressed: controller.currentTabIndex.value == 0
                  ? (){
                      AppDialogComponent.show(
                        context: context,
                        title: "Giới thiệu",
                        type: DialogType.bottomSheet,
                        confirmText: "Cập nhật",
                        confirmColor: AppColors.primary,
                        fields: [
                          TextFieldComponent(
                            controller: TextEditingController(),
                            label: "Tổng quát về bản thân",
                            hintText: "Giới thiệu sơ về bản thân bạn",
                            maxLines: null,
                          ),
                        ],
                        onConfirm:(){

                        },
                      );
                    }
                  : (){
                      AppDialogComponent.show(
                        context: context,
                        title: "Thêm kinh nghiệm",
                        type: DialogType.bottomSheet,
                        confirmText: "Thêm",
                        confirmColor: AppColors.primary,
                        fields: [
                          TextFieldComponent(label: "Chức vụ", controller: TextEditingController()),
                          TextFieldComponent(label: "Công ty", controller: TextEditingController()),
                          TextFieldComponent(label: "Địa chỉ công ty", controller: TextEditingController()),
                          TextFieldComponent(label: "Thời gian làm việc", controller: TextEditingController()),
                          TextFieldComponent(
                            controller: TextEditingController(),
                            label: "Mô tả công việc",
                            hintText: "Mô tả ngắn về công việc bạn đã làm",
                            maxLines: null,
                          ),
                        ],
                        onConfirm:(){

                        },
                      );
                  },
                
                backgroundColor: AppColors.primary,
                shape: const CircleBorder(),
                elevation: 6,
                child: HugeIcon(
                  icon: controller.currentTabIndex.value == 0
                        ? HugeIcons.strokeRoundedTaskEdit01
                        : HugeIcons.strokeRoundedAdd01,
                  color: AppColors.background,
                  size: 22.sp,
                ),
              )
            : const SizedBox.shrink(key: ValueKey("fab_hidden")),
      );
    });
  }

}

