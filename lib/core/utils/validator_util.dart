import 'package:intl/intl.dart';

class ValidatorUtil {
  ValidatorUtil._(); // private constructor, không cho khởi tạo instance

  // Ngôn ngữ hiển thị: 'vi' hoặc 'en'
  static String? validateFullname(String? value, {int minLength = 2, int maxLength = 50, String lang = 'vi'}) {
    if (value == null || value.isEmpty) {
      return lang == 'vi' ? 'Họ tên không được để trống' : 'Fullname cannot be empty';
    }
    final regex = RegExp(r'^[a-zA-ZÀ-ỹ\s]+$');
    if (!regex.hasMatch(value) || value.length < minLength || value.length > maxLength) {
      return lang == 'vi' ? 'Họ tên không hợp lệ' : 'Fullname is invalid';
    }
    return null;
  }

  static String? validateEmail(String? value, {String lang = 'vi'}) {
    if (value == null || value.isEmpty) return lang == 'vi' ? 'Email không được để trống' : 'Email cannot be empty';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return lang == 'vi' ? 'Email không hợp lệ' : 'Email is invalid';
    return null;
  }

  static String? validateMobile(String? value, {String lang = 'vi'}) {
    if (value == null || value.isEmpty) return lang == 'vi' ? 'SĐT không được để trống' : 'Phone cannot be empty';
    final regex = RegExp(r'^0\d{9}$');
    if (!regex.hasMatch(value)) return lang == 'vi' ? 'SĐT không hợp lệ' : 'Phone is invalid';
    return null;
  }

  static String? validateBirthday(String? value, {int minAge = 18, String lang = 'vi'}) {
    if (value == null || value.isEmpty) return lang == 'vi' ? 'Ngày sinh không được để trống' : 'Birthday cannot be empty';
    try {
      final date = DateFormat('dd/MM/yyyy').parseStrict(value);
      final now = DateTime.now();

      if (date.isAfter(now)) return lang == 'vi' ? 'Ngày sinh không hợp lệ' : 'Invalid birthday';

      final age = now.year - date.year;
      if (age < minAge) return lang == 'vi' ? 'Tuổi phải từ $minAge trở lên' : 'Age must be at least $minAge';
    } catch (_) {
      return lang == 'vi' ? 'Ngày sinh không hợp lệ' : 'Invalid birthday';
    }
    return null;
  }


  static String? validatePassword(String? value, {int minLength = 4, String lang = 'vi'}) {
    if (value == null || value.isEmpty) return lang == 'vi' ? 'Mật khẩu không được để trống' : 'Password cannot be empty';
    if (value.length < minLength) return lang == 'vi' ? 'Mật khẩu phải ≥ $minLength ký tự' : 'Password must be at least $minLength characters';
    return null;
  }

  static String? validateConfirmPassword(String? value, String? confirmValue, {String lang = 'vi'}) {
    if (value != confirmValue) return lang == 'vi' ? 'Mật khẩu xác nhận không khớp' : 'Password confirmation does not match';
    return null;
  }
}
