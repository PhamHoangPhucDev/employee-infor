import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';
import '../../../core/components/appBar_component.dart';
import '../../../core/components/button/text_button_component.dart';
import '../../../core/components/text_field_component.dart';
import '../../../core/components/button/circle_icon_button.dart';
import '../../../core/constants/app_padding_bottom.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../auth/auth_controller.dart';
import 'pages/feature_configuration.dart';
import 'profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBarComponent(
        title: AppStrings.profileTitle,
        showBack: false,
        actions: [
          CircleIconButton(
            icon: HugeIcons.strokeRoundedSettings01,
            iconColor: AppColors.primary,
            onPressed: () {
              Get.to(() => FeatureConfigurationScreen(controller: controller));
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          /// Avatar header
          SliverToBoxAdapter(
            child: Container(
              height: 12.h,
              width: 100.w,
              color: AppColors.primary,
              child: Center(
                child: SizedBox(
                  width: 70.w,
                  height: 15.h,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.background,
                      child: const Icon(Icons.person),
                    ),
                    title: Text(
                      controller.name,
                      style: AppTypography.body(color: AppColors.textLight),
                    ),
                    subtitle: Text(
                      controller.email,
                      style: AppTypography.smallbody(color: AppColors.textLight),
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// Detail info fields
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch, // căng đều widget width
                children: [
                  TextFieldComponent(
                    controller: controller.fullnameController,
                    label: 'Họ và tên',
                  ),
                  SizedBox(height: 2.h),
                  TextFieldComponent(
                    controller: controller.phonenumberController,
                    label: 'Số điện thoại',
                  ),
                  SizedBox(height: 2.h),
                  TextFieldComponent(
                    controller: controller.emailController,
                    label: 'Email',
                  ),
                  SizedBox(height: 2.h),
                  TextFieldComponent(
                    controller: controller.birthController,
                    label: 'Ngày sinh',
                  ),

                  /// Nút cập nhật
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: TextButtonComponent(
                      title: "Cập nhật",
                      color: AppColors.primary,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
