// Giả sử bạn có 1 model cho item chức năng
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/routes/app_routes.dart';

class FunctionItem {
  final List<List<dynamic>> icon;
  final String label;
  final VoidCallback onPressed;

  FunctionItem({required this.icon, required this.label, required this.onPressed});
}

// Trong HomePageState
final List<FunctionItem> functionItems = [
  FunctionItem(
    icon: HugeIcons.strokeRoundedFingerPrintCheck,
    label: "Chấm Công",
    onPressed: () => Get.toNamed(AppRoutes.attendance),
  ),
  FunctionItem(
    icon: HugeIcons.strokeRoundedUserList,
    label: "Nhân Viên",
    onPressed: () => Get.toNamed(AppRoutes.employees),
  ),
  FunctionItem(
    icon: HugeIcons.strokeRoundedBitcoinCreditCard,
    label: "Công Nợ",
    onPressed: () => Get.toNamed(AppRoutes.debt),
  ),
  FunctionItem(
    icon: HugeIcons.strokeRoundedQuestion,
    label: "Hỗ Trợ",
    onPressed: () => Get.toNamed(AppRoutes.helpcenter),
  ),
];
