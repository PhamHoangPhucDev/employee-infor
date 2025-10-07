import 'package:get/get.dart';

import '../../features/presentation/attendance/attendance_binding.dart';
import '../../features/presentation/attendance/attendance_page.dart';
import '../../features/presentation/debt/debt_binding.dart';
import '../../features/presentation/debt/debt_page.dart';
import '../../features/presentation/employeebenefits/employeebenefits_binding.dart';
import '../../features/presentation/employeebenefits/employeebenefits_page.dart';
import '../../features/presentation/employees/employees_binding.dart';
import '../../features/presentation/employees/employees_page.dart';
import '../../features/presentation/helpcenter/helpcenter_binding.dart';
import '../../features/presentation/helpcenter/helpcenter_page.dart';
import '../../features/presentation/notification/notification_binding.dart';
import '../../features/presentation/notification/notification_page.dart';
import '../../features/presentation/salary/salary_binding.dart';
import '../../features/presentation/salary/salary_page.dart';
import '../../features/presentation/splash/splash_page.dart';

import '../../features/presentation/welcome/welcome_page.dart';

import '../../features/presentation/onboarding/onboarding_page.dart';

import '../../features/presentation/auth/pages/login_page.dart';

import '../../features/presentation/auth/auth_binding.dart';
import '../../features/presentation/auth/pages/signup_page.dart';
import '../../features/presentation/home/home_page.dart';
import '../../features/presentation/onboarding/onboarding_binding.dart';
import '../../features/presentation/profile/profile_binding.dart';
import '../../features/presentation/profile/profile_page.dart';
import '../../features/presentation/welcome/welcome_binding.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () =>  SplashPage(),
      // binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.welcome,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupPage(),
      binding: AuthBinding(),
    ),
    // Thêm các route khác ở đây
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.employees,
      page: () => EmployeesPage(),
      binding: EmployeesBinding(),
    ),
    GetPage(
      name: AppRoutes.attendance,
      page: () => AttendancePage(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.notification,
      page: () => NotificationPage(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.helpcenter,
      page: () => HelpcenterPage(),
      binding: HelpcenterBinding(),
    ),
    GetPage(
      name: AppRoutes.salary,
      page: () => SalaryPage(),
      binding: SalaryBinding(),
    ),
    GetPage(
      name: AppRoutes.employeebenefits,
      page: () => EmployeebenefitsPage(),
      binding: EmployeebenefitsBinding(),
    ),
    GetPage(
      name: AppRoutes.debt,
      page: () => DebtPage(),
      binding: DebtBinding(),
    ),
  ];
}
