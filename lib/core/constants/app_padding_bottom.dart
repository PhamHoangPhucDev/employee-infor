import 'package:flutter/material.dart';

class AppPaddingBottom {
  // Bottom Navigation Bar dimensions
  static const double bottomNavBarHeight = 80.0; // Chiều cao mặc định của BottomAppBar 80
  
  // Tính padding bottom động cho body - TỰ ĐỘNG CHO MỌI THIẾT BỊ
  static double getBottomPadding(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final safeAreaBottom = mediaQuery.padding.bottom;
    final viewInsets = mediaQuery.viewInsets.bottom; // Keyboard height
    
    // Nếu keyboard đang mở, không cần padding (keyboard tự xử lý)
    if (viewInsets > 0) {
      return 0;
    }
    
    // // BottomAppBar height + safe area bottom
    // // Safe area tự động = 0 cho thiết bị không có notch/gesture bar
    // return bottomNavBarHeight + safeAreaBottom;

     return safeAreaBottom;//safe area bottom cho từng page padding để navigation khỏi che
  }
  
  // Với khoảng cách thêm nếu cần (cho list có nhiều items)
  static double getBottomPaddingWithExtra(BuildContext context, {double extra = 16}) {
    return getBottomPadding(context) + extra;
  }
  
  // Debug: In ra thông tin thiết bị (optional - dùng để test)
  static void printDeviceInfo(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    print('=== DEVICE INFO ===');
    print('Screen size: ${mediaQuery.size}');
    print('Safe area top: ${mediaQuery.padding.top}');
    print('Safe area bottom: ${mediaQuery.padding.bottom}');
    print('View insets bottom: ${mediaQuery.viewInsets.bottom}');
    print('Calculated bottom padding: ${getBottomPadding(context)}');
    print('==================');
  }
}