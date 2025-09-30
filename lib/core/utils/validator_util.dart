class ValidatorUtil {
  ValidatorUtil._();

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email không được để trống";
    if (!value.contains("@")) return "Email không hợp lệ";
    return null;
  }
  
}
