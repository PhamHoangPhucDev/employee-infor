/// Khai báo tên route dùng chung trong toàn app
abstract class AppRoutes {
  static const String splash = '/splash';//màn hình load logo đầu app
  static const String welcome = '/welcome';// screen chào mừng
  static const String onboarding = '/onboarding';// giới thiệu
  static const String login = '/login';//đăng nhập
  static const String signup = '/signup';//đăng ký
  static const String home = '/home';// trang chủ
  static const String attendance = '/attendance';// điểm danh
  static const String employees = '/employees';// d.s nhân viên
  static const String debt = '/debt'; // công nợ
  static const String helpcenter = '/helpcenter'; // hỗ trợ
  static const String leave = '/leave'; // nghỉ phép
  static const String salary = '/salary'; // lương
  static const String employeebenefits = '/employeebenefits'; // chế độ
  static const String notification = '/notification'; // thông báo
  static const String profile = '/profile';// hồ sơ cá nhân
  static const String settings = '/settings'; // cài đặt
  static const String navigation = '/navigation'; // Điều hướng dashboard
  static const String task = '/task'; // Công việc
}
