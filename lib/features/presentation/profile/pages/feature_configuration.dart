import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/components/appBar_component.dart';
import '../../../../core/components/button/confirm_bottom_sheet.dart';
import '../../../../core/constants/app_strings.dart';

import '../../../../core/theme/app_colors.dart';
import '../profile_controller.dart';
import '../../../../core/components/button/listTile_icon_button.dart';
import 'change_password.dart';
import 'privacy_policy.dart';
import 'setting_notifi.dart';

class FeatureConfigurationScreen extends StatelessWidget {
  FeatureConfigurationScreen({super.key, required this.controller});
  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "title": AppStrings.settingNotifiTitle,
        "icon": HugeIcons.strokeRoundedBulb,
        "func": () => Get.to(
              () => SettingNotifiScreen(title: AppStrings.settingNotifiTitle),
            ),
      },
      {
        "title": AppStrings.changePasswordTitle,
        "icon": HugeIcons.strokeRoundedLockKey,
        "func": () => Get.to(
              () => ChangePasswordScreen(title: AppStrings.changePasswordTitle),
            ),
      },
      {
        "title": AppStrings.removeUserTitle,
        "icon": HugeIcons.strokeRoundedUserRemove01,
        "func": () async {
          showConfirmBottomSheet(
            icon: HugeIcons.strokeRoundedAlert02,
            title: "Xóa tài khoản?",
            message:
                "Bạn có chắc chắn muốn xóa tài khoản này không?\nHành động này không thể hoàn tác.",
            confirmText: "Xóa",
            confirmColor: AppColors.error,
            onConfirm: () {
              // controller.deleteAccount();
            },
          );
        }
      },
      {
        "title": AppStrings.privacyPolicyTitle,
        "icon": HugeIcons.strokeRoundedSecurityLock,
        "func": () => Get.to(
              () => PrivacyPolicyScreen(title: AppStrings.privacyPolicyTitle),
            ),
      },
      {
        "title": AppStrings.logoutButton,
        "icon": HugeIcons.strokeRoundedLogout02,
        "func": () async {
          showConfirmBottomSheet(
            title: "Bạn có chắc chắn muốn đăng xuất không?",
            confirmText: "Xác nhận",
            onConfirm: () {
              // controller.logout();
              print("Đăng xuất thành công");
            },
          );
        }
      },
    ];

    return Scaffold(
      appBar: AppBarComponent(title: AppStrings.settingsTitle),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = items[index];
                  return ListTileIconButtonComponent(
                    title: item["title"] as String,
                    icon: item["icon"] as List<List<dynamic>>,
                    func: item["func"] as VoidCallback,
                  );
                },
                childCount: items.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
