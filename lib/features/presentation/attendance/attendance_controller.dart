// lib/pages/attendance/attendance_controller.dart
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/models/attendance_model.dart';

class AttendanceController extends GetxController {
  /// Dropdown (Ngày/Tháng/Năm)
  RxString selectedValue = 'Tháng'.obs;

  /// Ngày đang được chọn
  final Rx<DateTime> selectedDay = DateTime.now().obs;

  /// Có hiển thị box detail không
  final RxBool showDetail = false.obs;

  /// Tháng hiện tại (để render lịch)
  final Rx<DateTime> currentMonth = DateTime.now().obs;

  /// Dữ liệu chấm công, key = "yyyy-MM-dd"
  var attendanceRecords = <String, AttendanceRecord>{}.obs;

  @override
  void onInit() {
    super.onInit();
    mockData(); // gán data mẫu để test
  }

  // -------------------- Helpers --------------------

  String _formatKey(DateTime d) => DateFormat('yyyy-MM-dd').format(d);

  bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// Lấy tất cả ngày trong 1 tháng
  List<DateTime> getDaysInMonth(DateTime month) {
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    return List.generate(
      daysInMonth,
      (i) => DateTime(month.year, month.month, i + 1),
    );
  }

  /// Parse giờ (string -> DateTime giả)
  DateTime? _parseTime(String? timeStr) {
    if (timeStr == null || timeStr.trim().isEmpty) return null;
    try {
      return DateFormat("HH:mm").parse(timeStr);
    } catch (_) {
      return null;
    }
  }

  // -------------------- CRUD --------------------

  /// Thêm hoặc cập nhật record
  void addOrUpdateRecord(DateTime day, {String? checkIn, String? checkOut}) {
    final key = _formatKey(day);
    final existing = attendanceRecords[key] ?? AttendanceRecord();
    attendanceRecords[key] = AttendanceRecord(
      checkIn: checkIn ?? existing.checkIn,
      checkOut: checkOut ?? existing.checkOut,
    );
    attendanceRecords.refresh();
  }

  /// Xác định trạng thái của 1 ngày
  AttendanceStatus getDayStatus(DateTime date) {
    final key = _formatKey(date);
    final record = attendanceRecords[key];
    if (record == null) return AttendanceStatus.empty;

    final inTime = _parseTime(record.checkIn);
    final outTime = _parseTime(record.checkOut);

    if (inTime == null || outTime == null) {
      return AttendanceStatus.missing;
    }

    // Giờ chuẩn: 09:00 - 17:00
    final workStart = DateFormat("HH:mm").parse("09:00");
    final workEnd = DateFormat("HH:mm").parse("17:00");

    if (inTime.isAfter(workStart) || outTime.isBefore(workEnd)) {
      return AttendanceStatus.lateOrEarly;
    }

    return AttendanceStatus.full;
  }

  /// Lấy detail để hiển thị
  String getDayDetail(DateTime? date) {
    if (date == null) return "";
    final key = _formatKey(date);
    final record = attendanceRecords[key];
    if (record == null) return "Chưa có dữ liệu";

    final checkIn = record.checkIn ?? "--:--";
    final checkOut = record.checkOut ?? "--:--";
    final status = getDayStatus(date);

    switch (status) {
      case AttendanceStatus.full:
        return "Check In: $checkIn\nCheck Out: $checkOut\nTrạng thái: Đúng giờ";
      case AttendanceStatus.missing:
        return "Dữ liệu không đầy đủ\nCheck In: $checkIn\nCheck Out: $checkOut";
      case AttendanceStatus.lateOrEarly:
        return "Check In: $checkIn\nCheck Out: $checkOut\nTrạng thái: Đi trễ / Về sớm";
      case AttendanceStatus.empty:
        return "Chưa có dữ liệu";
    }
  }

  /// Chọn ngày (click vào lịch)
  void toggleSelectedDay(DateTime day) {
    if (isSameDay(selectedDay.value, day)) {
      showDetail.toggle();
    } else {
      selectedDay.value = day;
      showDetail.value = true;
    }
  }

  // -------------------- Dummy data --------------------
  void mockData() {
    final now = DateTime.now();
    addOrUpdateRecord(now, checkIn: "09:00", checkOut: "17:00");
    addOrUpdateRecord(now.subtract(const Duration(days: 1)),
        checkIn: "09:30", checkOut: "17:15");
    addOrUpdateRecord(now.subtract(const Duration(days: 2)),
        checkIn: null, checkOut: null);
    addOrUpdateRecord(now.subtract(const Duration(days: 3)),
        checkIn: "10:00", checkOut: "15:30");
  }
}
