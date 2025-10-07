import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../core/components/appBar_component.dart';
import '../../../core/constants/app_strings.dart';
import '../attendance/attendance_controller.dart';
import 'leave_controller.dart';
import 'widgets/leave_month_grid.dart';
import 'widgets/leave_horizontal.dart';

class LeavePage extends StatelessWidget {
  const LeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Put leave controller vào GetX. Nếu page khác cần controller riêng, dùng tag.
    final LeaveController controller = Get.put(LeaveController());

    // Chuẩn bị dữ liệu demo cho AttendanceController (nếu chưa có)
    // Lưu ý: AttendanceController phải implement mockData() hoặc onInit để load data
    Get.put(AttendanceController()).mockData();

    return Scaffold(
      appBar: AppBarComponent(title: AppStrings.leaveTitle),
      body: Obx(() {
        // targetHeight: bạn có thể tinh chỉnh theo thiết kế
        final double targetHeight = controller.showMonthView.value ? 90.h : 100.h;

        return AnimatedSize(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          child: SizedBox(
            height: targetHeight,
            width: 100.w,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(0, 0.2), // content trượt từ dưới lên
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                ));
        
                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
        
              // showContent = true -> hiển thị widget tương ứng (grid/horizontal)
              child: controller.showContent.value
                  ? (controller.showMonthView.value
                      ? LeaveMonthGrid(controller: controller)
                      : LeaveHorizontal(controller: controller))
                  : const SizedBox.shrink(),
            ),
          ),
        );
      }),
    );
  }
}
