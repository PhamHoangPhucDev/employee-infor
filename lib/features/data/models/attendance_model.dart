/// Enum trạng thái chấm công
enum AttendanceStatus { empty, missing, lateOrEarly, full }

/// Model dữ liệu chấm công
class AttendanceRecord {
  final String? checkIn;   // giờ check-in (có thể null)
  final String? checkOut;  // giờ check-out (có thể null)

  AttendanceRecord({this.checkIn, this.checkOut});
}