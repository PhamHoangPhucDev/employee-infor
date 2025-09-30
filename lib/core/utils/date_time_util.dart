class DateTimeUtil {
  DateTimeUtil._();

  static String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
