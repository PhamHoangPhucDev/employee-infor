// lib/features/leave/leave_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveController extends GetxController {
  // PageController cho horizontal PageView (dùng để scroll đến ngày)
  // viewportFraction điều chỉnh kích thước mỗi item so với viewport
  final PageController scrollController = PageController(viewportFraction: 0.22);

  // Reactive states (GetX)
  var showMonthView = true.obs;   // true: hiển thị Grid tháng; false: hiển thị horizontal + form
  var showContent = true.obs;     // control để ẩn/hiện nội dung khi thay đổi height
  var selectedDay = DateTime.now().day.obs; // ngày đang được chọn (như int: 1..31)

  //Thời gian nghỉ trong ngày
  var leaveType = RxnString();
  var startTime = TimeOfDay(hour: 9, minute: 0).obs;
  var endTime = TimeOfDay(hour: 17, minute: 0).obs;

  final leaveTypes = [
    "Nguyên ngày",
    "Nửa ngày (sáng)",
    "Nửa ngày (chiều)",
    "Theo giờ",
  ];
  
  // Danh sách lý do nghỉ
  final reasons = [
    "Nghỉ phép năm",
    "Nghỉ ốm",
    "Nghỉ việc riêng",
    "Nghỉ thai sản",
    "Khác"
  ];

  // Biến observable để theo dõi lý do được chọn
  var selectedReason = RxnString();

  // TextEditingController cho ghi chú
  final noteController = TextEditingController();

  // Tập các ngày đã có lịch nghỉ (ví dụ demo). Thực tế lấy từ API/DB.
  final Set<int> leaveDays = {3, 5, 15, 20, 27};

  /// Scroll tới trang tương ứng ngày (1-based => page index = day-1).
  /// Dùng addPostFrameCallback + hasClients để tránh lỗi "PageController not attached".
  void scrollToDay(int day) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        // jumpToPage nhanh; nếu muốn hiệu ứng mượt hãy dùng animateToPage(...)
        scrollController.jumpToPage(day - 1);
      }
    });
  }

  /// Khi chọn ngày từ Grid:
  /// - cập nhật selectedDay
  /// - ẩn content (để AnimatedSize co/thu trước)
  /// - sau delay (khoảng thời gian AnimatedSize chạy) bật content và scroll tới ngày
  void selectDay(int day) {
    selectedDay.value = day;
    showContent.value = false;
    showMonthView.value = false;

    // Delay phải tương ứng với thời gian AnimatedSize (ở LeavePage)
    Future.delayed(const Duration(milliseconds: 350), () {
      // kiểm tra mounted không cần vì GetX controller tồn tại lâu hơn nhưng vẫn safe
      showContent.value = true;
      scrollToDay(day);
    });
  }

  /// Khi bấm "Quay lại tháng"
  /// - ẩn content trước, rồi bật lại grid sau delay
  void backToMonth() {
    showContent.value = false;
    showMonthView.value = true;

    Future.delayed(const Duration(milliseconds: 350), () {
      showContent.value = true;
      // scrollToDay nếu có reason muốn focus horizontal khi quay trở lại
      scrollToDay(selectedDay.value);
    });
  }

  // Hàm gửi đơn xin nghỉ
  void submitLeave() {
    if (selectedReason.value == null) {
      Get.snackbar("Lỗi", "Vui lòng chọn lý do nghỉ",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final reason = selectedReason.value!;
    final note = noteController.text;

    // Demo hiển thị
    Get.snackbar("Đã gửi", "Lý do: $reason\nGhi chú: $note",
        snackPosition: SnackPosition.BOTTOM);
  }

  /// Dispose controller (nếu cần giải phóng controller)
  @override
  void onClose() {
    scrollController.dispose();
    noteController.dispose();
    super.onClose();
  }
}
