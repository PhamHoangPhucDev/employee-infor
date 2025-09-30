import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'core/di/app_bindings.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // GetStorage được init trong AppBindings via putAsync, nhưng để đảm bảo có sẵn thì init trực tiếp:
  // await GetStorage.init(); // optional because AppBindings putAsync cũng init
  runApp(const EmployeePortalApp());
}

class EmployeePortalApp extends StatelessWidget {
  const EmployeePortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: AppTheme.lightTheme,
          initialRoute: AppRoutes.splash,
          initialBinding: AppBindings(),
          getPages: AppPages.pages,
        );
      }
    );
  }
}
